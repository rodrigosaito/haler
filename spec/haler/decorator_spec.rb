require "spec_helper"

describe Haler::Decorator do

  let(:decorated) do
    PersonDecorator.new(Person.new)
  end

  describe "#to_json" do

    let(:expected_json) do
      person_hash.to_json
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
      person_hash
    end

    it "serializes to hash" do
      decorated.serialize.should == expected_hash
    end

    context "when only_key_fields: true is passed" do

      let(:decorated) { PersonDecorator.new Person.new, only_key_fields: true }

      let(:expected_hash) do
        {
          _links: {
            self: { href: '/people/1' }
          },
          name: "Some Name 1"
        }
      end

      it "serializes only key fields" do
        decorated.serialize.should eq expected_hash
      end

    end

  end

  describe "#resource" do

    it "returns the resource name" do
      decorated.resource.should eq "people"
    end

  end

  describe "after initialization" do

    it "has self link" do
      decorated.class.links.should include :self
    end

  end

end
