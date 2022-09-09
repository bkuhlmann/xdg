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

  describe "#inspect" do
    it "answers environment settings" do
      expect(state.inspect).to eq("XDG_STATE_HOME=/home/.local/state")
    end
  end
end
