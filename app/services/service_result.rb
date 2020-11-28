class ServiceResult
  attr_reader :data, :errors

  def initialize(data: nil, errors: [])
    @data = data
    @errors = errors
  end

  def success?
    errors.blank?
  end

  def error_messages
    errors.map { |error| error.to_s.humanize }
  end
end
