# typed: false
# frozen_string_literal: true

require "dependable"

describe Dependable do
  alias_matcher :be_a_build_dependency, :be_build

  subject(:dependable) { double(tags: tags).extend(described_class) }

  let(:tags) { ["foo", "bar", :build] }

  specify "#options" do
    expect(dependable.options.as_flags.sort).to eq(%w[--foo --bar].sort)
  end

  specify "#build?" do
    expect(dependable).to be_a_build_dependency
  end

  specify "#optional?" do
    expect(dependable).not_to be_optional
  end

  specify "#recommended?" do
    expect(dependable).not_to be_recommended
  end
end
