# frozen_string_literal: true 

class IndexReadabilityService
  attr_reader :content

  def initialize(content)
    @content = content
  end
  
  def calculate
    (206.835 - 1.015 * average_sentence_length - 84.6 * average_number_of_syllables_per_word)
  end

  private

  def average_number_of_syllables_per_word
    count_word = content.split.count
    syllable_in_word = content.split.map do |x|
      x.scan(/[aiouy]+e*|e(?!d$|ly).|[td]ed|le$/)
    end
    amount = 0
    syllable_in_word.map{ |arr| amount += arr.size }
    (amount.to_f / count_word)
  end

  def average_sentence_length
    @count_sentence = content.scan(/[^\.!?]+[\.!?]/).map(&:strip).count
    more_accurate_count_sentence
    count_words = 1
    for i in 1..content.length
      count_words += 1 if (content[i] == ' ')
    end
    count_words.to_f / @count_sentence
  end

  def more_accurate_count_sentence
    if @count_sentence == 0   
      @count_sentence += 1
    elsif content[-1] == '.' || content[-1] == '?' || content[-1] == '!'  
      @count_sentence
    else  
      @count_sentence += 1
    end
  end
end