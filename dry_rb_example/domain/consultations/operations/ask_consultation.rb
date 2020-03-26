require 'dry/monads'
require 'dry/monads/do'
require 'ostruct'
require './domain/consultations/contracts/ask_consultation_contract'

class Consultation < OpenStruct
  attr_reader :persisted

  def save
    @persisted = true
  end
end

class Petlover < OpenStruct
end

module Consultations
  module Operations
    class AskConsultation
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      # yield will unwrap Success monad returned by method
      # If Failure is returned method will return it right away
      # without processing rest of the pipeline
      def call(params, current_petlover)
        yield validate(params)
        petlover = find_or_create_petlover(params, current_petlover)
        consultation = yield persist_consultation(params, petlover)
        urgency = consultation_urgency(consultation)
        next_step = next_consultation_step(consultation, urgency)

        Success([consultation, next_step])
      end

      def validate(params)
        Contracts::AskConsultationContract.new.call(params).to_monad
      end

      def find_or_create_petlover(params, current_petlover)
        current_petlover || Petlover.new(email: params[:email])
      end

      def persist_consultation(params, petlover)
        consultation = Consultation.new(params.merge(petlover: petlover))
        consultation.save ? Success(consultation) : Failure(consultation.errors)
      end

      def consultation_urgency(consultation)
        'determined_urgency'
      end

      def next_consultation_step(consultation, urgency)
        'next_step'
      end
    end
  end
end
