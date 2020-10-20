class HomeController < ApplicationController
  def index
    @promotions = Promotion.all
    render 'promotions/index' if user_signed_in?
  end
end
