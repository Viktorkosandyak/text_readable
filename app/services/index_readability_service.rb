# frozen_string_literal: true 

class IndexReadabilityService
  attr_reader :content

  def initialize(content)
    @content = content
  end

  def calculate
    (206.835 - sentences_coefficient[locale] * average_sentence_length - syllables_coefficient[locale] * average_number_of_syllables_per_word).to_i
  end

  private

  def syllables_coefficient
    {en: 84.6, ru:  60.1, ua: 64.3 }
  end

  def sentences_coefficient
    {en: 1.015, ru: 1.3, ua: 1.35 }
  end

  def locale
    :en
  end

  def average_number_of_syllables_per_word
    (avarage_syllables_per_word / words_quatntity)
  end

  def avarage_syllables_per_word
    content.split.map { |word|  syllables_quantity(word) }.flatten.size.to_f
  end

  def syllables_quantity(word)
    case locale
    when :en then word.scan(/[aiouy]+e*|e(?!d$|ly).|[td]ed|le$/)
    when :ua then word.scan(/[аоіюяїєиу]+e*|e(?!d$|ly).|[td]ed|le$/)
    when :ru then word.scan(/[аоуыэеёюяи]+e*|e(?!d$|ly).|[td]ed|le$/)
    end
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