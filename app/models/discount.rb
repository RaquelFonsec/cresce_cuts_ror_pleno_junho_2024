class Discount < ApplicationRecord
  belongs_to :user
  belongs_to :campaign  

  has_many :campaign_histories, dependent: :destroy
  has_paper_trail

  validates :discount_type, presence: true
  validates :discount_value, presence: true
  after_update :record_history_callback

  private

  def record_history(user_email)
    last_campaign_id = campaign_id_was || campaign_id
    changes_description = changes.map { |attr, values| "#{attr} de '#{values[0]}' para '#{values[1]}'" }.join(", ")

    if changes_description.present?
      CampaignHistory.create(
        campaign_id: last_campaign_id,
        user_email: user_email,
        changes_description: changes_description
      )
    end
  end

  
  def record_history_callback
    user_email = 'Unknown user'
    user_id = PaperTrail.request.whodunnit

    if user_id
      user = User.find_by(id: user_id)
      user_email = user.email if user
    end

    record_history(user_email)
  end
end

