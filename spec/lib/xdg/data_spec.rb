# frozen_string_literal: true

require "spec_helper"

RSpec.describe XDG::Data do
  subject(:data) { described_class.new environment: }

  let :environment do
    {"HOME" => "/home"}.merge(described_class::HOME_PAIR.to_env)
                       .merge described_class::DIRS_PAIR.to_env
  end

  describe "#home" do
    it "answers home directory" do
      expect(data.home).to eq(Pathname("/home/.local/share"))
    end
  end

  describe "#directories" do
    it "answers directories" do
      expect(data.directories).to contain_exactly(
        Pathname("/usr/local/share"),
        Pathname("/usr/share")
      )
    end
  end

  describe "#all" do
    it "answers all directories" do
      expect(data.all).to contain_exactly(
        Pathname("/home/.local/share"),
        Pathname("/usr/local/share"),
        Pathname("/usr/share")
      )
    end
  end

  describe "#inspect" do
    it "answers environment settings" do
      expect(data.inspect).to eq(
        "XDG_DATA_HOME=/home/.local/share XDG_DATA_DIRS=/usr/local/share:/usr/share"
      )
    end
  end
end
