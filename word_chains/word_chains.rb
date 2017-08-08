require 'set'

class WordChainer

  attr_reader :all_seen_words
  def initialize(dictionary_file_name)
    @dictionary = Set.new(File.readlines(dictionary_file_name).map(&:chomp))
  end

  def adjacent_words(target_word)
    @dictionary.dup.keep_if { |word| target_word.diff(word) == 1 }
  end

  def run(source, target)

  end

  def all_adjacent_words(target_word)
    queue = adjacent_words(target_word).to_a
    all_adjacent_words = Set.new
    until queue.empty?
      word = queue.shift
      next_adj = adjacent_words(word)
      next_adj.each do |word|
        queue << word unless all_adjacent_words.include?(word)
        all_adjacent_words << word
      end
    end
    all_adjacent_words
  end
end

class String
  def diff(string)
    return -1 if length != string.length
    letters = split('')
    diff_chrs = letters.reject.with_index { |chr, idx| chr == string[idx] }
    diff_chrs.length
  end
end
