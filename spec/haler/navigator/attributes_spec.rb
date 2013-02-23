require "spec_helper"

describe Haler::Navigator::Attributes do

  let(:hal_hash) do
    {
      _links: {
        self: { href: "/some_resource/1" }
      },
      string_attr: "Some String"
    }
  end

  let(:described) { described_class.new hal_hash }

  it "returns an attribute value" do
    described[:string_attr].should eq "Some String"
  end

end

