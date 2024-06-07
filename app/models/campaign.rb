class Campaign < ApplicationRecord
    has_many :discounts, dependent: :nullify
    belongs_to :user
    belongs_to :product
    
    attr_accessor :discount_rate
    enum status: { active: 0, expired: 1, pending: 2 }
  
    STATUSES = statuses.keys.freeze
  
    validates :title, :description, :start_date, :end_date, :product_id, presence: true
    validate :end_date_after_start_date
  
    before_save :calculate_discounted_price
    before_create :set_initial_status
    after_save :update_discounts_status
  
    def calculate_discounted_price
      if product.present?
        original_price = product.price
        self.discount_rate = 0.2
        discount_amount = original_price * discount_rate
        self.discounted_price = original_price - discount_amount
      end
    end
  
    def set_initial_status
      self.status ||= :pending
    end
  
    def update_discounts_status
      new_status = calculate_status
      return if self.status == new_status
      discounts.update_all(status: new_status)
    end
  
    def calculate_status
      if start_date.present? && end_date.present?
        if Date.current.between?(start_date, end_date)
          :active
        elsif Date.current > end_date
          :expired
        else
          :pending
        end
      else
        :pending
      end
    end
  
    private
  
    def end_date_after_start_date
      errors.add(:end_date, "must be after start date") if end_date.present? && start_date.present? && end_date <= start_date
    end
  end
  