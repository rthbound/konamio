module Konamio
  module Sequence
    class Listener < PayDirt::Base
      def initialize(options)
        options = { input: $stdin }.merge(options)
        load_options(:sequence, options)
      end

      def execute!
        result = listen

        if result == true
          return PayDirt::Result.new(success: true, data: { sequence: @sequence[1..-1]})
        elsif result == false
          return PayDirt::Result.new(success: false, data: {})
        elsif result.nil?
          return PayDirt::Result.new(success: false, data: {terminate: true })
        end
      end

      def listen
        case @input.getch
        when @sequence[0]
          true
        when "\e"
          nil
        else
          false
        end
      end
    end
  end
end
