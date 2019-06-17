# frozen_string_literal: true

module Typist
  module Signature
    @validators = Hash.new { |hash, key| hash[key] = Module.new }

    def self.included(base)
      base.extend(self)

      validator = @validators[base.object_id]
      base.prepend(validator)
    end

    def accept(**params)
      @schema = Schema.new(params)
    end

    def method_added(method_name)
      return unless @schema

      method = wrapped_with(@schema)
      validator.define_method(method_name, method)

      @schema = nil
    end

    private

    def validator
      Typist::Signature.instance_variable_get(:@validators)[object_id]
    end

    def wrapped_with(schema)
      lambda do |*args|
        schema.validate_args!(*args)
        result = super(*args)
        schema.validate_return!(result)
      end
    end
  end
end
