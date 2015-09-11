module ApplicationHelper
  def options_for_product_reviews(selected = nil)
    options_for_select((1..5).map {|num| [pluralize(num, "Star"), num]}, selected)
  end

  def options_for_quantities(selected = nil)
    options_for_select((1..9), selected)
  end

  def dollars(cents)
    dollars = cents.to_f/100
    "$ #{dollars}"
  end

  def display_datetime(dt)
    dt = dt.in_time_zone('Eastern Time (US & Canada)')
    dt.strftime("%m/%d/%Y %l:%M%P %Z")
  end
end
