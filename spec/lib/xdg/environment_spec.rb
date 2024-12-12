# frozen_string_literal: true

require "spec_helper"

RSpec.describe XDG::Environment do
  subject(:environment) { described_class.new environment: {"HOME" => "/home"} }

  describe "#initialize" do
    it "is frozen" do
      expect(environment.frozen?).to be(true)
    end
  end

  describe "#cache_home" do
    it "answers cache home" do
      expect(environment.cache_home).to eq(Pathname("/home/.cache"))
    end
  end

  describe "config_home" do
    it "answers config home" do
      expect(environment.config_home).to eq(Pathname("/home/.config"))
    end
  end

  describe "config_dirs" do
    it "answers config dirs" do
      expect(environment.config_dirs).to contain_exactly(Pathname("/etc/xdg"))
    end
  end

  describe "data_home" do
    it "answers data home" do
      expect(environment.data_home).to eq(Pathname("/home/.local/share"))
    end
  end

  describe "data_dirs" do
    it "answers data dirs" do
      expect(environment.data_dirs).to contain_exactly(
        Pathname("/usr/local/share"),
        Pathname("/usr/share")
      )
    end
  end

  describe "#state_home" do
    it "answers state home" do
      expect(environment.state_home).to eq(Pathname("/home/.local/state"))
    end
  end

  shared_examples "a string" do |message|
    it "answers current environment" do
      expect(environment.public_send(message)).to eq(
        "XDG_CACHE_HOME=/home/.cache " \
        "XDG_CONFIG_HOME=/home/.config " \
        "XDG_CONFIG_DIRS=/etc/xdg " \
        "XDG_DATA_HOME=/home/.local/share " \
        "XDG_DATA_DIRS=/usr/local/share:/usr/share " \
        "XDG_STATE_HOME=/home/.local/state"
      )
    end
  end

  describe "#to_s" do
    it_behaves_like "a string", :to_s
  end

  describe "#to_str" do
    it_behaves_like "a string", :to_str
  end

  describe "#inspect" do
    let :pattern do
      %r(
        \A
        \#<
        #{described_class}:\d+\s
        XDG_CACHE_HOME=/home/.cache\s
        XDG_CONFIG_HOME=/home/.config\s
        XDG_CONFIG_DIRS=/etc/xdg\s
        XDG_DATA_HOME=/home/.local/share\s
        XDG_DATA_DIRS=/usr/local/share:/usr/share\s
        XDG_STATE_HOME=/home/.local/state
        >
        \Z
      )x
    end

    it "answers current environment" do
      expect(environment.inspect).to match(pattern)
    end
  end
end
