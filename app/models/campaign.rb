class Campaign < ApplicationRecord
    belongs_to :user
    belongs_to :product
    has_many :campaign_histories
    has_many :discounts
    has_one :discount
  
    validates :title, presence: true
    enum status: { ativo: 0, expirado: 1 }
  
    before_create :set_initial_status
    validate :end_date_after_start_date
  
    def activate
      update(status: :ativo)
      register_change
    end
  
    def expire
      update(status: :expirado)
      register_change
    end
  
    def discounted_price
      discount ? discount.discount_price : product.price
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
  
    def register_change
      campaign_histories.create(user_id: user_id, status: status, data_hora: Time.current)
    end
  
    def end_date_after_start_date
      return if end_date.blank? || start_date.blank?
  
      errors.add(:end_date, 'must be after start date') if end_date < start_date
    end
  end
  