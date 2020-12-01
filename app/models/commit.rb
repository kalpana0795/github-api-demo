class Commit
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :sha, :url, :message, :committer_date, :verified, :author, :author_url,
                :committer, :committer_url, :parents_sha

  validates_presence_of :sha, :url, :message

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end
