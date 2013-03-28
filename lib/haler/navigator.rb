require "haler/navigator/resource"
require "haler/navigator/entry_point"

module Haler

  module Navigator

    def self.entry_point(url)
      Resource.new(url)
    end

  end

end

