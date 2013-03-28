module Haler

  module Navigator

    class Resource

      def initialize(url)
        @url = url
      end

      def url
        @url
      end

      def links
        Links.new hal_hash
      end

      def navigate_to(link_rel)
        Resource.new(@url + links[link_rel.to_sym][:href])
      end

      private
      def hal_hash
        @hal_hash ||= JSON.parse(HTTParty.get(@url).body, symbolize_names: true)
      end

    end

  end

end

