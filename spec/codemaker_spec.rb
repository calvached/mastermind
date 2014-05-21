require 'codemaker'

describe CodeMaker do
  context "position matches" do
    it "returns 4 if the guess matches pattern exactly" do
      codemaker = CodeMaker.new
      codemaker.unsolved_pattern = ["A", "B", "C", "D"]
      expect(codemaker.give_feedback(["A", "B", "C", "D"])).to eq(["o", "o", "o", "o"])
    end

    it "returns 0 if the guess has no letters in the same position as the pattern" do
      codemaker = CodeMaker.new
      codemaker.unsolved_pattern = ["A", "B", "C", "D"]
      expect(codemaker.give_feedback(["F", "F", "F", "F"])).to eq([])
    end

    it "returns 3 if the guess has 3 letters in the same position as the pattern" do
      codemaker = CodeMaker.new
      codemaker.unsolved_pattern = ["A", "B", "C", "D"]
      expect(codemaker.give_feedback(["A", "B", "C", "F"])).to eq(["o", "o", "o"])
    end

    it "returns 2 if the guess has 2 letters in the same position as the pattern" do
      codemaker = CodeMaker.new
      codemaker.unsolved_pattern = ["A", "B", "C", "D"]
      expect(codemaker.give_feedback(["A", "B", "F", "F"])).to eq(["o", "o"])
    end

    it "returns 1 if the guess has 1 letter in the same position as the pattern" do
      codemaker = CodeMaker.new
      codemaker.unsolved_pattern = ["A", "B", "C", "D"]
      expect(codemaker.give_feedback(["A", "F", "F", "F"])).to eq(["o"])
    end
  end

  context "letter matches" do
    it "returns 4 if the guess has 4 letters in the wrong position but exists in the pattern" do
      codemaker = CodeMaker.new
      codemaker.unsolved_pattern = ["A", "B", "C", "D"]
      expect(codemaker.give_feedback(["D", "C", "B", "A"])).to eq(["x", "x", "x", "x"])
    end

    it "returns 3 if the guess has 3 letters in the wrong position but exists in the pattern" do
      codemaker = CodeMaker.new
      codemaker.unsolved_pattern = ["A", "B", "C", "D"]
      expect(codemaker.give_feedback(["D", "C", "B", "F"])).to eq(["x", "x", "x"])
    end

    it "returns 2 if the guess has 2 letters in the wrong position but exists in the pattern" do
      codemaker = CodeMaker.new
      codemaker.unsolved_pattern = ["A", "B", "C", "D"]
      expect(codemaker.give_feedback(["B", "A", "F", "F"])).to eq(["x", "x"])
    end

    it "returns 1 if the guess has 1 letters in the wrong position but exists in the pattern" do
      codemaker = CodeMaker.new
      codemaker.unsolved_pattern = ["A", "B", "C", "D"]
      expect(codemaker.give_feedback(["B", "F", "F", "F"])).to eq(["x"])
    end
  end

  context "position & letter matches combined" do
    it "returns 1 exact match and 1 letter match if the guess has 1 letters in the wrong position and 1 letter in the correct position" do
        codemaker = CodeMaker.new
        codemaker.unsolved_pattern = ["A", "B", "C", "D"]
        expect(codemaker.give_feedback(["A", "F", "B", "F"])).to eq(["x", "o"])
    end
  end

# duplicate letters
end