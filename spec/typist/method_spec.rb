# frozen_string_literal: true

RSpec.describe Typist::Method do
  let(:params) { { x: Integer, y: String } }
  let(:result_type) { String }

  subject { described_class.new(params).return(result_type) }

  describe '#validate_args!' do
    context 'when given correct parameter type' do
      it 'returns parameters' do
        params = [1, 'abc']
        expect(subject.validate_args!(*params)).to eq(params)
      end
    end

    context 'when given incorrect parameter types' do
      it 'raises error' do
        expect { subject.validate_args!(1, 2) }
          .to raise_error(Typist::ArgumentTypeError)
      end
    end

    context 'when given insufficient parameters' do
      it 'raises error' do
        expect { subject.validate_args!(1) }
          .to raise_error(Typist::ArgumentTypeError)
      end
    end

    context 'when given too many parameters' do
      it 'raises error' do
        expect { subject.validate_args!(1, 'abc', 3) }
          .to raise_error(Typist::ArgumentTypeError)
      end
    end
  end

  describe '#validate_return!' do
    context 'when given correct return type' do
      it 'returns result' do
        result = 'abc'
        expect(subject.validate_return!(result)).to eq(result)
      end
    end

    context 'when given incorrect return type' do
      it 'raises error' do
        expect { subject.validate_return!(1) }
          .to raise_error(Typist::ReturnTypeError)
      end
    end
  end
end
