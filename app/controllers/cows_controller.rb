class CowsController < InheritedResources::Base

  before_action :authenticate_user!
  before_action :set_cow_and_tambos, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token

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
        format.json { render json: { status: 'OK', message: 'Vaca creada con éxito.', cow: @cow.to_json } }
      else
        format.html { render :new }
        format.json { render json: { status: 'ERROR', errors: @cow.errors.messages } }
      end
    end
  end

  def show
    @event = Event.new(cow_id: @cow.id)
  end

  def search_cow
    @tambo = current_user.tambos.find(params[:tambo_id])
    @cow = @tambo.cows.unscoped.find_by(caravan: params[:caravan])
    respond_to do |format|
      if @cow.nil?
        format.html { redirect_to tambo_path(@tambo.id), notice: 'No existe esa caravana' }
        format.json { render json: { errors: 'No se encontro vaca' } }
      else
        format.html { redirect_to cow_path(@cow.id) }
        format.json { render json: { status: 'OK' } }
      end
    end
  end

  private

  def set_cow_and_tambos
    @cow = Cow.find(params[:id])
    @tambos = current_user.tambos
  end

  def cow_params
    params.require(:cow).permit(
      :caravan,
      :birth_date,
      :tambo_id,
      :status,
      :cow_type
    )
  end
end
