# frozen_string_literal: true

require "spec_helper"

RSpec.describe XDG::Paths::Directory do
  subject(:path) { described_class.new pair, environment }

  let(:home) { XDG::Pair["HOME", "/home"] }
  let(:environment) { home.to_env }

  describe "#initialize" do
    let(:pair) { XDG::Pair["TEST_DIRS", "/one"] }

    it "is frozen" do
      expect(path.frozen?).to be(true)
    end
  end

  describe "#default" do
    context "with single path" do
      let(:pair) { XDG::Pair["TEST_DIRS", "/one"] }

      it "answers array with one path" do
        expect(path.default).to contain_exactly(Pathname("/one"))
      end
    end

    context "with multiple paths" do
      let(:pair) { XDG::Pair["TEST_DIRS", "/one:/two:/three"] }

      it "answers array with multiple paths" do
        expect(path.default).to contain_exactly(
          Pathname("/one"),
          Pathname("/two"),
          Pathname("/three")
        )
      end
    end

    context "with tilda value" do
      let(:pair) { XDG::Pair["TEST_DIRS", "~/test"] }

      it "answers expanded paths" do
        expect(path.default).to contain_exactly(Pathname(File.join(Dir.home, "test")))
      end
    end

    context "with nil pair value" do
      let(:pair) { XDG::Pair["TEST_DIRS", nil] }

      it "answers empty array" do
        expect(path.default).to eq([])
      end
    end

    context "with nil pair key and value" do
      let(:pair) { XDG::Pair[nil, nil] }

      it "answers empty array" do
        expect(path.default).to eq([])
      end
    end
  end

  describe "#dynamic" do
    context "with pair unset and environment set" do
      let(:pair) { XDG::Pair["TEST_DIRS", nil] }
      let(:environment) { home.to_env.merge "TEST_DIRS" => "/one:/two" }

      it "answers environment paths" do
        expect(path.dynamic).to contain_exactly(Pathname("/one"), Pathname("/two"))
      end
    end

    context "with pair set and environment unset" do
      let(:pair) { XDG::Pair["TEST_DIRS", "/one:/two"] }
      let(:environment) { home.to_env.merge "TEST_DIRS" => nil }

      it "answers default paths" do
        expect(path.dynamic).to contain_exactly(Pathname("/one"), Pathname("/two"))
      end
    end

    context "with empty pair and environment" do
      let(:pair) { XDG::Pair.new }
      let(:environment) { {} }

      it "answers empty array" do
        expect(path.dynamic).to eq([])
      end
    end

    context "with duplicate directories" do
      let(:pair) { XDG::Pair["TEST_DIRS", "/one:/two:/one"] }

      it "answers unique directories" do
        expect(path.dynamic).to contain_exactly(Pathname("/one"), Pathname("/two"))
      end
    end

    context "with nil pair value" do
      let(:pair) { XDG::Pair["TEST_DIRS", nil] }

      it "answers empty array" do
        expect(path.dynamic).to eq([])
      end
    end

    context "with nil pair key and value" do
      let(:pair) { XDG::Pair[nil, nil] }

      it "answers empty array" do
        expect(path.dynamic).to eq([])
      end
    end
  end

  shared_examples "a string" do |message|
    context "with custom pair" do
      let(:pair) { XDG::Pair["TEST_DIRS", "/one:/two:/three"] }

      it "answers custom pair" do
        expect(path.public_send(message)).to eq("TEST_DIRS=/one:/two:/three")
      end
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
    context "with custom pair" do
      let(:pair) { XDG::Pair["TEST_DIRS", "/one:/two:/three"] }

      it "answers custom pair" do
        expect(path.inspect).to match(
          %r(\A\#<#{described_class}:\d+ TEST_DIRS=/one:/two:/three>\Z)
        )
      end
    end

    context "with empty pair" do
      let(:pair) { XDG::Pair.new }

      it "answers no key or value" do
        expect(path.inspect).to match(%r(\A\#<#{described_class}:\d+>\Z))
      end
    end
  end
end
