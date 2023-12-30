# frozen_string_literal: true

require "spec_helper"

RSpec.describe XDG::State do
  subject(:state) { described_class.new environment: }

  let(:environment) { {"HOME" => "/home", **described_class::HOME_PAIR.to_env} }

  describe "#home" do
    it "answers home directory" do
      expect(state.home).to eq(Pathname("/home/.local/state"))
    end
  end

  describe "#directories" do
    it "answers empty array" do
      expect(state.directories).to eq([])
    end
  end

  describe "#all" do
    it "answers all directories" do
      expect(state.all).to contain_exactly(Pathname("/home/.local/state"))
    end
  end

  shared_examples "a string" do |message|
    it "answers environment settings" do
      expect(state.public_send(message)).to eq("XDG_STATE_HOME=/home/.local/state")
    end
  end

  describe "#to_s" do
    it_behaves_like "a string", :to_s
  end

  describe "#to_str" do
    it_behaves_like "a string", :to_str
  end
end
