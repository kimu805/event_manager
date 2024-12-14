class Event < ApplicationRecord

  attr_accessor :remove_image

  # association
  belongs_to :owner, class_name: "User"
  has_many :tickets, dependent: :destroy
  has_one_attached :image, dependent: false
  
  # validation
  with_options presence:true do
    validates :name, length: { maximum: 50 }
    validates :place, length: { maximum: 100 }
    validates :content, length: { maximum: 2000 }
    validates :start_at
    validates :end_at
  end
  validates :image, content_type: ['image/png', 'image/jpg', 'image/jpeg']
  validate :start_at_should_be_before_end_at

  # scope
  scope :future, -> { where( ":now < start_at", now: Time.zone.now ) }
  scope :start_at_order, -> { order("start_at")}

  # callback
  before_save :remove_image_if_user_accept

  private

  def start_at_should_be_before_end_at
    return unless start_at && end_at

    if start_at >= end_at
      errors.add(:start_at, "は終了時間よりも前に設定してください")
    end
  end

  def remove_image_if_user_accept
    self.image = nil if ActiveRecord::Type::Boolean.new.cast(remove_image)
  end
end
