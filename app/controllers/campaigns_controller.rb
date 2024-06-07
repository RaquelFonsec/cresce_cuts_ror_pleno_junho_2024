class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  before_action :set_products, only: [:new, :edit, :create, :update]

  def index
    @campaigns = Campaign.all
  end

  def show
    
  end

  def new
    @campaign = Campaign.new
  end


  def create
    @campaign = current_user.campaigns.new(campaign_params)
    @campaign.status = :pending
  
    if @campaign.product
      @campaign.original_price = @campaign.product.price
    end
  
    if @campaign.save
      redirect_to @campaign, notice: 'A campanha foi criada com sucesso.'
    else
      @products = Product.all
      render :new
    end
  end
  
  def edit
    
  end

  def destroy
    @campaign = Campaign.find(params[:id])
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
    params.require(:campaign).permit(:title, :description, :start_date, :end_date, :product_id, :status, :original_price)
  end
end