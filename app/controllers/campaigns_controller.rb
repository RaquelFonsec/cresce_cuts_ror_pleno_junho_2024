class CampaignsController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  before_action :load_products, only: [:new, :edit, :create, :update]

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
    @campaign = current_user.campaigns.build
    @products = Product.all 
  end
  
  def create
    @campaign = current_user.campaigns.build(campaign_params)
    build_discount 
  
    if @campaign.save
      redirect_to campaigns_path, notice: 'Campanha criada com sucesso.'
    else
      render :new
    end
  end
  

  
 

  def edit
    @campaign.build_discount unless @campaign.discount
  end

  def update
    @campaign = Campaign.find(params[:id])
    if @campaign.update(campaign_params)
      redirect_to @campaign, notice: 'Campanha atualizada com sucesso.'
    else
      render :edit
    end
  end

  
  def destroy
    @campaign.campaign_histories.destroy_all
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
  def build_discount
    discount_attributes = params.require(:campaign).require(:discount_attributes).permit(:discount_type, :discount_value)
    @campaign.build_discount(discount_attributes.merge(user_id: current_user.id))
  end

  def campaign_params
    params.require(:campaign).permit(:product_id, :description, :start_date, :end_date, :status, :image,
                                     discount_attributes: [:discount_type, :discount_value])
  end
end   