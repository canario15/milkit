# frozen_string_literal: true

# describe tambo controller
class TambosController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :set_tambo, only: %i[show edit update destroy]

  def index
    @tambos = current_user.tambos
  end

  def create
    @tambo = Tambo.new(tambo_params.merge(user_id: current_user.id))
    respond_to do |format|
      if @tambo.save
        format.html { redirect_to @tambo, notice: 'Tambo creado con éxito.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @tambo.update(tambo_params)
        format.html { redirect_to @tambo, notice: 'El tambo se ha actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @tambo }
      else
        format.html { render :edit }
        format.json { render json: @tambo.errors, status: :unprocessable_entity }
      end
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
