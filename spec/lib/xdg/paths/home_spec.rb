# frozen_string_literal: true

require "spec_helper"

RSpec.describe XDG::Paths::Home do
  subject(:path) { described_class.new pair, environment }

  let(:pair) { XDG::Pair["TEST", "test"] }
  let(:home) { XDG::Pair["HOME", "/home"] }
  let(:environment) { home.to_env }

  describe "#initialize" do
    it "is frozen" do
      expect(path.frozen?).to be(true)
    end
  end

  describe "#default" do
    context "with custom environment" do
      let(:environment) { home.to_env.merge pair.to_env }

      it "answers path relatve to home" do
        expect(path.default).to eq(Pathname("/home/test"))
      end
    end

    context "without custom environment value" do
      let(:environment) { home.to_env.merge pair.key => nil }

      it "answers path relative to home" do
        expect(path.default).to eq(Pathname("/home/test"))
      end
    end

    context "without custom environment" do
      let(:environment) { home.to_env }

      it "answers path relative to home" do
        expect(path.default).to eq(Pathname("/home/test"))
      end
    end

    context "with missing pair value" do
      let(:pair) { XDG::Pair["TEST"] }

      it "answers home path" do
        expect(path.default).to eq(Pathname("/home"))
      end
    end

    context "with nil pair value" do
      let(:pair) { XDG::Pair["TEST", nil] }

      it "answers home path" do
        expect(path.default).to eq(Pathname("/home"))
      end
    end

    context "with empty pair" do
      let(:pair) { XDG::Pair.new }

      it "answers home path" do
        expect(path.default).to eq(Pathname("/home"))
      end
    end
  end

  describe "#dynamic" do
    context "with default value" do
      let(:environment) { home.to_env.merge pair.to_env }

      it "answers default path relative to home" do
        expect(path.dynamic).to eq(Pathname("/home/test"))
      end
    end

    context "without dynamic environment" do
      let(:environment) { home.to_env.merge pair.key => "dynamic" }

      it "answers dynamic path" do
        expect(path.dynamic).to eq(Pathname("/home/dynamic"))
      end
    end
  end

  shared_examples "a string" do |message|
    it "answers key and value with custom pair" do
      expect(path.public_send(message)).to eq("TEST=/home/test")
    end

    context "with empty pair" do
      let(:pair) { XDG::Pair.new }

      it "answers value only" do
        expect(path.public_send(message)).to eq("/home")
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
      expect(path.inspect).to match(%r(\A\#<#{described_class}:\d+ TEST=/home/test>\Z))
    end

    context "with empty pair" do
      let(:pair) { XDG::Pair.new }

      it "answers value only" do
        expect(path.inspect).to match(%r(\A\#<#{described_class}:\d+ /home>\Z))
      end
    end
  end
end
