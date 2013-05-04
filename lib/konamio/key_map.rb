module Konamio
  module KeyMap
    def self.included(base)
      def sequence_for(key)
        {
          space:      " ",
          tab:       "\t",
          return:    "\r",
          line_feed: "\n",
          escape:    "\e",
          up:        "\e[A",
          down:      "\e[B",
          right:     "\e[C",
          left:      "\e[D",
          konami:    [:up, :up, :down, :down, :left, :right, :left, :right, "B", "A"]
        }.fetch(key) { key }
      end
    end
  end
end
