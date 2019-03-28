require "cmd/shared_examples/args_parse"

describe "Homebrew.__prefix_args" do
  it_behaves_like "parseable arguments"
end

describe "brew --prefix", :integration_test do
  it "prints a given Formula's prefix" do
    expect { brew "--prefix", testball }
      .to output(%r{#{HOMEBREW_CELLAR}/testball}).to_stdout
      .and not_to_output.to_stderr
      .and be_a_success
  end
end
