class CampaignsController < ApplicationController
  before_action :set_campaign, only: %i[show edit update destroy]
  before_action :load_products, only: %i[new edit create update]

  def index
    @campaigns = Campaign.includes(:product, :discount).all
  end

  def show
    @product = @campaign.product
    @user = @campaign.user
    @created_at = @campaign.created_at
    @discounted_price = @campaign.discounted_price
    @status = @campaign.calculated_status
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(campaign_params.merge(user_id: current_user.id))

    # Atribuir user_id ao desconto se existir
    if @campaign.discount
      @campaign.discount.user = current_user
    end

    if @campaign.save
      register_change(@campaign)
      redirect_to @campaign, notice: 'Campaign created successfully!'
    else
      load_products
      render :new
    end
  end

  def edit
  end

  def update
    if @campaign.update(campaign_params)
      redirect_to @campaign, notice: 'Campaign was successfully updated.'
    else
      load_products
      render :edit
    end
  end

  def destroy
    @campaign.destroy
    redirect_to campaigns_path, notice: 'Campaign was successfully deleted.'
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  def load_products
    @products = Product.all
  end

  def campaign_params
    params.require(:campaign).permit(:start_date, :end_date, :product_id, :status, :image, discount_attributes: [:discount_type, :discount_value])
  end

  def register_change(campaign)
    campaign.campaign_histories.create(user_id: campaign.user_id, status: campaign.status, data_hora: Time.current)
  end
end
