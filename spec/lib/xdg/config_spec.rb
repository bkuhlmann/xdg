# frozen_string_literal: true

require "spec_helper"

RSpec.describe XDG::Config do
  subject(:configuration) { described_class.new environment: environment }

  let :environment do
    {"HOME" => "/home"}.merge(described_class::HOME_PAIR.to_env)
                       .merge described_class::DIRS_PAIR.to_env
  end

  describe "#home" do
    it "answers home directory" do
      expect(configuration.home).to eq(Pathname("/home/.config"))
    end
  end

  describe "#directories" do
    it "answers directories" do
      expect(configuration.directories).to contain_exactly(Pathname("/etc/xdg"))
    end
  end

  describe "#all" do
    it "answers all directories" do
      expect(configuration.all).to contain_exactly(
        Pathname("/home/.config"),
        Pathname("/etc/xdg")
      )
    end
  end
end
