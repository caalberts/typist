# frozen_string_literal: true

require 'typist/version'
require 'typist/schema'
require 'typist/signature'

module Typist
  class ArgumentTypeError < StandardError; end
  class ReturnTypeError < StandardError; end
end
