class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(guess)
    
    raise ArgumentError, "Invalid input" if (guess == nil ) || (guess !~ /[a-zA-Z]+/) 
    
    if(guess == nil || guess !~ /[a-zA-Z]+/ )
      valid = false
    end
    
    guess.downcase!

    if(word.include?(guess))
      valid = true;
      if(@guesses.include?(guess))
        valid = false
      else
        @guesses << guess
        check_win_or_lose
        # call to method word_with_guesses here
      end
    else
      valid = wrong_guess(guess)
    end
    
    return valid
  end
  
  def wrong_guess(wrong_guess)
    if !(@wrong_guesses.include?(wrong_guess))
      @wrong_guesses << wrong_guess
      return true
    else
      return false  
    end
  end
  
  def word_with_guesses
    display = ""
    @word.split("").each do |x|
      if(@guesses.include?(x))
        display += x
      else
        display += "-"
      end
    end
    
    return display
  end
  
  def check_win_or_lose
    if @wrong_guesses.size == 7
      return :lose
    elsif @word.eql?(word_with_guesses)
      return :win
    else
      return :play
    end
  end
    
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
end
