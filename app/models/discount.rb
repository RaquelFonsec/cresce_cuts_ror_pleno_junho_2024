class Discount < ApplicationRecord
  belongs_to :campaign
  belongs_to :user

  enum status: { pending: 0, active: 1, expired: 2 }
  enum discount_type: { fixed: 'fixed', percentage: 'percentage' }
  validates :discount_type, inclusion: { in: %w[fixed percentage] }
  validates :discount_value, :status, presence: true
  validates :status, inclusion: { in: statuses.keys }

  before_validation :set_default_status
  before_create :set_applied_info

  def discount_price
    return 0 unless campaign&.product

    case discount_type
    when 'De'
      [campaign.product.price - discount_value, 0].max
    when 'Por'
      campaign.product.price * (1 - discount_value.to_f / 100)
    else
      campaign.product.price
    end
  end

  private

  def set_default_status
    self.status ||= :active
  end

  def set_applied_info
    if user.present?
      self.applied_by = user.id
      self.applied_at = Time.current
    end
  end
end
