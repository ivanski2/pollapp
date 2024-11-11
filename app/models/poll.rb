class Poll < ApplicationRecord
  has_many :options, dependent: :destroy
  validates :question, presence: true
  validate :must_have_options

  accepts_nested_attributes_for :options, allow_destroy: true

  private

  def must_have_options
    errors.add(:base, "You must provide at least one option.") if options.empty? || options.all? { |option| option.content.blank? }
  end
end
