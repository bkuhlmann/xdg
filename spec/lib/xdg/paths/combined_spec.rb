# frozen_string_literal: true

require "spec_helper"

RSpec.describe XDG::Paths::Combined do
  subject(:combined) { described_class.new home, directories }

  let :home do
    XDG::Paths::Standard.new XDG::Pair["TEST_HOME", "/one"], environment
  end

  let :directories do
    XDG::Paths::Directory.new XDG::Pair["TEST_DIRS", "/two:/three"], environment
  end

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
      let :home do
        XDG::Paths::Standard.new XDG::Pair["TEST_HOME", nil], environment
      end

      let :directories do
        XDG::Paths::Directory.new XDG::Pair["TEST_DIRS", nil], environment
      end

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
end
