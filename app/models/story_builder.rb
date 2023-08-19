# == Schema Information
#
# Table name: story_builders
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class StoryBuilder < ApplicationRecord
  # Associations
  has_many :questionnaires
  has_many :questions, through: :questionnaires
  has_many :stories, dependent: :destroy
end
