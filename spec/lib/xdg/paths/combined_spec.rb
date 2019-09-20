# frozen_string_literal: true

require "spec_helper"

RSpec.describe XDG::Paths::Combined do
  subject(:combined) { described_class.new home, directories }

  let(:home) { XDG::Paths::Standard.new XDG::Pair["TEST_HOME", "/one"], environment }
  let(:directories) { XDG::Paths::Directory.new XDG::Pair["TEST_DIRS", "/two:/three"], environment }
  let(:environment) { {"HOME" => "/home"} }

  describe "#home" do
    it "answers dynamic home" do
      expect(combined.home).to eq(home.dynamic)
    end
  end

  describe "#directories" do
    it "answers dynamic directories" do
      expect(combined.directories).to eq(directories.dynamic)
    end
  end

  describe "#all" do
    it "answers combined directories for unset environment" do
      expect(combined.all).to contain_exactly(
        Pathname("/one"),
        Pathname("/two"),
        Pathname("/three")
      )
    end

    context "with set environment" do
      let(:home) { XDG::Paths::Standard.new XDG::Pair["TEST_HOME", nil], environment }
      let(:directories) { XDG::Paths::Directory.new XDG::Pair["TEST_DIRS", nil], environment }

      let :environment do
        {
          "HOME" => "/home",
          "TEST_HOME" => "one",
          "TEST_DIRS" => "/two"
        }
      end

      it "answers combined directories" do
        expect(combined.all).to contain_exactly(
          Pathname("/home/one"),
          Pathname("/two")
        )
      end
    end
  end

  describe "#inspect" do
    context "with home and directories pairs" do
      it "answers home and directories paths" do
        expect(combined.inspect).to eq("TEST_HOME=/one TEST_DIRS=/two:/three")
      end
    end

    context "with empty home and directories pairs" do
      let(:home) { XDG::Paths::Standard.new XDG::Pair.new, environment }
      let(:directories) { XDG::Paths::Directory.new XDG::Pair.new, environment }

      it "answers path only" do
        expect(combined.inspect).to eq("/home")
      end
    end
  end
end
