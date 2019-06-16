# frozen_string_literal: true

RSpec.describe Typist::Signature do
  let(:test_class) do
    Class.new do
      include Typist::Signature

      accept(x: Integer, y: Integer).return(String)
      def sum_to_s(x, y)
        (x + y).to_s
      end
    end
  end

  let(:obj) { test_class.new }

  describe 'runtime check' do
    describe 'on method parameter type' do
      context 'when given correct parameter type' do
        it 'executes the code' do
          expect(obj.sum_to_s(1, 2)).to eq('3')
        end
      end

      context 'wrong parameter types' do
        it 'raises error' do
          expect { obj.sum_to_s(1, '2') }.to raise_error(Typist::ArgumentTypeError)
        end
      end
    end

    describe 'on method return type' do
      context 'when returning incorrect type' do
        it 'raises error' do
          test_class.define_method(:sum_to_s) { |x, y| x + y }

          expect { obj.sum_to_s(1, 2) }
            .to raise_error(Typist::ReturnTypeError)
        end
      end
    end

    context 'when there are multiple methods' do
      let(:test_class) do
        Class.new do
          include Typist::Signature

          accept(x: Integer).return(String)
          def to_s(x)
            x.to_s
          end

          accept(y: String).return(Integer)
          def to_i(y)
            y.to_i
          end
        end
      end

      it 'should validate signatures of each method' do
        expect { obj.to_s('a') }
          .to raise_error(Typist::ArgumentTypeError)
        expect { obj.to_i(1) }
          .to raise_error(Typist::ArgumentTypeError)
      end
    end

    describe 'method without signature annotation' do
      let(:test_class) do
        Class.new do
          include Typist::Signature

          accept(x: Integer).return(String)

          def to_s(x)
            x.to_s
          end

          def sum(x, y)
            x + y
          end
        end
      end

      it 'validates only annotated method' do
        expect { obj.to_s('1') }.to raise_error(Typist::ArgumentTypeError)
        expect(obj.sum(1, 2)).to eq(3)
      end
    end
  end
end
