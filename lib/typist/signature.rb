# frozen_string_literal: true

module Typist
  module Signature
    def self.included(base)
      base.extend(self)
      base.prepend Validator
    end

    module Validator; end

    def accept(**params)
      @method_signature = Method.new(params)
    end

    def method_added(method_name)
      return unless @method_signature

      this_signature = @method_signature

      Validator.define_method(method_name) do |*args|
        this_signature.validate_args!(*args)
        result = super(*args)
        this_signature.validate_return!(result)
      end

      @method_signature = nil
    end
  end
end
