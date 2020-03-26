require 'dry-validation'

Dry::Validation.load_extensions(:monads)

module Consultations
  module Contracts
    class AskConsultationContract < Dry::Validation::Contract
      params do
        required(:pet_name).filled
        required(:email).filled

        required(:symptoms).array(:hash) do
          required(:name).filled(:string)
        end
      end
    end
  end
end
