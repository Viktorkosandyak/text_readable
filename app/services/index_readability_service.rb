# frozen_string_literal: true 

class IndexReadabilityService
  attr_reader :content

  def initialize(content)
    @content = content
  end
  
  def calculate
    (206.835 - 1.015 * average_sentence_length - 84.6 * average_number_of_syllables_per_word).to_i
  end

  private

  def average_number_of_syllables_per_word
    (avarage_syllables_per_word / words_quatntity)
  end

  def avarage_syllables_per_word
    content.split.map { |x| x.scan(/[aiouy]+e*|e(?!d$|ly).|[td]ed|le$/) }.flatten.size.to_f
  end

  def words_quatntity
    content.split.count
  end

  def average_sentence_length
    words_quatntity / sentences_quantity
  end

  def sentences_quantity
    content.scan(/[^\.!?]+[\.!?]/).map(&:strip).count
  end
end