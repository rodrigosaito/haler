require "spec_helper"

describe Haler::Decorator do

  class Person

    attr_accessor :id, :name, :age

    def initialize(name, age)
      @id = 1
      @name = name
      @age = age
    end

  end

  class PersonDecorator
    include Haler::Decorator

    field :name
    field :age

    link :self do
      "/some-link"
    end
  end

  let(:decorator) do
    class Decorator
      include Haler::Decorator
    end
  end

  let(:decorated) do
    PersonDecorator.new(Person.new "Some Name", 25)
  end

  describe "#to_json" do

    let(:expected_json) do
      {
        "name" => "Some Name",
        "age" => 25,
        "_links" => {
          "self" => { "href" => "/some-link" }
        }
      }.to_json
    end

    it "serializes to json" do
      decorated.to_json.should == expected_json
    end
  end

  describe "delegate methods" do

    it "delegate methods to decorated class" do
      decorated.id.should == 1
    end
  end

end
