# app/models/campaign.rb
class Campaign < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_one :discount, dependent: :destroy
  has_many :campaign_histories, dependent: :destroy
  accepts_nested_attributes_for :discount, allow_destroy: true

  has_one_attached :image

  validates_associated :discount
  validates :start_date, :end_date, :product_id, :status, presence: true
  validate :end_date_after_start_date

  enum status: { ativo: 0, expirado: 1 }

  before_create :set_initial_status
  before_destroy :destroy_campaign_histories
  before_save :calculate_discounted_price

  def original_price
    product.price
  end

  def calculate_discounted_price
    if discount.present? && discount.discount_type.present? && discount.discount_value.present?
      if discount.discount_type == 'percentual'
        self.discounted_price = product.price * (1 - discount.discount_value / 100.0)
      elsif discount.discount_type == 'fixo'
        self.discounted_price = product.price - discount.discount_value
      end
    else
      self.discounted_price = product.price
    end
  end

  def calculated_status
    if status == 'ativo'
      'Ativo'
    elsif start_date.future?
      'Agendado'
    elsif end_date.past?
      'Expirado'
    else
      'Ativo'
    end
  end

  private

  def end_date_after_start_date
    if end_date.present? && start_date.present? && end_date <= start_date
      errors.add(:end_date, "deve ser após a data de início")
    end
  end

  def set_initial_status
    self.status ||= :ativo
  end

  def destroy_campaign_histories
    campaign_histories.destroy_all
  end
end
