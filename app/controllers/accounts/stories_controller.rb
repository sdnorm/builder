class Accounts::StoriesController < Accounts::BaseController
  before_action :authenticate_user!
  before_action :set_story, only: [:show, :edit, :update, :destroy, :update_visibility]
  before_action :set_account, only: :update_visibility
  before_action :require_account_admin, only: :update_visibility

  def index
    # Fetch organization stories that are shared by the organization admin
    org_stories = current_account.stories.includes(:story_builder, :creator).publicized
    @admin_logged_in = current_account_user.roles.include?("admin")
    @pagy_1, @org_stories = pagy(@admin_logged_in ? org_stories : org_stories.viewable, items: 10)

    # Fetch stories that are created by the logged in organization admin/member
    @pagy_2, @my_stories = pagy(Story.includes(:story_builder, :creator).where(creator_id: current_user.id), items: 10)
  end

  def create
    @story = current_account.stories.new(story_params)
    @story.creator_id = current_user.id

    if @story.save
      redirect_to(edit_account_story_path(@story, account_id: current_account.id), notice: "Your story has been created!")
    else
      redirect_to(story_builders_path, alert: "Unable to create story. Errors: #{@story.errors.full_messages.join(", ")}")
    end
  end

  def edit
    @my_stories = Story.where(creator_id: current_user.id).limit(5)
    @questions = @story.story_builder.questions

    if @questions.empty?
      redirect_to(account_stories_path, alert: "Your chosen story builder has no associated questions!")
    else
      @question = @questions.order(position: :asc).first
      @prompts = @question.prompts.order(created_at: :asc)
      @prompt = @prompts.first
    end
  end

  def update
    respond_to do |format|
      format.json do
        if params[:change_access_mode] == "on"
          @story.toggle!(:private_access)

          render json: {private_access: @story.private_access, operation: "change_access_mode"}
        elsif params[:draft_mode] == "on"
          @story.draft!

          render json: {status: @story.status.to_s, operation: "draft_mode"}
        end
      end
    end
  end

  def question_navigation
    story_builder = StoryBuilder.find(params[:story_builder_id])
    @question = story_builder.questions.order(position: :asc)[params[:q_index].to_i]

    respond_to do |format|
      format.json do
        if @question.nil?
          render json: {question_id: nil, question_title: nil, success: false}
        else
          render json: {question_id: @question.id, question_title: @question.title, success: true}
        end
      end
    end
  end

  def prompt_navigation
    # TODO: Shorten the scope by querying the questions of story object
    question = Question.find(params[:id])
    @prompt = question.prompts[params[:index].to_i]

    respond_to do |format|
      format.json do
        if @prompt.nil?
          render json: {prompt_id: nil, prompt_pretext: nil, prompt_posttext: nil, count: nil, success: false}
        else
          render json: {prompt_id: @prompt.id, prompt_pretext: @prompt.pre_text, prompt_posttext: @prompt.post_text, count: question.prompts.count, success: true}
        end
      end
    end
  end

  # GET stories/:story_builder_id/question/:id/nodes
  def question_nodes
    story_builder = StoryBuilder.find(params[:story_builder_id])
    question = story_builder.questions.find(params[:id])
    @parent_nodes = question.parent_nodes.map { |node| [node.title, node.id] }

    respond_to do |format|
      format.json do
        render json: {parent_nodes: @parent_nodes, success: true}
      end
    end
  end

  # GET /question/:id/nodes/:node_id/sub_nodes
  def sub_nodes_per_node
    question = Question.find(params[:id])
    node = question.parent_nodes.find(params[:node_id])
    @child_nodes = node.child_nodes.map { |node| [node.title, node.id] }

    respond_to do |format|
      format.json do
        render json: {child_nodes: @child_nodes, success: true}
      end
    end
  end

  def track_answers
    question = Question.find(params[:id])
    @answer = question.answers.new(story_id: params[:story_id], response: params[:response])

    respond_to do
      format.json do
        if @answer.save
          render json: {answer: @answer, success: true}
        else
          render json: {answer: nil, success: false}
        end
      end
    end
  end

  def update_visibility
    respond_to do |format|
      format.json do
        if @story.toggle!(:viewable)
          render json: { viewable: @story.viewable, success: true }
        else
          render json: { viewable: nil, success: false }
        end
      end
    end
  end

  private

  def story_params
    params.require(:story).permit(:title, :story_builder_id)
  end

  def set_story
    @story = Story.find(params[:id])
  end

  def set_account
    @account = current_account    
  end
end
