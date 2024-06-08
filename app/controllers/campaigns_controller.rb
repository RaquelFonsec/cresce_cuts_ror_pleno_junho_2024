class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  before_action :set_products, only: [:new, :edit, :create, :update]

  def index
    @campaigns = Campaign.includes(:product, :discount).all
  end

  def show
    @campaign = Campaign.find(params[:id])
    @original_price = @campaign.product.price
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
    if @campaign.save
      register_change(@campaign)
      redirect_to @campaign, notice: 'Campaign created successfully!'
    else
      @products = Product.all
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

  def set_products
    @products = Product.all
  end

  def campaign_params
    params.require(:campaign).permit(:title, :description, :start_date, :end_date, :product_id, :status)
  end

  def register_change(campaign)
    campaign.campaign_histories.create(user_id: campaign.user_id, status: campaign.status, data_hora: Time.current)
  end
end
