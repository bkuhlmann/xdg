# frozen_string_literal: true

require "spec_helper"

RSpec.describe XDG::Pair do
  subject(:pair) { described_class["TEST", "example"] }

  describe "#key" do
    it "answers key" do
      expect(pair.key).to eq("TEST")
    end
  end

  describe "#key?" do
    it "answers true when key is present" do
      expect(described_class["TEST"].key?).to be(true)
    end

    it "answers false when key is missing" do
      expect(described_class.new.key?).to be(false)
    end
  end

  describe "#value" do
    it "answers value" do
      expect(pair.value).to eq("example")
    end
  end

  describe "#value?" do
    it "answers true when value is present" do
      expect(described_class["TEST", "example"].value?).to be(true)
    end

    it "answers false when value is missing" do
      expect(described_class["TEST"].value?).to be(false)
    end
  end

  describe "#empty?" do
    it "answers false when key and value are present" do
      expect(described_class["TEST", "example"].empty?).to be(false)
    end

    it "answers true with key only" do
      expect(described_class["TEST"].empty?).to be(true)
    end

    it "answers true with value only" do
      expect(described_class[nil, "example"].empty?).to be(true)
    end

    it "answers true when both key and value are missing" do
      expect(described_class[].empty?).to be(true)
    end
  end

  describe "#to_env" do
    it "answers environment" do
      expect(pair.to_env).to eq("TEST" => "example")
    end
  end

  describe "#inspect" do
    it "answers <key><delimiter><value> when both are present" do
      expect(pair.inspect).to eq("TEST=example")
    end

    it "answers <key><delimiter> with key only" do
      expect(described_class["TEST"].inspect).to eq("TEST=")
    end

    it "answers <delimiter><value> with value only" do
      expect(described_class[nil, "example"].inspect).to eq("=example")
    end

    it "answers empty string with no key and value" do
      expect(described_class.new.inspect).to eq("")
    end
  end
end
