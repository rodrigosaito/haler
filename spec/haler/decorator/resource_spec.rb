require 'spec_helper'

describe Haler::Decorator::Resource do

  describe "#serialize" do

    def expected_hash(range = 0..9)
      {
        _links: {
          self: { href: "/people" }
        },
        people: Haler.decorate(Person.all[range], { person: { only_key_fields: true } }).serialize
      }
    end

    context "when no options are passed" do

      let(:serialized) { described_class.new(Person).serialize }

      it "returns a serialized collection" do
        serialized[:people].should eq expected_hash[:people]
      end

      it "contains a next_page link" do
        serialized[:_links][:next_page].should eq({ href: "/people?limit=10&offset=10" })
      end

      it "does't contains prev_page link" do
        serialized[:_links].should_not include :prev_page
      end

    end

    context "when :limit option is passed" do

      let(:serialized) { described_class.new(Person, limit: 15).serialize }

      it "returns a serialized collection with correct number of items" do
        serialized[:people].should eq expected_hash(0..14)[:people]
      end
    end

    context "when :offset option is passed" do

      let(:serialized) { described_class.new(Person, offset: 5).serialize }

      it "returns a serialized collection within correct range" do
        serialized[:people].should eq expected_hash(5..14)[:people]
      end
    end

    context "when on last page" do

      let(:serialized) { described_class.new(Person, offset: 90).serialize }

      it "doens't have a next_page link" do
        serialized[:_links].should_not include :next_page
      end

      it "contains a prev_page link" do
        serialized[:_links][:prev_page].should eq({ href: "/people?limit=10&offset=80" })
      end

    end

    context "when decorator_class for people embedded relation is passed" do

      let(:serialized) { described_class.new(Person, person: { decorator_class: CustomPersonDecorator }).serialize }

      let(:expected_people) do
        Haler.decorate(Person.all[0..9], { person: { decorator_class: CustomPersonDecorator }}).serialize
      end

      it "serializes all people using the decorator_class" do
        serialized[:people].should eq expected_people
      end
    end

  end


end
