module ApplicationHelper
  def flash_class(level)
    case level
      when :notice then "alert-box radius secondary"
      when :success then "alert-box radius success"
      when :error then "alert-box radius alert"
      when :alert then "alert-box radius alert"
    end
  end

  def page_title(title = nil)
    if title
      content_for(:page_title) { title }
    else
      content_for?(:page_title) ? content_for(:page_title) : t("common.app_name")
    end
  end
end
