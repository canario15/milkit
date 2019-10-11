module ApplicationHelper
  def status_color(status_id)
    color = case status_id
            when 1 then '#0FA20B'
            when 2 then '#221D8F'
            when 3 then '#ED2F15'
            when 4 then '#EDE515'
            else '#010101'
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
end
