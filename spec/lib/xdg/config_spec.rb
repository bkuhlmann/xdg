# frozen_string_literal: true

require "spec_helper"

RSpec.describe XDG::Config do
  subject(:configuration) { described_class.new environment: }

  let :environment do
    {"HOME" => "/home", **described_class::HOME_PAIR.to_env, **described_class::DIRS_PAIR.to_env}
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

  shared_examples "a string" do |message|
    it "answers environment settings" do
      expect(configuration.public_send(message)).to eq(
        "XDG_CONFIG_HOME=/home/.config XDG_CONFIG_DIRS=/etc/xdg"
      )
    end
  end

  describe "#to_s" do
    it_behaves_like "a string", :to_s
  end

  describe "#to_str" do
    it_behaves_like "a string", :to_str
  end
end
