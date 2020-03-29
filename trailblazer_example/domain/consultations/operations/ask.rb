require 'trailblazer'
require './domain/consultations/contracts/ask.rb'

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
    class Ask < Trailblazer::Operation
      step Model(Consultation, :new)
      step Contract::Build( constant: Consultations::Contracts::Ask )
      step Contract::Validate()
      step :find_or_create_petlover
      step Contract::Persist()
      step :set_consultation_urgency
      step :set_next_consultation_step
      step :trigger_event

      def find_or_create_petlover(options, current_petlover:, params:, **)
        # Returning false from any of the steps will mark result as failed
        options['result.petlover'] = current_petlover || Petlover.new(email: params[:email])
      end

      def set_consultation_urgency(options, **)
        options['result.urgency'] = 'determined_urgency'
      end

      def set_next_consultation_step(options, **)
        options['result.next_step'] = 'determined_next_step'
      end

      def trigger_event(options, **)
        options['result.pub_sub'] = 'triggered_event'
      end
    end
  end
end
