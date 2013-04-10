require "httparty"

require "haler/navigator/attributes"
require "haler/navigator/links"

module Haler

  module Navigator

    class InvalidResourceOptionsError < Exception; end

    class Resource

      attr_reader :base_url, :path

      def initialize(options)
        # FIXME refactor
        raise InvalidResourceOptionsError unless options[:base_url]

        @base_url = options[:base_url]

        @path = options[:path] if options[:path]

        self_link = options[:hal_hash][:_links][:self][:href] if options[:hal_hash]

        @path = self_link if self_link
      end

      def url
        if @path
          @base_url + @path
        else
          @base_url
        end
      end

      def links
        Links.new hal_hash
      end

      def navigate_to(link_rel)
        Resource.new(base_url: base_url, path: links[link_rel.to_sym][:href])
      end

      def attrs
        Attributes.new base_url, hal_hash
      end

      private
      def hal_hash
        @hal_hash ||= JSON.parse(HTTParty.get(url).body, symbolize_names: true)
      end

    end

  end

end

