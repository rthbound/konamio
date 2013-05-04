module Konamio
  module Sequence
    class Requisition < PayDirt::Base
      def initialize(options={})
        options = {
          speaker:      Konamio::Prompt,
          listener:     Konamio::Sequence::Listener,
          sequence:     ["\e[A","\e[A","\e[B","\e[B","\e[D","\e[C","\e[D","\e[C","B","A"],
          prompt:       "Enter konami code (or hit escape)",
          confirmation: "Good job, you."
        }.merge(options)

        load_options(:sequence, options)

        prompt
        listen(@sequence)
        finish(false)
      end

      def prompt
        @speaker.new(prompt: @prompt).execute!
      end

      def listen(sequence)
        listener = @listener.new(sequence: sequence)
        received = listener.execute!

        if received.successful?
          if received.data[:sequence].empty?
            puts @confirmation and finish
          else
            listen(received.data[:sequence])
          end
        elsif received.data[:terminate]
          finish(false)
        else
          prompt
          listen(@sequence)
        end
      end

      def finish(successful)
        return PayDirt::Result.new(success: successful)
      end
    end
  end
end

