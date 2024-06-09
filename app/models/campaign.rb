class Campaign < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :campaign_histories, dependent: :destroy
  has_many :discounts
  has_one :discount, dependent: :destroy
  has_one_attached :image
  attr_accessor :discount_type
  validates :title, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :user_id, presence: true
  validates :product_id, presence: true

  validate :calculate_discounted_price
  validate :end_date_after_start_date

  enum status: { ativo: 0, expirado: 1 }

  before_create :set_initial_status
  accepts_nested_attributes_for :discount

  def activate
    update(status: :ativo)
    register_change
  end

  def expire
    update(status: :expirado)
    register_change
  end

  def original_price
    product.price
  end

  def discounted_price
    discount.present? ? discount.discount_price : product.price
  end

  def calculated_status
    if start_date > Date.current
      'Agendado'
    elsif end_date < Date.current
      'Expirado'
    else
      'Ativo'
    end
  end

  private

  def set_initial_status
    self.status ||= :ativo
  end

  def calculate_discounted_price
    return unless discount.present? && discounted_price.nil?

    errors.add(:discounted_price, "can't be nil when a discount is present")
  end

  def register_change
    campaign_histories.create(user_id:, status:, data_hora: Time.current)
  end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    errors.add(:end_date, 'must be after start date') if end_date < start_date
  end
end
