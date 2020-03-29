require 'reform/form/dry'

module Consultations
  module Contracts
    class Ask < Reform::Form
      feature Reform::Form::Dry

      property :pet_name
      property :email
      collection :symptoms

      validation do
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
end
