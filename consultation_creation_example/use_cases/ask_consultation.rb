=begin
  Top level use case/interactor/action responsibility:
   - Be an orchestrator of business case flow
   - Authorize
   - Validate
   - Call other interactors/emit events

  It serves as an entry point to the application layer and defines a thing that application does.

  This example is not using any gem, but it could be benefitial to use one.
  It will provide standard approach on working with interactors. Here are some examples:
  - trailblazer
  - dry-transaction
  - interactor
  - light-service
  - active_interaction
  - mutations
=end

class AskConsultation
  def initialize(consultation_params: {}, current_petlover: nil)
  end

  # Method describes interaction flow composed of smaller actions/interactors
  # Good article on errors handling: https://fsharpforfunandprofit.com/rop/
  def call
    authorize_action
    validate_params
    create_consultation
    set_consultation_urgency
    update_vets_branding
    set_next_step
    trigger_event
  end

  def authorize_action
    fail unless AskConsultationPolicy.new.create?
  end

  def validate_params
    Consultations::Validators::CreateConsultationValidator.new(consultation_params).validate!
  end

  def create_consultation
    Consultations::Actions::CreateConsultation.new(consultation_params).call
  end

  def set_consultation_urgency
    Consultations::Actions::SetConsultationsUrgency.new(consultation).call
  end
end
