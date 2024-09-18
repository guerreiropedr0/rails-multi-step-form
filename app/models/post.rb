class Post < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true, on: [ :create, :update, :step_2 ]
  validates :published_at, presence: true, on: [ :create, :update ]
end
