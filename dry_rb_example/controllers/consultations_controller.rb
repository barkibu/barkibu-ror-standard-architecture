class ConsultationsController
  def create params, current_petlover
    result = Consultations::Operations.AskConsultation.call(params, current_petlover)
    result.success do |operation_result|
      consultation, next_step = operation_result
      redirect_to build_redirect_url(consultation, next_step)
    end

    result.failure do |errors|
      errors
    end
  end

  private

  def build_redirect_url(consultation, result)
    case next_step
    when :urgent then urgent_url(consultation)
    when :ask_phone then ask_phone_url(consultation)
    else finish_url(consultation)
    end
  end

  def urgent_url(consultation)
    'urgent_url'
  end

  def ask_phone_url(consultation)
    'ask_phone_url'
  end

  def finish_url(consultation)
    'finish_url'
  end

  def redirect_to(url)
    url
  end
end
