require "language/java"

describe Language::Java do
  describe "#self.java_home_env" do
    it "returns java_home path with version if version specified" do
      java_home = described_class.java_home_env("blah")
      expect(java_home[:JAVA_HOME]).to include("--version blah")
    end

    it "returns java_home path without version if version is not specified" do
      java_home = described_class.java_home_env
      expect(java_home[:JAVA_HOME]).not_to include("--version")
    end
  end

  describe "#self.overridable_java_home_env" do
    let(:JAVA_HOME) { "haha" }
    it "returns java_home path with version if version specified" do
      java_home = described_class.overridable_java_home_env("blah")
      expect(java_home[:JAVA_HOME]).to eq("haha")
    end

    it "returns java_home path without version if version is not specified" do
      java_home = described_class.overridable_java_home_env
      expect(java_home[:JAVA_HOME]).not_to include("--version")
    end
  end
end
