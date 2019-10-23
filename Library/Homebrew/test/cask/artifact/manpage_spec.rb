# frozen_string_literal: true

describe Cask::Artifact::Manpage, :cask do
  let(:cask_token) { "" }
  let(:cask) { Cask::CaskLoader.load(cask_path(cask_token)) }

  context "without section" do
    let(:cask_token) { "invalid/invalid-manpage-no-section" }

    it "fails to load a cask without section" do
      expect { cask }.to raise_error(Cask::CaskInvalidError, /section should be a positive number/)
    end
  end

  context "with install" do
    let(:install_phase) {
      lambda do
        cask.artifacts.select { |a| a.is_a?(described_class) }.each do |artifact|
          artifact.install_phase(command: NeverSudoSystemCommand, force: false)
        end
      end
    }

    let(:source_path) { cask.staged_path.join("manpage.1") }
    let(:expected_section) { "" }
    let(:target_path) { cask.config.manpagedir.join("man#{expected_section}/manpage.#{expected_section}") }

    before do
      InstallHelper.install_without_artifacts(cask)
    end

    context "with autodetected section" do
      let(:cask_token) { "with-autodetected-manpage-section" }
      let(:expected_section) { 1 }

      it "links the manpage to the proper directory" do
        install_phase.call

        expect(File).to be_identical target_path, source_path
      end
    end
  end
end
