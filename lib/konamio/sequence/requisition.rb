module Konamio
  module Sequence
    class Requisition < PayDirt::Base
      def initialize(options={})
        options = {
          speaker:      Konamio::Prompt,
          listener:     Konamio::Sequence::Listener,
          sequence:     "\e[A\e[A\e[B\e[B\e[D\e[C\e[D\e[CBA",
          prompt:       "Enter konami code (or hit escape)",
          confirmation: "Good job, you."
        }.merge(options)

        load_options(:sequence, options)
      end

      def execute!
        prompt
        return listen(@sequence)
      end

      def prompt(prompt = @prompt)
        @speaker.new(prompt: prompt).execute!
      end

      def listen(sequence)
        listener = @listener.new(sequence: sequence)
        received = listener.execute!
        signal   = received.data[:sequence]


        prompt(@confirmation) and return result(true, data: { confirmation: @confirmation }) if signal.empty?

        case signal
        when :negative
          prompt("Goodbye!")
          result(false, data: { confirmation: "User terminated." })
        when sequence
          prompt
          listen(@sequence)
        when sequence[1..-1]
          listen received.data[:sequence]
        else
          result(false, data: { confirmation: "Unexpected termination" })
        end
        #if received.successful?
        #  if received.data[:sequence].empty?
        #    prompt(@confirmation)
        #    result(true, data: { confirmation: @confirmation })
        #  else
        #    listen(received.data[:sequence])
        #  end
        #elsif received.data[:terminate]
        #  prompt("Goodbye!")
        #  result(false, data: { confirmation: :negative })
        #else
        #  prompt
        #  listen(@sequence)
        #end
      end

      def result(success, data={})
        PayDirt::Result.new(success: success, data: data)
      end
    end
  end
end

