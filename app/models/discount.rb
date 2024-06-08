class Discount < ApplicationRecord
  belongs_to :campaign
  belongs_to :user, optional: true

  enum status: { pending: 0, active: 1, expired: 2 }
  validates :discount_type, presence: true, inclusion: { in: ['De', 'Por'] }
  validates :discount_value, presence: true, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: statuses.keys }

  before_validation :set_default_status, on: :create
  before_create :set_applied_info

  def set_default_status
    self.status ||= :active
  end

  def set_applied_info
    if user.present?
      self.applied_by = user.id
      self.applied_at = Time.current
    end
  end

  def discount_price
    return 0 unless campaign && campaign.product
    case discount_type
    when 'De'
      campaign.product.price - discount_value
    when 'Por'
      campaign.product.price * (1 - discount_value.to_f / 100.0)
    else
      0
    end
  end
end