# frozen_string_literal: true

require "spec_helper"

RSpec.describe XDG::Data do
  subject(:data) { described_class.new environment: }

  let :environment do
    {"HOME" => "/home", **described_class::HOME_PAIR.to_env, **described_class::DIRS_PAIR.to_env}
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

  shared_examples "a string" do |message|
    it "answers environment settings" do
      expect(data.public_send(message)).to eq(
        "XDG_DATA_HOME=/home/.local/share XDG_DATA_DIRS=/usr/local/share:/usr/share"
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
    it "answers current environment" do
      expect(data.inspect).to match(
        %r(
          \A
          \#<
          #{described_class}:\d+\s
          XDG_DATA_HOME=/home/.local/share\s
          XDG_DATA_DIRS=/usr/local/share:/usr/share
          >
          \Z
        )x
      )
    end
  end
end
