require 'set'

class WordChainer
  def initialize(dictionary_file_name)
    @dictionary = Set.new(File.readlines(dictionary_file_name).map(&:chomp))
  end

  def adjacent_words(target_word)
    @dictionary.dup.keep_if do |word|
      target_word.diff(word) == 1
    end
  end

  def run(source, target)
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
