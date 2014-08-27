module ApplicationHelper

  # TODO: TEST
  def form_panel(title, &block)
    internal_content = (block_given? ? capture(&block) : "")
    panel_title = content_tag(:h3, title, class: "panel-title")
    panel_heading = content_tag(:div, panel_title, class: "panel-heading")
    panel_body = content_tag(:div, internal_content, class: "panel-body")
    content_tag(:div, [panel_heading, panel_body].join.html_safe, class: "panel panel-primary")
  end#form_panel

  def method_label(method)
    css_class = case method
            when /get/i then "label-success"
            when /post/i then "label-primary"
            when /delete/i then "label-danger"
            when /put|patch/i then "label-warning"
            when /head|options/i then "label-info"
            else "label-default"
            end
    content_tag(:strong, "#{method}".upcase, class: "label #{css_class}")
  end#method_label

  def status_label(status_code)
    css_class = case status_code.to_i
                when (100..199) then "label-info"
                when (200..299) then "label-success"
                when (300..399) then "label-warning"
                when (400..499) then "label-danger"
                else "label-default"
                end
    content_tag(:strong, "#{status_code}", class: "label #{css_class}")
  end#status_label
end
