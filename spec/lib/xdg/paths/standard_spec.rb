# frozen_string_literal: true

require "spec_helper"

RSpec.describe XDG::Paths::Standard do
  subject(:path) { described_class.new pair, environment }

  let(:pair) { XDG::Pair.new "TEST", "test" }
  let(:home) { XDG::Pair.new "HOME", "/home" }
  let(:environment) { home.to_env }

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
      let(:pair) { XDG::Pair.new "TEST" }

      it "answers home path" do
        expect(path.default).to eq(Pathname("/home"))
      end
    end

    context "with nil pair value" do
      let(:pair) { XDG::Pair.new "TEST", nil }

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
end
