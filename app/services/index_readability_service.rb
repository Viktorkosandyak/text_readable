class IndexReadabilityService
  attr_reader :content

  def initialize(content)
    @content = content
  end

  def call
    ( 206.835 - sentences_coefficient * average_sentence_length - syllables_coefficient * average_number_of_syllables_per_word ).to_i
  end

  private

  def sentences_coefficient
    ({"en" => 1.015, "uk" => 1.35 , "ru" => 1.3} [DetectLanguage.simple_detect(content)])
  end

  def syllables_coefficient
    ({"en" => 84.6, "uk" => 64.3 , "ru" => 60.1} [DetectLanguage.simple_detect(content)])
  end

  def average_sentence_length
    words_quatntity / sentences_quantity
  end

  def words_quatntity
    content.split.count
  end

  def sentences_quantity
    content.scan(/[^\.!?]+[\.!?]/).map(&:strip).count
  end

  def average_number_of_syllables_per_word
    (avarage_syllables_per_word / words_quatntity)
  end

  def avarage_syllables_per_word
    content.split.map { |word|  syllables_quantity(word) }.flatten.size.to_f
  end

  def syllables_quantity(word)
    case [DetectLanguage.simple_detect(content)]
    when ["en"] then word.scan(/[aiouy]+e*|e(?!d$|ly).|[td]ed|le$/)
    when ["uk"] then word.scan(/[аоіюяїєиу]+e*|e(?!d$|ly).|[td]ed|le$/)
    when ["ru"] then word.scan(/[аоуыэеёюяи]+e*|e(?!d$|ly).|[td]ed|le$/)
    end
  end
end