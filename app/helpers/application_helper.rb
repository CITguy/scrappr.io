module ApplicationHelper
  # @param [String] method HTTP Method
  # @return [String]
  def method_label(method)
    css_class = case method
            when /get/i then "label-success"
            when /post/i then "label-primary"
            when /put|patch/i then "label-warning"
            when /delete/i then "label-danger"
            when /head|options/i then "label-info"
            else "label-default"
            end
    content_tag(:strong, "#{method}".upcase, class: "label #{css_class}")
  end#method_label


  # @param [Integer] status_code HTTP Status Code
  # @return [String]
  def status_label(status_code)
    css_class = case status_code.to_i
                when (100..199) then "label-info"
                when (200..299) then "label-success"
                when (300..399) then "label-warning"
                when (400..499) then "label-danger"
                else "label-dark"
                end
    content_tag(:strong, "#{status_code}", class: "label #{css_class}")
  end#status_label


  # Wrapper for #user_api_endpoint_path
  #
  # @param [User] user
  # @param [Scrap] scrap
  def user_api_scrap_path(user, scrap)
    user_api_endpoint_path(user, scrap.endpoint)
  end#user_api_scrap_path


  # Wrapper for #user_api_endpoint_url
  #
  # @param [User] user
  # @param [Scrap] scrap
  def user_api_scrap_url(user, scrap)
    user_api_endpoint_url(user, scrap.endpoint)
  end#user_api_scrap_url
end
