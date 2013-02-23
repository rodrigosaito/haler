require "spec_helper"

describe Haler::Navigator::Links do

  let(:hal_hash) do
    {
      _links: {
        self: { href: "/some_resource/1" }
      },
      string_attr: "Some String"
    }
  end

  let(:described) { described_class.new hal_hash }

  it "returns link" do
    described[:self].should eq({ href: "/some_resource/1" })
  end

end

