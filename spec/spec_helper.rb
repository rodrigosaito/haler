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
class Person

  attr_accessor :id, :name, :age

  def initialize(name = "Some Name", age = 25)
    @id = 1
    @name = name
    @age = age
  end

end

class PersonDecorator
  include Haler::Decorator

  field :name
  field :age

  #link :self do
  #  "/some-link"
  #end
end

class CustomPersonDecorator
  include Haler::Decorator

  field :name

  link :self do
    "/people/1"
  end
end
