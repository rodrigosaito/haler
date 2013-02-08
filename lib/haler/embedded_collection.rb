module Haler

  class EmbeddedCollection

    def << (embedded_resource, options = {})
      embedded[embedded_resource] = options
    end

    def embedded
      @embedded ||= {}
    end

    def method_missing(method, *args, &block)
      super unless embedded.respond_to? method

      embedded.send(method, *args, &block)
    end

    def serialize(object)
      {}.tap do |serialized|
        embedded.each_pair do |name, options|
          serialized[name] = Haler.decorate(object.send(name)).serialize
        end
      end
    end


  end

end
