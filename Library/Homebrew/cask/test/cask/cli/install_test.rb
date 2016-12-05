require "test_helper"

describe Hbc::CLI::Install do
  it "allows staging and activation of multiple Casks at once" do
    shutup do
      Hbc::CLI::Install.run("local-transmission", "local-caffeine")
    end

    Hbc.load("local-transmission").must_be :installed?
    Hbc.appdir.join("Transmission.app").must_be :directory?
    Hbc.load("local-caffeine").must_be :installed?
    Hbc.appdir.join("Caffeine.app").must_be :directory?
  end

  it "skips double install (without nuking existing installation)" do
    shutup do
      Hbc::CLI::Install.run("local-transmission")
    end
    shutup do
      Hbc::CLI::Install.run("local-transmission")
    end
    Hbc.load("local-transmission").must_be :installed?
  end

  it "prints a warning message on double install" do
    shutup do
      Hbc::CLI::Install.run("local-transmission")
    end

    lambda {
      Hbc::CLI::Install.run("local-transmission", "")
    }.must_output nil, /Warning: A Cask for local-transmission is already installed./
  end

  it "allows double install with --force" do
    shutup do
      Hbc::CLI::Install.run("local-transmission")
    end

    lambda {
      Hbc::CLI::Install.run("local-transmission", "--force")
    }.must_output(/local-transmission was successfully installed!/)
  end

  it "skips dependencies with --skip-cask-deps" do
    shutup do
      Hbc::CLI::Install.run("with-depends-on-cask-multiple", "--skip-cask-deps")
    end
    Hbc.load("with-depends-on-cask-multiple").must_be :installed?
    Hbc.load("local-caffeine").wont_be :installed?
    Hbc.load("local-transmission").wont_be :installed?
  end

  it "properly handles Casks that are not present" do
    lambda {
      shutup do
        Hbc::CLI::Install.run("notacask")
      end
    }.must_raise Hbc::CaskError
  end

  it "returns a suggestion for a misspelled Cask" do
    lambda {
      begin
        Hbc::CLI::Install.run("googlechrome")
      rescue Hbc::CaskError
        nil
      end
    }.must_output(nil, /No available Cask for googlechrome\. Did you mean:\ngoogle-chrome/)
  end

  it "returns multiple suggestions for a Cask fragment" do
    lambda {
      begin
        Hbc::CLI::Install.run("google")
      rescue Hbc::CaskError
        nil
      end
    }.must_output(nil, /No available Cask for google\. Did you mean one of:\ngoogle/)
  end

  describe "when no Cask is specified" do
    with_options = lambda do |options|
      it "raises an exception" do
        lambda {
          Hbc::CLI::Install.run(*options)
        }.must_raise Hbc::CaskUnspecifiedError
      end
    end

    describe "without options" do
      with_options.call([])
    end

    describe "with --force" do
      with_options.call(["--force"])
    end

    describe "with --skip-cask-deps" do
      with_options.call(["--skip-cask-deps"])
    end

    describe "with an invalid option" do
      with_options.call(["--notavalidoption"])
    end
  end
end
