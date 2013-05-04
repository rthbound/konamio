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
        input = @input.getch
        if(input == "\e")
          extra_thread = Thread.new{
            input << @input.getch
            input << @input.getch
          }

          # wait just long enough for special keys to get swallowed
          extra_thread.join(0.00001)
          # kill thread so not-so-long special keys don't wait on getc
          extra_thread.kill
        end

        case input
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
