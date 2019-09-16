class CowsController < InheritedResources::Base
  
  before_action :authenticate_user!
  before_action :set_cow_and_tambos, only: %i[show edit update destroy]

  def new
    @tambos = current_user.tambos
    @cow = Cow.new
  end

  def create
    @cow = Cow.new(cow_params)
    @tambos = current_user.tambos
    respond_to do |format|
      if @cow.save
        format.html { redirect_to @cow, notice: 'Vaca creada con éxito.' }
      else
        format.html { render :new }
      end
    end
  end

  private

  def set_cow_and_tambos
    @cow = Cow.find(params[:id])
    @tambos = current_user.tambos
  end

  def cow_params
    params.require(:cow).permit(:caravan, :birth_date, :tambo_id, :status)
  end
end
