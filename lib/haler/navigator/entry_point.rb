require 'httparty'

require "haler/navigator/links"
require 'haler/navigator/attributes'

module Haler

  module Navigator

    class EntryPoint

      attr_reader :base_uri

      def initialize(base_uri)
        @base_uri = base_uri
      end

      def links
        Links.new hal_hash
      end

      def attrs
        Attributes.new(hal_hash)
      end

      def navigate_to(link_rel)
        EntryPoint.new(base_uri + links[link_rel][:href])
      end

      private
      def hal_hash
        @hal_hash ||= JSON.parse(HTTParty.get(base_uri).body, symbolize_names: true)
      end

    end

  end

end

