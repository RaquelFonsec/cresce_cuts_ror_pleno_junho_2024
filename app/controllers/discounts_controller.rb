class DiscountsController < ApplicationController
  before_action :set_discount, only: [:show, :edit, :update, :destroy, :diff]

 
  def index
    @discounts = current_user.discounts
  end

  
  def show
  end

  
  def new
    @discount = Discount.new
  end

  
  def edit
  end

  
  def create
    @discount = current_user.discounts.new(discount_params)

    respond_to do |format|
      if @discount.save
        format.html { redirect_to discounts_url, notice: "Discount was successfully created." }
        format.json { render :show, status: :created, location: @discount }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @discount.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def update
    respond_to do |format|
      if @discount.update(discount_params)
        format.html { redirect_to discounts_url, notice: "Discount was successfully updated." }
        format.json { render :show, status: :ok, location: @discount }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @discount.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def destroy
    @discount.destroy

    respond_to do |format|
      format.html { redirect_to discounts_url, notice: "Discount was successfully destroyed." }
      format.json { head :no_content }
    end
  end
 
  def history
    @campaign = Campaign.find(params[:campaign_id])
    @discount = @campaign.discount 
    @versions = @discount.versions
    user_ids = @versions.pluck(:whodunnit).uniq
    @users = User.where(id: user_ids).index_by(&:id)
    
  end

 
  
  def diff
    @version = PaperTrail::Version.find(params[:version_id])
    @diff = @version.diff(@version.next)
  end

  private
    
    def set_discount
      @discount = Discount.find(params[:id])
    end

    
    def discount_params
      params.require(:discount).permit(:discount_type, :discount_value, :status, :applied_by, :applied_at, :campaign_id)
    end
end
