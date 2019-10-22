# frozen_string_literal: true

# Event controller
class EventsController < InheritedResources::Base
  before_action :set_event, only: %i[show edit update destroy]

  def create
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event.cow, notice: 'Evento creado con éxito.' }
        format.json { render json: { status: 'OK', message: 'Evento creada con éxito.', event: @event.to_json } }
      else
        format.html { render :new }
        format.json { render json: { status: 'ERROR', errors: @event.errors.messages } }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event.cow, notice: 'El evento actualizado correctamente.' }
        format.json { render json: { status: 'OK', message: 'Evento actualizado con éxito.', event: @event.to_json } }
      else
        format.html { render :edit }
        format.json { render json: { status: 'ERROR', errors: @event.errors.messages } }
      end
    end
  end

  def destroy
    cow = @event.cow
    respond_to do |format|
      if cow.events.count == 1
        format.html { redirect_to cow, notice: 'No se puede eliminar el primer evento' }
      else
        @event.destroy
        format.html { redirect_to cow, notice: 'Se ha eliminado correctamente el evento.' }
      end
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
      :cow_id,
      :date_event,
      :action,
      :bull,
      :notification,
      :observations
    )
  end
end
