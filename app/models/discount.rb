

class Discount < ApplicationRecord
  belongs_to :user
  belongs_to :campaign
  has_many :campaign_histories, dependent: :destroy
  
  has_paper_trail  

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
    user_email = PaperTrail.request.whodunnit ? User.find(PaperTrail.request.whodunnit).email : 'Unknown user'
    record_history(user_email)
  end
end
