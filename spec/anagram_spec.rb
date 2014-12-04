require 'spec_helper'

module Anagramer
  describe Anagram do
    describe 'load_words method' do
      it 'returns empty hash if the file is empty' do
        mock_file_content :some_path, ""

        expect(subject.load_words(:some_path)).to be_empty
      end

      it 'groups all words under the same key' do
        mock_file_content :some_path, "ACT\nBAT\nCAT\nTAB\nTAC"

        expect(subject.load_words(:some_path)).to eql({
          "ACT" => ["ACT", "CAT", "TAC"],
          "ABT" => ["BAT", "TAB"]})
      end
    end

    describe 'find' do
      it 'returns empty array if the anagrams list is empty' do
        expect(subject.find(['CAT'])).to be_empty
      end

      it 'returns all the anagrams for the given word' do
        subject.anagrams = {"ACT" => ["ACT", "CAT", "TAC"]}

        expect(subject.find(['CAT'])).to match_array([
          "ACT", "CAT", "TAC"])

        expect(subject.find(['TAC'])).to match_array([
          "ACT", "CAT", "TAC"])

        expect(subject.find(['ACT'])).to match_array([
          "ACT", "CAT", "TAC"])
      end

      it 'returns all the different anagrams for the given words' do
        subject.anagrams = {
          "ACT" => ["ACT", "CAT", "TAC"],
          "ABT" => ["BAT", "TAB"]}

        expect(subject.find(['CAT', 'BAT'])).to match_array([
          "ACT", "CAT", "TAC", "BAT", "TAB"])
      end

      it 'does not return duplicated words' do
        subject.anagrams = {"ACT" => ["ACT", "CAT", "TAC"]}

        expect(subject.find(['CAT', 'TAC'])).to match_array([
          "ACT", "CAT", "TAC"])

        expect(subject.find(['TAC', 'CAT', 'ACT'])).to match_array([
          "ACT", "CAT", "TAC"])
      end
    end


    def mock_file_content(name, content)
      expect(File).to receive(:open).with(name, 'r').and_yield(
        StringIO.new(content))
    end
  end

end