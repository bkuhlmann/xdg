# frozen_string_literal: true

require "spec_helper"

RSpec.describe XDG::Paths::Any do
  subject(:path) { described_class.new pair, environment }

  let(:pair) { XDG::Pair["TEST", "test"] }
  let(:environment) { Hash.new }

  describe "#initialize" do
    it "is frozen" do
      expect(path.frozen?).to be(true)
    end
  end

  describe "#default" do
    it "answers expanded path relative to current directory" do
      expect(path.default).to eq(Bundler.root.join("test"))
    end

    context "with missing pair value" do
      let(:pair) { XDG::Pair["TEST"] }

      it "answers empty path" do
        expect(path.default).to eq(Pathname(""))
      end
    end

    context "with nil pair value" do
      let(:pair) { XDG::Pair["TEST", nil] }

      it "answers empty path" do
        expect(path.default).to eq(Pathname(""))
      end
    end

    context "with empty pair" do
      let(:pair) { XDG::Pair.new }

      it "answers empty path" do
        expect(path.default).to eq(Pathname(""))
      end
    end
  end

  describe "#dynamic" do
    it "answers expanded path for empty environment" do
      expect(path.dynamic).to eq(Bundler.root.join("test"))
    end

    it "answers expanded path for custom environment" do
      environment["TEST"] = "dynamic"
      expect(path.dynamic).to eq(Bundler.root.join("dynamic"))
    end
  end

  shared_examples "a string" do |message|
    it "answers key and value with custom pair" do
      expect(path.public_send(message)).to eq(%(TEST=#{Bundler.root.join "test"}))
    end

    context "with empty pair" do
      let(:pair) { XDG::Pair.new }

      it "answers empty string" do
        expect(path.public_send(message)).to eq("")
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
    it "answers key and value with custom pair" do
      expect(path.inspect).to match(
        %r(\A\#<#{described_class}:\d+ TEST=#{Bundler.root.join "test"}>\Z)
      )
    end

    context "with empty pair" do
      let(:pair) { XDG::Pair.new }

      it "answers blank path" do
        expect(path.inspect).to match(%r(\A\#<#{described_class}:\d+ >\Z))
      end
    end
  end
end
