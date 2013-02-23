module Haler

  module Navigator

    class Links < Hash

      def initialize(hal_hash)
        hal_hash[:_links].each_pair do |key, value|
          self[key] = value
        end
      end

    end

  end

end

