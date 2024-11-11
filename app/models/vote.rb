class Vote < ApplicationRecord
  belongs_to :poll
  belongs_to :option
  validates :user_identifier, uniqueness: { scope: :poll_id }
end
