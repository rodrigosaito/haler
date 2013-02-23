module Haler

  module Navigator

    class Attributes < Hash

      def initialize(hal_hash)
        hal_hash.each_pair do |key, value|
          self[key] = value unless key == :_links
        end
      end

    end

  end

end
