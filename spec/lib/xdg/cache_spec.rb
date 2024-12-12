# frozen_string_literal: true

require "spec_helper"

RSpec.describe XDG::Cache do
  subject(:cache) { described_class.new environment: }

  let(:environment) { {"HOME" => "/home", **described_class::HOME_PAIR.to_env} }

  describe "#initialize" do
    it "is frozen" do
      expect(cache.frozen?).to be(true)
    end
  end

  describe "#home" do
    it "answers home directory" do
      expect(cache.home).to eq(Pathname("/home/.cache"))
    end
  end

  describe "#directories" do
    it "answers empty array" do
      expect(cache.directories).to eq([])
    end
  end

  describe "#all" do
    it "answers all directories" do
      expect(cache.all).to contain_exactly(Pathname("/home/.cache"))
    end
  end

  shared_examples "a string" do |message|
    it "answers environment settings" do
      expect(cache.public_send(message)).to eq("XDG_CACHE_HOME=/home/.cache")
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
      expect(cache.inspect).to match(
        %r(\A\#<#{described_class}:\d+ XDG_CACHE_HOME=/home/.cache>\Z)
      )
    end
  end
end
