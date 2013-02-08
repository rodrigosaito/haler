require 'spec_helper'

describe Haler::Decorator::Enumerator do

  describe "#to_json" do

    let(:array) { [ Person.new ] }

    let(:json){ described_class.new(array).to_json }

    let(:expected_json) do
      [ person_hash ].to_json
    end

    it "serializes to json array" do
      json.should eq expected_json
    end

  end

end

