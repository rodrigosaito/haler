module Haler

  module Navigator

    class Attributes < Hash

      def initialize(base_url, hal_hash)
        @base_url = base_url
        hal_hash.each_pair do |key, value|
          self[key] = extract_value(value) unless key == :_links
        end
      end

      private
      def extract_value(value)
        if value.is_a?(Array)
          return [].tap do |array|
            value.each do |item|
              array << extract_value(item)
            end
          end
        end

        if value.is_a? Hash
          return Resource.new(base_url: @base_url, hal_hash: value)
        end

        value
      end

    end

  end

end
