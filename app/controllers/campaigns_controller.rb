class CampaignsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  before_action :load_products, only: [:new, :edit, :create, :update]

  def index
    @campaigns = Campaign.includes(:product, :discount).all
  end

  def show
    @versions = @campaign.discount.versions if @campaign.discount.present?
  end

  def new
    @campaign = current_user.campaigns.build
    @products = Product.all
    @campaign.build_discount  
  end

  def create
    @campaign = current_user.campaigns.build(campaign_params)
    build_discount

    if @campaign.save
      redirect_to campaigns_path, notice: 'Campanha criada com sucesso.'
    else
      @products = Product.all  
      render :new
    end
  end

  def edit
    @products = Product.all
    @campaign.build_discount unless @campaign.discount
  end

  def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        format.html { redirect_to @campaign, notice: 'Campanha atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @campaign }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end 

  def destroy
    @campaign.destroy
    redirect_to campaigns_path, notice: 'Campanha excluída com sucesso.'
  end


  private

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  def load_products
    @products = Product.all
  end

  def build_discount
    if params[:campaign][:discount_attributes].present?
      discount_attributes = params.require(:campaign).require(:discount_attributes).permit(:discount_type, :discount_value)
      @campaign.build_discount(discount_attributes.merge(user_id: current_user.id))
    end
  end

  def campaign_params
    params.require(:campaign).permit(:product_id, :description, :start_date, :end_date, :status, :image,
                                     discount_attributes: [:id, :discount_type, :discount_value, :discount_amount])
  end
  def discount_params
    params.require(:discount).permit(:discount_type, :discount_value)
  end
end