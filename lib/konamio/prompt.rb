module Konamio
  class Prompt < PayDirt::Base
    def initialize(options)
      load_options(:prompt, options)

      prompt(@prompt)
    end

    def prompt(prompt)
      puts prompt
    end
  end
end
