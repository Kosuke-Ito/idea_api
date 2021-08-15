class Idea < ApplicationRecord
  belongs_to :category, foreign_key: "category_id"

  validates :category_id, presence: true
  validates :body, presence: true
end
