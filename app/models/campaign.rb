class Campaign < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_one :discount, dependent: :destroy
  has_many :discounts, dependent: :destroy
  has_many :campaign_histories, dependent: :destroy
  has_one :discount
  has_one_attached :image

  accepts_nested_attributes_for :discounts, allow_destroy: true
  validates :start_date, :end_date, :product_id, :status, presence: true
  validate :end_date_after_start_date
  enum status: { ativo: 0, expirado: 1,}
 

  before_create :set_initial_status
  before_destroy :destroy_campaign_histories

  def original_price
    product.price
  end

  def discounted_price
    discount&.discount_price || product.price
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

  def set_initial_status
    self.status ||= :ativo
  end

  def register_change(new_status)
    campaign_histories.create(user_id: user_id, status: new_status, data_hora: Time.current)
  end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    errors.add(:end_date, 'must be after start date') if end_date < start_date
  end

  def product_name_presence
    return unless product.blank?  
    errors.add(:product_id, 'product must be present')
  end

  def destroy_campaign_histories
    campaign_histories.destroy_all
  end
end 
