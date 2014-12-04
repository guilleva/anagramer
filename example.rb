require_relative 'lib/anagramer'

anagramer = Anagramer::Anagram.new

anagramer.load_words('fixtures/words.txt')

print 'Example 1: Anagrams for BAT: '
puts anagramer.find(['BAT']).join(', ')

print 'Example 2: Anagrams for cat: '
puts anagramer.find(['cat']).join(', ')

print 'Example 3: Anagrams for CAT+BAT: '
puts anagramer.find(['CAT', 'BAT']).join(', ')

print 'Example 3: Anagrams for CAT+BAT+TAC+TAB: '
puts anagramer.find(['CAT', 'BAT', 'TAC', 'TAB']).join(', ')