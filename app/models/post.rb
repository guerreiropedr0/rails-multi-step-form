class Post < ApplicationRecord
  validates :title, :description, :published_at, presence: true

  def step_valid?(step)
    case step
    when 1
      valid_attributes?(:title)
    when 2
      valid_attributes?(:title, :description)
    else
      super
    end
  end

  def valid_attributes?(*attributes)
    self.errors.clear

    attributes.each do |attribute|
      self.class.validators_on(attribute).each do |validator|
        validator.validate_each(self, attribute, send(attribute))
      end
    end

    errors.none?
  end
end
