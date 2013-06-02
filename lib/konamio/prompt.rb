module Konamio
  class Prompt < PayDirt::Base
    def initialize(options)
      options = {
        output: $stdout
      }.merge(options)

      load_options(:output, :prompt, options)
    end

    def execute!
      prompt
      return PayDirt::Result.new(success: true, data: { prompted: @prompt })
    end

    def prompt
      @output.puts @prompt
    end
  end
end
