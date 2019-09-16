class TambosController < InheritedResources::Base
  before_action :authenticate_user!
  
  private

    def tambo_params
      params.require(:tambo).permit(:name, :address, :phone_contact, :logo, :user_id)
    end

end
