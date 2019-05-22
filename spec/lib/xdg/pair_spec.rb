# frozen_string_literal: true

require "spec_helper"

RSpec.describe XDG::Pair do
  subject(:pair) { described_class.new "TEST", "example" }

  describe "#key" do
    it "answers key" do
      expect(pair.key).to eq("TEST")
    end
  end

  describe "#value" do
    it "answers value" do
      expect(pair.value).to eq("example")
    end
  end

  describe "#to_env" do
    it "answers environment" do
      expect(pair.to_env).to eq("TEST" => "example")
    end
  end
end
