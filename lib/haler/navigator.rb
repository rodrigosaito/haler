require "haler/navigator/entry_point"

module Haler

  module Navigator

    def self.entry_point(url)
      EntryPoint.new(url)
    end

  end

end
