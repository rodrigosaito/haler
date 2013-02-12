require 'haler'

RSpec.configure do |config|
  #config.treat_symbols_as_metadata_keys_with_true_values = true
  #config.run_all_when_everything_filtered = true
  #config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

# Test Helper Classes
class Address

  attr_accessor :id, :street

  def initialize
    @id = 1
    @street = "Some Street"
  end

end

class AddressDecorator
  include Haler::Decorator

  field :street
end

class PersonFakeQuery < Array

  def limit(limit)
    @limit = limit

    self
  end

  def offset(offset)
    @offset = offset

    self
  end

  def each(&block)
    return super unless @limit
    self[@offset..(@offset + @limit - 1)].each(&block)
  end

end



class Person

  attr_accessor :id, :name, :age

  def initialize(id = 1)
    @id = id
    @name = "Some Name #{id}"
    @age = 25
  end

  def addresses
    [ Address.new ]
  end

  def self.all(options = { limit: 10, offset: 0 })
    PersonFakeQuery.new.tap do |all|
      100.times do |id|
        all << Person.new(id)
      end

      all.limit options[:limit]
      all.offset options[:offset]
    end
  end

end

class PersonDecorator
  include Haler::Decorator

  field :name
  field :age

  embedded :addresses

end

class CustomPersonDecorator
  include Haler::Decorator

  field :name

  link :self do
    "/people/1"
  end
end

# TODO rspec helper method?
def person_hash
  {
    _links: {
      self: { href: '/people/1' }
    },
    name: "Some Name 1",
    age: 25,
    _embedded: {
      addresses: [
        {
          _links: {
            self: { href: '/addresses/1' }
          },
          street: 'Some Street'
        }
      ]
    }
  }
end
