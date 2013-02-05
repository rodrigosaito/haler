require 'spec_helper'

describe Haler::Decorator::Collection do

  let(:json) { described_class.new(Person).to_json }

  describe "#to_json" do

    let(:expected_json) do
      {
        _links: {
          self: { href: "/people" }
        },
        people: [
          {
            name: 'Some Name',
            age: 25,
            _links: {
              self: { href: "/people/1" }
            }
          }
        ]
      }.to_json
    end

    it "returns a json collection" do
      json.should eq expected_json
    end

  end


end
