
class CampaignsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_campaign, only: %i[show edit update destroy]
  before_action :load_products, only: %i[new edit create update]

  def index
    @campaigns = Campaign.all
  end

  def show
    @product = @campaign.product
    @user = @campaign.user
    @created_at = @campaign.created_at
    @discounted_price = @campaign.discounted_price
    @status = @campaign.calculated_status
    @discount = @campaign.discount
    @campaign_histories = @campaign.campaign_histories
  end

  def new
    @campaign = Campaign.new
  end
  
  def create
    @campaign = current_user.campaigns.build(campaign_params)
    @campaign.discount.user = current_user # Associando o usuário atual ao desconto
    if @campaign.save
      redirect_to campaigns_path, notice: 'Campaign created successfully!'
    else
      render :new
    end
  end
  
  
  
  def edit
    @campaign = Campaign.find(params[:id])
    @products = Product.all
  end

  def update
    @campaign = Campaign.find(params[:id])
    if @campaign.update(campaign_params.except(:original_price))
      redirect_to campaign_path(@campaign), notice: 'Campaign updated successfully!'
    else
      logger.error "Error updating campaign: #{@campaign.errors}"
      render :edit
    end
  end

 

  def destroy
    @campaign.destroy
    redirect_to campaigns_path, notice: 'Campaign was successfully deleted.'
  end

  private

  def valid_status?(status)
    Campaign.statuses.key?(status)
  end

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  def load_products
    @products = Product.all
  end
  def campaign_params
    params.require(:campaign).permit(
      :product_id, 
      :description, 
      :start_date, 
      :end_date, 
      :status, 
      :image,
      discount_attributes: [:id, :discount_type, :discount_value]
    )
  
  end 
end 