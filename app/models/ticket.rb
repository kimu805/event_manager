class Ticket < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :event

  # validation
  validates :text, length: { maximum: 30 }, allow_blank: true
end
