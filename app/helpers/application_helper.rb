module ApplicationHelper
  def owner_url(owner)
    "#{ENV.fetch('GITHUB_BASE_HTML_URL')}/#{owner}"
  end
end
