require 'rspec'
require './domain/consultations/operations/ask.rb'

RSpec.describe Consultations::Operations::Ask do
  let(:result) { described_class.call(params: params, current_petlover: current_petlover) }
  let(:current_petlover) { nil }
  let(:params) { { } }
  let(:valid_params) { { email: 'email', pet_name: 'snoopy', symptoms: [{ name: 'bark' }] } }

  describe 'validations' do
    subject { result['contract.default'].errors.messages }

    it { expect(subject.keys).to include(:email, :pet_name, :symptoms) }

    context 'with valid params' do
      let(:params) { valid_params }

      it { expect(subject.keys).to be_empty }
    end
  end

  describe 'operation result' do
    let(:params) { valid_params }

    subject { result }

    it 'sets the petlover' do
      expect(result['result.petlover']).to be_instance_of(Petlover)
    end

    it 'is successful' do
      expect(result).to be_success
    end

    context 'with invalid params' do
      let(:params) { {} }

      it 'is not successful' do
        expect(result).to be_failure
      end
    end
  end
end
