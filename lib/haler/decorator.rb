module Haler

  module Decorator

    def self.included(base)
      base.class_eval do
        include Fields
        include Links
      end
    end

    def initialize(object, options = {})
      @object = object
    end

    def to_json
      {}.tap do |hash|
        self.class.fields.each_pair do |name, field|
          hash[name] = field.serialize @object
        end

        if self.class.has_links?
          hash["_links"] ||= {}
          self.class.links.each_pair  do |rel, link|
            hash["_links"][rel] = link.serialize
          end
        end

      end.to_json
    end

    def method_missing(method, *args, &block)
      return @object.send(method, *args, &block) if @object.respond_to? method
      super
    end

  end

end
