module Konamio
  module Sequence
    class Listener < Konamio::Base
      include Konamio::KeyMap

      def initialize(options)
        options = { input: $stdin, debounce: 0.0001 }.merge(options)
        load_options(:sequence, options)
      end

      def execute!
        case listen
        when true
          return Konamio::Result.new(success: true, data: { sequence: @sequence[1..-1]})
        when false
          return Konamio::Result.new(success: false, data: { sequence: @sequence })
        when :negative
          return Konamio::Result.new(success: false, data: { sequence: :negative })
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
          extra_thread.join(@debounce)
          # kill thread so not-so-long special keys don't wait on getc
          extra_thread.kill
        end

        case input
        when sequence_for(@sequence[0])
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
