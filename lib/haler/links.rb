require 'haler/links/collection'

module Haler

  module Links

    def self.included(base)
      base.class_eval do
        extend ClassMethods
      end
    end

    module ClassMethods

      def link(rel, &block)
        links.<<(rel, &block)
      end

      def links
        @links ||= Links::Collection.new
      end

      def has_links?
        not links.empty?
      end

    end

  end

end

