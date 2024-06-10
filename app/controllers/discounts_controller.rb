class DiscountsController < ApplicationController
  before_action :set_campaign
  before_action :set_discount, only: %i[update destroy]

  
  def create
    @campaign = Campaign.find(params[:campaign_id])
    @discount = @campaign.discounts.build(discount_params)

    if @discount.save
      redirect_to @campaign, notice: 'Discount was successfully created.'
    else
      render :new
    end
  end


  def update
    if @discount.update(discount_params)
      record_discount_history("updated")
      redirect_to @campaign, notice: 'O desconto foi atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @discount.destroy
    record_discount_history("deleted")
    redirect_to @campaign, notice: 'O desconto foi excluído com sucesso.'
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  def set_discount
    @discount = @campaign.discounts.find(params[:id])
  end

  def discount_params
    params.require(:discount).permit(:discount_type, :discount_value, :status, :campaign_id, :user_id)
  end
  def record_discount_history(action)
    DiscountHistory.create(discount: @discount, user: current_user, action: action)
  end
end 
  
