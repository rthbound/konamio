module Konamio
  module Sequence
    class Listener < PayDirt::Base
      def initialize(options)
        options = { input: $stdin }.merge(options)
        load_options(:sequence, options)
      end

      def execute!
        result = listen(@sequence)

        if result == true
          return PayDirt::Result.new(success: true, data: { sequence: @sequence[1..-1]})
        elsif result == false
          return PayDirt::Result.new(success: false)
        elsif result.nil?
          return PayDirt::Result.new(success: false, data: {terminate: true })
        end
      end

      def listen(sequence)
        case @input.getch
        when sequence[0]
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
