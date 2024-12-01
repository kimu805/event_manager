class User < ApplicationRecord
  # association
  has_many :created_events, class_name: "Event", foreign_key: "owner_id"
  has_many :tickets
end
