require "spec_helper"

describe Haler::Decorator do

  class Person

    attr_accessor :name, :age

    def initialize(name, age)
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

  describe "#to_json" do
    let(:decorated) do
      PersonDecorator.new(Person.new "Some Name", 25)
    end

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
      decorated.to_json.should eq expected_json
    end
  end




end
