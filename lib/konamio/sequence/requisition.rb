module Konamio
  module Sequence
    class Requisition < Konamio::Base
      include Konamio::KeyMap
      # @param [Hash] options The group of options for the sequence requisition
      # @option options [Class] :speaker (Konamio::Prompt) You could theoretically replace this with a class that responds to #new with an instance that responds to #execute! Not sure why you would.
      # @option options [String] :prompt ("Enter konami code (or hit escape)") override with a falsey value to skip prompt dialog
      # @option options [String] :confirmation ("Enter konami code (or hit escape)") override with a falsey value to skip confirmation dialog
      # @option options [String] :cancellation ("Goodbye!") override with a falsey value to skip cancellation dialog
      # @option options [Array, String] :sequence ([:up,:up,:down,:down,:left,:right,:left,:right,"B","A"])
      def initialize(options={})
        options = {
          input:        $stdin,
          output:       $stdout,
          listener:     Konamio::Sequence::Listener,
          speaker:      Konamio::Prompt,
          prompt:       "Enter konami code (or hit escape)",
          sequence:     [:up,:up,:down,:down,:left,:right,:left,:right,"B","A"],
          confirmation: "Good job, you.",
          cancellation: "Goodbye!"
        }.merge(options)

        load_options(:sequence, options)
      end

      # @api public
      # @yieldreturn The result of a block, if supplied
      # @return Konamio::Result
      def execute! &block
        prompt

        result = listen(@sequence)
        yield if block_given? && result.successful?

        result
      end

      private
      # @api private
      # @param prompt
      # @return [Konamio::Result] unless running silently
      # @return [Boolean] false if running silently
      def prompt(prompt = @prompt, speaker = @speaker)
        !!prompt && speaker.new(prompt: prompt, output: @output).execute!
      end

      # @api private
      # @param [String, Array<String,Symbol>] sequence The sequence you want to require. When providing an array, each element must be a recognized symbol or the string representation of an ascii character.
      # @return [Konamio::Result]
      def listen(sequence)
        listener = @listener.new(sequence: sequence, input: @input)
        received = listener.execute!
        signal   = received.data[:sequence]

        if signal.empty?
          prompt(@confirmation)
          return result true, data: { confirmation: @confirmation }
        end

        case signal
        when :negative
          prompt(@cancellation)
          result(false, data: { confirmation: "User terminated." })
        when sequence
          prompt
          listen(@sequence)
        when sequence[1..-1]
          listen signal
        end
      end

      # @api private
      # @param [Boolean] success whether the expected sequence was received.
      # @param [Hash] ({}) data
      # @option data [String, Boolean] :confirmation A message about how the program exited.
      # @return [Konamio::Result]
      def result(success, data={})
        Konamio::Result.new(success: success, data: data)
      end
    end
  end
end

