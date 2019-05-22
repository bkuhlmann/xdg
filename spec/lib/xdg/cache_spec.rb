# frozen_string_literal: true

require "spec_helper"

RSpec.describe XDG::Cache do
  subject(:cache) { described_class.new environment: environment }

  let :environment do
    {"HOME" => "/home"}.merge(described_class::HOME_PAIR.to_env)
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
end
