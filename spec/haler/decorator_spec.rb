require "spec_helper"

describe Haler::Decorator do

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

  describe "#serialize" do

    let(:expected_hash) do
      {
        name: "Some Name",
        age: 25,
        _links: {
          self: { href: '/some-link' }
        }
      }
    end

    it "serializes to hash" do
      decorated.serialize.should == expected_hash
    end

  end

end
