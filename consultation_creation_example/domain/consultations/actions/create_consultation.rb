module Consultations
  module Actions
    class CreateConsultation
      def call
        Consultation.create!(consultation_params)
      end
    end
  end
end
