require 'spec_helper'

describe Haler::Decorator::Enumerator do

  describe "#serialize" do

    let(:array) { [ Person.new ] }

    let(:serialized){ described_class.new(array).serialize }

    let(:expected_hash) do
      [ person_hash ]
    end

    it "serializes to json array" do
      serialized.should eq expected_hash
    end

    context "when a custom decorator is passed" do

      let(:serialized) { described_class.new(array, { person: { decorator_class: CustomPersonDecorator }}).serialize }

      let(:expected_hash) do
        [ CustomPersonDecorator.new(array.first).serialize ]
      end

      it "serializes using custom decorator class" do
        serialized.should eq expected_hash
      end

    end

    context "when only_key_fields: true is passed" do

      let(:serialized) { described_class.new(array, { person: { only_key_fields: true }}).serialize }

      let(:expected_hash) do
        [ PersonDecorator.new(array.first, { only_key_fields: true }).serialize ]
      end

      it "serializes with only key_fields" do
        serialized.should eq expected_hash
      end

    end

  end

end

