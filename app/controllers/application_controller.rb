# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit

  def after_sign_in_path_for(resource)
    campaigns_path
  end


  private

  def set_paper_trail_whodunnit
    PaperTrail.request.whodunnit = current_user.id if user_signed_in?
  end
end 
  