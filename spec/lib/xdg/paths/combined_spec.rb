# frozen_string_literal: true

require "spec_helper"

RSpec.describe XDG::Paths::Combined do
  subject(:combined) { described_class.new home, directories }

  let(:home) { XDG::Paths::Home.new XDG::Pair["TEST_HOME", "/one"], environment }
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

    it "answers combined directories when dynamic home path answers multiple paths" do
      allow(home).to receive(:dynamic).and_return([Pathname("/inject_a"), Pathname("/inject_b")])

      expect(combined.all).to contain_exactly(
        Pathname("/inject_a"),
        Pathname("/inject_b"),
        Pathname("/two"),
        Pathname("/three")
      )
    end

    context "with set environment" do
      let(:home) { XDG::Paths::Home.new XDG::Pair["TEST_HOME", nil], environment }
      let(:directories) { XDG::Paths::Directory.new XDG::Pair["TEST_DIRS", nil], environment }

      let :environment do
        {
          "HOME" => "/home",
          "TEST_HOME" => "one",
          "TEST_DIRS" => "/two"
        }
      end

      it "answers combined directories" do
        expect(combined.all).to contain_exactly(Pathname("/home/one"), Pathname("/two"))
      end
    end
  end

  shared_examples "a string" do |message|
    context "with home and directories pairs" do
      it "answers home and directories paths" do
        expect(combined.public_send(message)).to eq("TEST_HOME=/one TEST_DIRS=/two:/three")
      end
    end

    context "with empty home and directories pairs" do
      let(:home) { XDG::Paths::Home.new XDG::Pair.new, environment }
      let(:directories) { XDG::Paths::Directory.new XDG::Pair.new, environment }

      it "answers path only" do
        expect(combined.public_send(message)).to eq("/home")
      end
    end
  end

  describe "#to_s" do
    it_behaves_like "a string", :to_s
  end

  describe "#to_str" do
    it_behaves_like "a string", :to_str
  end

  describe "#inspect" do
    it "answers home and directory paths with home and directory pairs" do
      expect(combined.inspect).to match(
        %r(\A\#<#{described_class}:\d+ TEST_HOME=/one TEST_DIRS=/two:/three>\Z)
      )
    end

    context "with empty home and directories pairs" do
      let(:home) { XDG::Paths::Home.new XDG::Pair.new, environment }
      let(:directories) { XDG::Paths::Directory.new XDG::Pair.new, environment }

      it "answers path only" do
        expect(combined.inspect).to match(%r(\A\#<#{described_class}:\d+ /home>\Z))
      end
    end
  end
end
