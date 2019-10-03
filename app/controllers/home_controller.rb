class HomeController < ApplicationController

  def index
    if current_user
      redirect_to tambos_path
    else
      render layout: false
    end
  end
end
