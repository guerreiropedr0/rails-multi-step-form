class Post < ApplicationRecord
  validates :published_at, presence: true

  def step_valid?(step)
    case step
    when 1
      errors.add(:title, "can't be blank") and return false unless title.present?
    when 2
      errors.add(:description, "can't be blank") and return false unless description.present?
    else
      return false
    end

    true
  end
end
