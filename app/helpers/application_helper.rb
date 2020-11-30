module ApplicationHelper
  def readable_date(date)
    DateTime.parse(date).strftime('%d %b %Y at %T UTC')
  end

  def owner_url(owner)
    "#{ENV.fetch('GITHUB_BASE_HTML_URL')}/#{owner}"
  end
end
