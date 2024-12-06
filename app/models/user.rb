class User < ApplicationRecord
  before_destroy :check_all_events_finished

  # association
  has_many :created_events, class_name: "Event", foreign_key: "owner_id", dependent: :nullify
  has_many :tickets, dependent: :nullify
  has_many :participating_events, thorough: :tickets, source: :event

  private

  def check_all_events_finished
    now = Time.zone.now
    if created_events.where(":now < end_at", now: now).exists?
      errors[:base] << "公開中の未終了イベントが存在します"
    elsif participating_events.where(":now < end_at", now: now).exists?
      errors[:base] << "未終了の参加イベントが存在します"
    end

    throw(:abort) unless errors.empty?
  end
end
