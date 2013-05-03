module Konamio
  module Sequence
    class Requisition < PayDirt::Base
      def initialize(options={})
        options = {
          sequence: "\e[A\e[A\e[B\e[B\e[D\e[C\e[D\e[CBA",
          prompt:       "Enter konami code (or hit escape)",
          confirmation: "Good job, you."
        }.merge(options)

        load_options(:sequence, options)

        prompt(@prompt)
        listen(@sequence)
        finish(false)
      end

      def prompt(prompt)
        Konamio::Prompt.new(prompt: prompt)
      end

      def listen(sequence)
        listener = Konamio::Sequence::Listener.new(sequence: sequence)
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
          prompt(@prompt)
          listen(sequence)
        end
      end

      def finish(successful)
        return PayDirt::Result.new(success: successful)
      end
    end
  end
end

