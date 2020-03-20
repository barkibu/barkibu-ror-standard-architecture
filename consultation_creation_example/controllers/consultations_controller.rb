=begin
  Controller responsibility
   - Adapt request params, session to be acceptable by use case(AskConsultation)
   - Instantiate use case/interactor and provide it with required params
   - Provide a response to the user based on the result returned by interactor
=end

class ConsultationsController < ApplicationController
  # Actions that don't mutate state(GET requests) call repository objects
  def index
    @consultations = Consultations::Repositories::ConsultationRepository.for_index_page
  end

  # Actions that can will state call use cases
  def create
    result = AskConsultation.call(consultation_params: consultation_params, petlover: current_petlover)
    if result.success?
      redirect_to build_redirect_url(result)
    else
      render json: { errors: result.error_messages }
    end
  end

  private

  def build_redirect_url(result)
    case result.next_step
      when :urgent then urgent_url
      when :ask_phone then ask_phone_url
      else finish_url
    end
  end

  def consultation_params
    params.permit(:email, :symptoms, :pet_name)
  end
end
