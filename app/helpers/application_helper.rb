module ApplicationHelper
  def status_color(status_id)
    color = case status_id
            when 1 then '#0FA20B'
            when 2 then '#221D8F'
            when 3 then '#ED2F15'
            when 4 then '#EDE515'
            when 5 then '#010101'
            else '#BD12B3'
            end
    style_colors(color)
  end

  def style_colors(color)
    "<style>
      .status-color { color: #{color};
                      border-bottom: 1px solid #{color}; }
      .border-status { border-color: #{color} !important; }
      .edit-btn-cust { background-color:#{color};
                       border-color: #{color};}
    </style>"
  end

  def flash_notifications
    message = flash[:alert] || flash[:notice]
    return if message

    type = flash.keys[0].to_s
    if type == 'alert'
      "<p id='have_alert' data-type='error'>#{flash[:alert]}</p>".html_safe
    elsif type == 'notice'
      "<p id='have_alert' data-type='success'>#{flash[:notice]}</p>".html_safe
    end
  end

  def check_notifications
    return 'today-notifications' if current_user.today_notification.count.positive?
  end
end
