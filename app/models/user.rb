class User < ActiveRecord::Base
  VALID_REGEX = /\A[a-z\d\-]+\z/i
  validates :name, presence: true, format: { with: VALID_REGEX }, length: { maximum: 39 }

  before_save { self.name = name.downcase }

  enum status: [ :wait, :in_progress, :completed, :error, :not_found ]

  scope :by_created_at, -> { order(created_at: :desc) }

  scope :by_rating1, -> { where(status: :completed).order(rating1: :desc) }
  scope :by_rating2, -> { where(status: :completed).order(rating2: :desc) }

  scope :limited, -> { limit(Settings.n) }
end
