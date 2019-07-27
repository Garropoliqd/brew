# frozen_string_literal: true

require "cmd/shared_examples/args_parse"

describe "Homebrew.upgrade_args" do
  it_behaves_like "parseable arguments"
end

describe "brew upgrade", :integration_test do
  it "upgrades a Formula and cleans up old versions" do
    setup_test_formula "testball"
    (HOMEBREW_CELLAR/"testball/0.0.1/foo").mkpath

    expect { brew "upgrade" }.to be_a_success

    expect(HOMEBREW_CELLAR/"testball/0.1").to be_a_directory
    expect(HOMEBREW_CELLAR/"testball/0.0.1").not_to exist
  end

  it "can do a dry run upgrade" do
    setup_test_formula "testball"
    (HOMEBREW_CELLAR/"testball/0.0.1/foo").mkpath

    expect { brew "upgrade", "--dry-run" }
       .to output(/Dry run: did not upgrade anything/).to_stdout
       .and not_to_output.to_stderr
       .and be_a_success

    expect(HOMEBREW_CELLAR/"testball/0.1").not_to exist
    expect(HOMEBREW_CELLAR/"testball/0.0.1").to be_a_directory
  end
end
