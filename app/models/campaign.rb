
class Campaign < ApplicationRecord
  has_paper_trail
  belongs_to :user
  belongs_to :product
  has_one :discount, dependent: :destroy
  has_many :campaign_histories, dependent: :destroy
  has_one_attached :image
  has_many :discounts
  accepts_nested_attributes_for :discount

  validates :start_date, :end_date, :product_id, :status, presence: true
  validate :end_date_after_start_date

  enum status: { ativo: 0, expirado: 1 }

  before_create :set_initial_status
  before_destroy :destroy_campaign_histories
  before_save :calculate_discounted_price

  def calculate_discounted_price
    if discount.present?
      if discount.discount_type == 'percentual' && discount.discount_value.present?
        percentage = discount.discount_value.to_f / 100.0
        self.discounted_price = product.price * (1 - percentage)
      elsif discount.discount_type == 'fixo' && discount.discount_value.present?
        self.discounted_price = product.price - discount.discount_value.to_f
      else
        self.discounted_price = product.price
      end
    else
      self.discounted_price = product.price
    end
  end
  

  def original_price
    product.price
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

  def changes_for_paper_trail
    changes = {}
    if saved_changes.present?
      saved_changes.each do |attr, values|
        next if attr == 'updated_at' || attr == 'created_at'

        case attr
        when 'status'
          changes['Status'] = "#{Campaign.statuses[values[0]]} -> #{Campaign.statuses[values[1]]}"
        when 'start_date', 'end_date'
          changes[attr.capitalize] = "#{values[0].strftime('%d/%m/%Y')} -> #{values[1].strftime('%d/%m/%Y')}"
        end
      end
    end
    changes
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

