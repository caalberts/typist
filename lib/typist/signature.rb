# frozen_string_literal: true

module Typist
  module Signature
    @@validators = Hash.new { |hash, key| hash[key] = Module.new }

    def self.included(base)
      base.extend(self)

      validator = @@validators[base.object_id]
      base.prepend(validator)
    end

    def accept(**params)
      @signature = Method.new(params)
    end

    def method_added(method_name)
      return unless @signature

      validator.define_method(method_name, wrapped_with(@signature))

      @signature = nil
    end

    private

    def validator
      @@validators[self.object_id]
    end

    def wrapped_with(signature)
      lambda do |*args|
        signature.validate_args!(*args)
        result = super(*args)
        signature.validate_return!(result)
      end
    end
  end
end
