module Anagramer
  class Anagram
    attr_accessor :anagrams

    def initialize
      @anagrams = Hash.new { |hash, key| hash[key] = [] }
    end

    def load_words(file_path)
      File.open(file_path, 'r') do |f|
        f.each_line do |word|
          word.gsub!("\n", '')
          @anagrams[anagram_key(word)].push word
        end
      end
      @anagrams
    end

    def find(words)
      [].tap do |result|
        words.map { |w| anagram_key(w) }.uniq.each do |key|
          result.concat @anagrams[key]
        end
      end
    end

    protected

    # generates a key for a given word that should be common
    # between its anagrams. If all the words are in upper case or
    # down case, we could remove the ".downcase" part to improve
    # performance and reduce memory usage
    def anagram_key(word)
      word.downcase.chars.sort.join
    end
  end
end