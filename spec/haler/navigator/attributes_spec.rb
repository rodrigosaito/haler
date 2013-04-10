require "spec_helper"

describe Haler::Navigator::Attributes do

  let(:hal_hash) do
    {
      _links: {
        self: { href: "/some_resource/1" }
      },
      string_attr: "Some String",
      array_attr: [ { _links: { self: { href: "/nested/1" }  }, nested_attr: "Some nested value" } ],
      array_values_attr: [ "Item 1" ]
    }
  end

  let(:described) { described_class.new "http://localhost:5000", hal_hash }

  it "returns an attribute value" do
    described[:string_attr].should eq "Some String"
  end

  it "returns an array attribute" do
    described[:array_attr].should be_a Array
  end

  it "returns an array with resources" do
    described[:array_attr].each do |item|
      item.should be_a Haler::Navigator::Resource
    end
  end

  it "returns an array with values" do
    described[:array_values_attr].each do |item|
      item.should be_a String
    end
  end

end

