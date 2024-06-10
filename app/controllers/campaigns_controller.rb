class CampaignsController < ApplicationController
  before_action :set_campaign, only: %i[show edit update destroy]
  before_action :load_products, only: %i[new edit create update]

  def index
    @campaigns = Campaign.includes(:product, :discount).all
    @campaigns_with_dates = @campaigns.map do |campaign|
      {
        campaign: campaign,
        start_date: campaign.start_date,
        end_date: campaign.end_date
      }
    end
  end

  def show
    @campaign = Campaign.find(params[:id])
    @product = @campaign.product
    @original_price = @product.price
    @discounted_price = @campaign.discounted_price
    @status = @campaign.calculated_status
    @user = @campaign.user
    @created_at = @campaign.created_at
  end

  def new
    @campaign = Campaign.new
    @products = Product.all
  end

  def create
    @campaign = Campaign.new(campaign_params.merge(user_id: current_user.id))
    @campaign.start_date = params[:campaign][:start_date]
    @campaign.end_date = params[:campaign][:end_date]
  
    if discount_params_present?
      @discount = build_discount
    end
  
    if @discount.nil? || save_campaign_and_discount
      register_change(@campaign)
      redirect_to @campaign, notice: 'Campaign created successfully!'
    else
      render :new
    end
  end
  
  
  def edit
  end

  def destroy
    @campaign.destroy
    redirect_to campaigns_path, notice: 'Campaign was successfully deleted.'
  end

  def update
    if @campaign.update(campaign_params)
      redirect_to @campaign, notice: 'Campaign was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  def load_products
    @products = Product.all
  end

  def build_discount
    discount_attributes = params.require(:campaign).require(:discount_attributes).permit(:discount_type, :discount_value)
    @campaign.build_discount(discount_attributes.merge(user_id: current_user.id))
  end

  def campaign_params
    params.require(:campaign).permit(:start_date, :end_date, :product_id, :status, :image, discount_attributes: [:discount_type, :discount_value])
  end

  def discount_params_present?
    campaign_params[:discount_attributes].present?
  end

  def save_campaign_and_discount
    @campaign.save && (@discount.nil? || @discount.save)
  end

  def register_change(campaign)
    campaign.campaign_histories.create(user_id: campaign.user_id, status: campaign.status, data_hora: Time.current)
  end

  def discount_history
    @campaign = Campaign.find(params[:id])
    @discount_history = @campaign.discount_histories.order(occurred_at: :desc)
  end
end
