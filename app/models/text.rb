class Text < ApplicationRecord
  belongs_to :user

  def count_syllables_in_text
    syllables_in_words = []
    word_array = split_text_on_words(self.body)
    word_array.each do |word|
      if self.language == 'english'	
        syllables_in_words << word.scan(/[aiouy]+e*|e(?!d$|ly).|[td]ed|le$/).size
      elsif self.language == 'russian'
      	syllables_in_words << word.scan(/[АЕУЫЯИЮЁЭОауяиеоюёэ]/).size
      elsif self.language == 'ukrainian'
      	syllables_in_words << word.scan(/[АЕУІЯИОЄЮЇауяіеоиюєї]/).size
      end
    end
    average_word_length = syllables_in_words.sum / syllables_in_words.count
    self.asw = average_word_length
  end

  def split_text_on_words(text)
    word_array = nil
    if self.language == 'english'
      cleaned_text = text.gsub(/\W+/, ' ')
      word_array   = cleaned_text.split(' ')
    else
      cleaned_text = text.gsub(/\(+|\!+|\.+|\-+|\?+|\d+|\$+|\,+|\[+|\]+|\)+|\++|%+|\*+/, '')
      word_array   = cleaned_text.split(' ') 
    end
    word_array
  end

  def count_words_in_sentences
    words_in_each_sentence = []
    sentences_in_text      = self.body.split(/[.?!]+/)
    sentences_in_text.each do |sentence|
      words_in_each_sentence << sentence.split(' ').size
    end
    average_sentence_length = words_in_each_sentence.sum / words_in_each_sentence.count
    self.asl = average_sentence_length
  end

  def calculate_fre
  	fre_index = nil
  	if self.language == 'english'
  	  fre_index = 206.835 - (1.015 * self.asl) - (84.6 * self.asw)
    elsif self.language == 'ukrainian'
      fre_index = 206.835 - (1.35 * self.asl) - (64.3 * self.asw)
    elsif self.language == 'russian'
      fre_index = 206.835 - (1.3 * self.asl) - (60.1 * self.asw)
    end
    self.fre = fre_index
  end

end
