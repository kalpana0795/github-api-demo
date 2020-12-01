class CommitDecorator < Draper::Decorator
  delegate_all

  def shortened_sha
    sha[..6]
  end

  def readable_date
    DateTime.parse(committer_date).strftime('%d %b %Y at %T UTC')
  end
end
