class Idea < ApplicationRecord
  belongs_to :category, foreign_key: "categories_id"

  validates :categories_id, presence: true
  validates :body, presence: true
end
