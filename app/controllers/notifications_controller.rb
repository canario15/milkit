# frozen_string_literal: true

# notifications controller
class NotificationsController < ApplicationController
  def index
    @notifications_unread = current_user.today_notification
    @notifications_read = current_user
                          .notifications
                          .read
                          .paginate(page: params[:page], per_page: 10)
  end

  def show
    @notification = current_user.notifications.find(params[:id])
    @notification.update(read: true)
  end

  def mark_unread
    @notification = current_user.notifications.find(params[:id])
    respond_to do |format|
      if @notification.update(read: false)
        format.html { redirect_to notifications_path, notice: 'La notificación se ha actualizado correctamente.' }
      else
        format.html { render :index }
      end
    end
  end
end
