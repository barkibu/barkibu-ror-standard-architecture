require './domain/consultations/operations/ask_consultation'

RSpec.describe Consultations::Operations::AskConsultation do
  subject(:result) { described_class.new.call(params, petlover) }

  let(:params) { {} }
  let(:petlover) { nil }

  it { is_expected.to be_failure }

  describe 'result errors' do
    subject { result.failure }
    let(:errors) { { email: ["is missing"], pet_name: ["is missing"], symptoms: ["is missing"] } }

    it { expect(subject.errors.to_h).to eq(errors) }
  end

  context 'when all params are provided' do
    let(:params) { { pet_name: 'snoopy', email: 'email', symptoms: [{name: 'bark'}, {name: 'meow'}] } }

    it { is_expected.to be_success }

    describe 'first return value' do
      subject { result.value![0] }
      let(:petlover) { Petlover.new(email: 'email') }

      it { is_expected.to be_instance_of(Consultation) }
      it { expect(subject.to_h).to eq params.merge(petlover: petlover) }
    end

    describe 'second return value' do
      subject { result.value![1] }

      it { is_expected.to eq 'next_step' }
    end
  end
end
