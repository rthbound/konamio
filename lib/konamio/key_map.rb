module Konamio
  module KeyMap
    def self.sequence(key)
      {
        space:      " ",
        tab:       "\t",
        return:    "\r",
        line_feed: "\n",
        escape:    "\e",
        up:        "\e[A",
        down:      "\e[B",
        right:     "\e[C",
        left:      "\e[D"
      }.fetch(key) { key }
    end
  end
end
