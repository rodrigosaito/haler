require 'spec_helper'

describe Haler::Decorator::Collection do

  describe "#to_json" do

    def expected_json(range = 0..9)
      {
        _links: {
          self: { href: "/people" }
        },
        people: Haler.decorate(Person.all[range]).serialize
      }.to_json
    end

    context "when no options are passed" do

      let(:json) { described_class.new(Person).to_json }

      it "returns a json collection" do
        json.should eq expected_json
      end

    end

    context "when :limit option is passed" do

      let(:json) { described_class.new(Person, limit: 15).to_json }

      it "returns a json collection with correct number of items" do
        json.should eq expected_json(0..14)
      end
    end

    context "when :offset option is passed" do

      let(:json) { described_class.new(Person, offset: 5).to_json }

      it "returns a json collection within correct range" do
        json.should eq expected_json(5..14)
      end
    end

  end


end
