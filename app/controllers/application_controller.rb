class ApplicationController < ActionController::API

  # pattern to catch problems where strong parameters might throw exception if the post data isnt even present
  # in case we care about this case
  rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
    errors = []

    errors << { parameter_missing_exception.param => ['missing required data for entity'] }

    render json: { errors: errors }, status: :unprocessable_entity
  end
end
