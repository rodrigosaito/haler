module Haler

  module Decorator

    def self.included(base)
      base.class_eval do
        extend ClassMethods

        include Fields
      end
    end

    module ClassMethods

      def link(rel, &block)
        links.<<(rel, &block)
      end

      def links
        @links ||= Links.new
      end

      def has_links?
        not links.empty?
      end

    end

    def initialize(object, options = {})
      @object = object

      unless self.class.links.include?(:self)
        self.class.link :self do
          "/#{resource}/#{@object.id}"
        end
      end
    end

    def to_json
      serialize.to_json
    end

    def serialize
      {}.tap do |hash|
        self.class.fields.each_pair do |name, field|
          hash[name] = field.serialize @object
        end

        if self.class.has_links?
          hash[:_links] = self.class.links.serialize
        end

      end
    end

    def method_missing(method, *args, &block)
      return @object.send(method, *args, &block) if @object.respond_to? method
      super
    end

    def resource
      resource_name.pluralize.camelize(:lower)
    end

    def resource_name
      @object.class.name
    end

  end

end

require 'haler/decorator/enumerator'
require 'haler/decorator/collection'
