class Quote < ApplicationRecord
  has_many :alerts, dependent: :destroy
  belongs_to :asset

  validates :price, presence: true

  before_create do
    asset.last_quote.try(:update_attributes, { current: false })
    self.current = true
  end
end
