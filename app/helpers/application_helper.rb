module ApplicationHelper
  BOOSTRAP_CLASSES = {
    success: "alert-success",
    error: "alert-danger",
    alert: "alert-warning",
    notice: "alert-info"
  }.stringify_keys.freeze

  def bootstrap_class_for(flash_type)
    BOOSTRAP_CLASSES.fetch(flash_type.to_s) { flash_type.to_s }
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat flash_message(msg_type, message)
    end
    nil
  end

  def flash_message(msg_type, message)
    content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissible fade show mt-2", role: "alert") do
      concat message
      concat content_tag(:button, close_alert, class: "close", data: { dismiss: 'alert' }, aria: { label: "Close" })
    end
  end

  def close_alert
    content_tag(:span, "&times;".html_safe, aria: { hidden: true })
  end
end
