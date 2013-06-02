module Konamio
  module Sequence
    class Requisition < PayDirt::Base
      include Konamio::KeyMap
      def initialize(options={})
        options = {
          output:       $stdout,
          input:        $stdin,
          speaker:      Konamio::Prompt,
          listener:     Konamio::Sequence::Listener,
          sequence:     [:up,:up,:down,:down,:left,:right,:left,:right,"B","A"],
          prompt:       "Enter konami code (or hit escape)",
          confirmation: "Good job, you.",
          cancellation: "Goodbye!"
        }.merge(options)

        load_options(:sequence, options)
      end

      def execute! &block
        prompt
        result = listen(@sequence)
        yield if block_given? && result.successful?
        return result
      end

      def prompt(prompt = @prompt)
        @speaker.new(prompt: prompt, output: @output).execute!
      end

      def listen(sequence)
        listener = @listener.new(sequence: sequence, input: @input)
        received = listener.execute!
        signal   = received.data[:sequence]

        prompt(@confirmation) and return result(true, data: { confirmation: @confirmation }) if signal.empty?

        case signal
        when :negative
          prompt(@cancellation)
          result(false, data: { confirmation: "User terminated." })
        when sequence
          prompt
          listen(@sequence)
        when sequence[1..-1]
          listen signal
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

