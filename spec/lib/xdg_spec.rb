# frozen_string_literal: true

require "spec_helper"

RSpec.describe XDG do
  describe ".new" do
    it "answers environment instance" do
      expect(described_class.new).to be_a(XDG::Environment)
    end
  end
end
