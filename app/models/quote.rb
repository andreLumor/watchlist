class Quote < ApplicationRecord
  has_many :alerts, dependent: :destroy
  belongs_to :asset

  validates :price, presence: true

  before_create do
    if asset.last_quote
      asset.last_quote.update(current: false)
      self.current = true
    else
      self.current = true
    end
  end
end
