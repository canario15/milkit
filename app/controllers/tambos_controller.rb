class TambosController < InheritedResources::Base

  before_action :authenticate_user!
  before_action :set_tambo, only: %i[show edit update destroy]

  def index
    @tambos = current_user.tambos
  end

  def create
    @tambo = Tambo.new(tambo_params.merge(user_id: current_user.id))
    if @tambo.save
      redirect_to @tambo
    else
      render 'new'
    end
  end

  def show
    @vacas = @tambo.cows.vacas
    @vaquillonas = @tambo.cows.vaquillonas
    @cow = Cow.new
  end

  private

  def set_tambo
    @tambo = current_user.tambos.find(params[:id])
  end

  def tambo_params
    params.require(:tambo).permit(:name,
                                  :address,
                                  :phone_contact,
                                  :map_position,
                                  :user_id,
                                  :logo)
  end
end
