require 'spec_helper'

describe Haler::Decorator::Enumerator do

  describe "#to_json" do

    let(:array) { [ Person.new ] }

    let(:json) { described_class.new(array).to_json }

    let(:expected_json) do
      [
        {
          name: 'Some Name',
          age: 25,
          _links: {
            self: {
              href: "/some-link"
            }
          }
        }
      ].to_json
    end

    it "serializes to json array" do
      json.should eq expected_json
    end

  end



end

