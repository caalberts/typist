# frozen_string_literal: true

module Typist
  class Schema
    def initialize(params)
      @param_types = params.values
    end

    def return(type)
      @return_type = type
      self
    end

    def validate_args!(*args)
      return args if valid_arg_types?(args)

      raise ArgumentTypeError
    end

    def validate_return!(result)
      return result if result.is_a? @return_type

      raise ReturnTypeError
    end

    private

    def valid_arg_types?(args)
      args.map(&:class) == @param_types
    end
  end
end
