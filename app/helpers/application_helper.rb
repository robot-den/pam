# :nodoc:
module ApplicationHelper
  # FIXME: IS IT NORMAL PLACE IT HERE?
  def take_categories
    Category.all
  end
end
