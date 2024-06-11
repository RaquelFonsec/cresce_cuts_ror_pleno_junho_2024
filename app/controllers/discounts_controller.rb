class DiscountsController < ApplicationController
  before_action :set_campaign
  before_action :set_discount, only: [:update, :destroy]

  def new
    @discount = @campaign.discounts.new
  end

  def create
    @discount = @campaign.discounts.build(discount_params)
    @discount.user = current_user

    if @discount.save
      redirect_to campaign_path(@campaign), notice: 'Discount was successfully created.'
    else
      render 'campaigns/show'
    end
  end

  def update
    if @discount.update(discount_params)
      redirect_to campaign_path(@campaign), notice: 'Discount was successfully updated.'
    else
      render 'campaigns/show'
    end
  end

  def destroy
    @discount.destroy
    redirect_to campaign_path(@campaign), notice: 'Discount was successfully destroyed.'
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  def set_discount
    @discount = @campaign.discounts.find(params[:id])
  end

  def discount_params
    params.require(:discount).permit(:discount_type, :discount_value, :user_id)
  end
end
