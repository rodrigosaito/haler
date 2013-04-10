require "haler/navigator/resource"

module Haler

  module Navigator

    def self.entry_point(url)
      Resource.new(base_url: url)
    end

  end

end

