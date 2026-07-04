# frozen_string_literal: true

require "spec_helper"

RSpec.describe XDG::Runtime do
  subject(:runtime) { described_class.new environment: }

  let(:environment) { {"XDG_RUNTIME_DIR" => "/test"} }

  describe "#initialize" do
    it "is frozen" do
      expect(runtime.frozen?).to be(true)
    end
  end

  describe "#home" do
    it "answers home directory" do
      expect(runtime.home).to eq(Pathname("/test"))
    end
  end

  describe "#directories" do
    it "answers empty array" do
      expect(runtime.directories).to eq([])
    end
  end

  describe "#all" do
    it "answers array of paths" do
      expect(runtime.all).to contain_exactly(Pathname("/test"))
    end
  end

  shared_examples "a string" do |message|
    it "answers environment settings" do
      expect(runtime.public_send(message)).to eq("XDG_RUNTIME_DIR=/test")
    end
  end

  describe "#to_s" do
    it_behaves_like "a string", :to_s
  end

  describe "#to_str" do
    it_behaves_like "a string", :to_str
  end

  describe "#inspect" do
    it "answers current environment" do
      expect(runtime.inspect).to match(%r(\A\#<#{described_class}:\d+\sXDG_RUNTIME_DIR=/test>\Z)x)
    end
  end
end
