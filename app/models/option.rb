class Option < ApplicationRecord
  belongs_to :poll
  has_many :votes, dependent: :destroy
  validates :content, presence: true
end
