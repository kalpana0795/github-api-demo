class BaseService
  def initialize
    @errors = []
    @data = {}
  end

  def call
    begin
      call!
    rescue StandardError => e
      handle_unhandled_error(e)
    end

    build_service_result
  end

  private

  attr_reader :errors, :data

  def call!
    raise NotImplementedError, 'subclasses must implement'
  end

  def handle_unhandled_error(error)
    errors << error
    Rails.logger.info error
  end

  def build_service_result
    ServiceResult.new(data: data, errors: errors)
  end
end
