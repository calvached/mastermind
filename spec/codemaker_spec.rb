require 'simplecov'
SimpleCov.start

require 'codemaker'

describe CodeMaker do

  context 'Game status' do
    it 'returns the game status as true if the pattern is an exact match' do
      codemaker = CodeMaker.new
      codemaker.unsolved_pattern = ["A", "B", "C", "D"]
      codemaker.give_feedback(["A", "B", "C", "D"])
      expect(codemaker.solved_pattern).to eq(true)
    end

    it 'returns the game status as false until the game is solved' do
      codemaker = CodeMaker.new
      codemaker.unsolved_pattern = ["A", "B", "C", "D"]
      codemaker.give_feedback(["F", "F", "F", "F"])
      expect(codemaker.solved_pattern).to eq(false)
    end
  end

  context "position matches" do
    it "returns 4 if the guess matches pattern exactly" do
      codemaker = CodeMaker.new
      codemaker.unsolved_pattern = ["A", "B", "E", "E"]
      expect(codemaker.give_feedback(["A", "B", "E", "E"])).to eq(["o", "o", "o", "o"])
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

    it 'returns 2 if guess has 2 duplicate letters in the same position as the pattern' do
        codemaker = CodeMaker.new
        codemaker.unsolved_pattern = ["A", "B", "A", "D"]
        expect(codemaker.give_feedback(['A', 'A', 'A', 'F'])).to eq(['o','o'])
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

    it 'returns 2 if the guess has 2 letters in the wrong position, but should not take into account any duplicate letters' do
      codemaker = CodeMaker.new
      codemaker.unsolved_pattern = ["A", "B", "C", "D"]
      expect(codemaker.give_feedback(["B", "A", "A", "A"])).to eq(["x", "x"])
    end
  end

  context "position & letter matches combined" do
    it "returns 1 exact match and 1 letter match if the guess has 1 letters in the wrong position and 1 letter in the correct position" do
        codemaker = CodeMaker.new
        codemaker.unsolved_pattern = ["A", "B", "C", "D"]
        expect(codemaker.give_feedback(["A", "F", "B", "F"])).to eq(["o", "x"])
    end

    it 'returns 2 exact matches and 2 letter matches if the guess has 2 letters in the correct position and 2 letters in the wrong position' do
        codemaker = CodeMaker.new
        codemaker.unsolved_pattern = ["A", "B", "C", "D"]
        expect(codemaker.give_feedback(["A", "C", "B", "D"])).to eq(["o", "o", "x", "x"])
    end

    it 'returns 1 exact matches and 2 letter matches if the guess has 1 letter in the correct position and 2 letters in the wrong position' do
      codemaker = CodeMaker.new
      codemaker.unsolved_pattern = ["D", "B", "D", "A"]
      expect(codemaker.give_feedback(["A", "D", "D", "D"])).to eq(["o", "x", "x"])
    end

    it 'returns 2 exact matches if the guess has 2 letters in the correct position' do
      codemaker = CodeMaker.new
      codemaker.unsolved_pattern = ["E", "D", "E", "C"]
      expect(codemaker.give_feedback(["E", "D", "D", "D"])).to eq(["o", "o"])
    end
  end
end