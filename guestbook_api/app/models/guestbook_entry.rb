class GuestbookEntry < ApplicationRecord
  scope :recent_non_spam, -> { where(is_spam: false).order(created_at: :desc).limit(50) }

  validates :name, presence: true
  validates :message, presence: true
end
