module Konamio
  module Sequence
    class Listener < PayDirt::Base
      def initialize(options)
        options = { input: $stdin }.merge(options)
        load_options(:sequence, options)
      end

      def execute!
        case listen
        when true
          return PayDirt::Result.new(success: true, data: { sequence: @sequence[1..-1]})
        when false
          return PayDirt::Result.new(success: false, data: { sequence: @sequence })
        when :negative
          return PayDirt::Result.new(success: false, data: { sequence: :negative })
        else
          return PayDirt::Result.new(success: false, data: { sequence: @sequence })
        end
      end

      def listen
        case @input.getch
        when @sequence[0]
          true
        when "\e"
          :negative
        else
          false
        end
      end
    end
  end
end
