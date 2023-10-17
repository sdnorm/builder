class AddAiPromptToStoryBuilders < ActiveRecord::Migration[7.0]
  def default_system_ai_prompt
    "You are story creator. You have to generate stories in a concise format. "\
    "We're going to give you a set of responses that received from question answer session from users. "\
    "Data will be in the format of a hash like this: "\
    "{
      'question_1.title' => [
        { id: 'answer_1.id', response: 'question_1.answer_1', prompt: { pre_text: '', post_text: '' } },
        { id: 'answer_2.id', response: 'question_1.answer_2' }
      ],
    
      'question_2.title' => [
        { id: 'answer_1.id', response: 'question_2.answer_1' },
        { id: 'answer_2.id', response: 'question_2.answer_2' }
      ],
    
      'question_3.title' => [
        { id: 'answer_1.id', response: 'question_3.answer' }
      ]
    } "\
    "Few details about associations: "\
    "Each question can have multiple answers. "\
    "Each question can have multiple prompts to help user for answering the question. "\
    "Each prompt has a pre_text and post_text attribute. "\
    "If there are some specific instructions provided by the user regarding story voice tone and format. "\
    "Please cater them and supersede the first two lines of prompt."
  end

  def change
    reversible do |dir|
      dir.up do
        %i[system_ai_prompt admin_ai_prompt].each { |column| add_column(:story_builders, column, :text) }

        StoryBuilder.update_all(system_ai_prompt: default_system_ai_prompt)
      end

      dir.down do
        %i[system_ai_prompt admin_ai_prompt].each { |column| remove_column(:story_builders, column) }
      end
    end
  end
end
