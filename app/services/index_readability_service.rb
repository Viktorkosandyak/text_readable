class IndexReadabilityService

  def self.calculate(content)
    average_number_of_syllables_per_word(content)
    average_sentence_length(content)
    result = (206.835 - 1.015 * @asl.to_f - 84.6 * @asw.to_f)
    if result < 0
      result = 0
    end
    result
  end

  private

  def self.average_number_of_syllables_per_word(content)
    count_word = content.split.count
    syllable_in_word = content.split.map do |x|
      x.scan(/[aiouy]+e*|e(?!d$|ly).|[td]ed|le$/)
    end
    amount = 0
    syllable_in_word.map{|arr| amount += arr.size }
    @asw = (amount.to_f/count_word)
  end

  def self.average_sentence_length(content)
    @count_sentence = content.scan(/[^\.!?]+[\.!?]/).map(&:strip).count
    more_accurate_count_sentence(content)
    count_words = 1
    for i in 1..content.length
      if (content[i] == ' ')
        count_words +=1
      end
    end
    @asl = count_words.to_f/@count_sentence
  end

  def self.more_accurate_count_sentence(content)
    if @count_sentence == 0   
      @count_sentence += 1
    elsif content[-1] == '.' || content[-1] == '?' || content[-1] == '!'  
      @count_sentence
    else  
      @count_sentence += 1
    end
  end
end