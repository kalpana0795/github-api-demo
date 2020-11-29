module ApplicationHelper
  def readable_date(date)
    DateTime.parse(date).strftime('%d %b %Y')
  end
end
