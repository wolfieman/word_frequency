#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  #Implement the following read-only attributes in the LineAnalyzer class. 
  #* highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
  #* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  #* content          - the string analyzed (provided)
  #* line_number      - the line number analyzed (provided)
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  #Add the following methods in the LineAnalyzer class.
  #* initialize() - taking a line of text (content) and a line number
  #* calculate_word_frequency() - calculates result
  def initialize (content, line_number)
    @content = content
    @line_number = line_number
    @highest_wf_count = 0
    @highest_wf_words = []
    
    calculate_word_frequency(content)
  end

  #Implement the initialize() method to:
  #* take in a line of text and line number
  #* initialize the content and line_number attributes
  #* call the calculate_word_frequency() method.

  #Implement the calculate_word_frequency() method to:
  #* calculate the maximum number of times a single word appears within
  #  provided content and store that in the highest_wf_count attribute.
  #* identify the words that were used the maximum number of times and
  #  store that in the highest_wf_words attribute.
  def calculate_word_frequency(content)
    word_frequency = Hash.new(0)

    content.split.each do |word| 
      word_frequency[word.downcase] += 1 
    end
    @highest_wf_count = word_frequency.values.max

    #max_words = word_frequency.select { |k, v| v == word_frequency.values.max}
    word_frequency.select { |k, v| v == word_frequency.values.max}.each_key {|key| @highest_wf_words.push(key)}
  end
end

#  Implement a class called Solution. 
class Solution

  # Implement the following read-only attributes in the Solution class.
  #* analyzers - an array of LineAnalyzer objects for each line in the file
  #* highest_count_across_lines - a number with the maximum value for highest_wf_words attribute in the analyzers array.
  #* highest_count_words_across_lines - a filtered array of LineAnalyzer objects with the highest_wf_words attribute 
  #  equal to the highest_count_across_lines determined previously.
  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines
  attr_accessor :filename, :highest_wf_words

  def initialize ()
    @analyzers = []
    @filename = './test.txt'
    @hash_highest_count_words_across_lines = []
  end

  # Implement the following methods in the Solution class.
  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers.
  #* calculate_line_with_highest_frequency() - determines the highest_count_across_lines and 
  #  highest_count_words_across_lines attribute values
  #* print_highest_word_frequency_across_lines() - prints the values of LineAnalyzer objects in 
  #  highest_count_words_across_lines in the specified format
  
  # Implement the analyze_file() method() to:
  #* Read the 'test.txt' file in lines 
  #* Create an array of LineAnalyzers for each line in the file
  def analyze_file()
    if File.exist? @filename
      File.foreach( filename ).with_index do |line, line_number|
        @analyzers.push LineAnalyzer.new(line.to_s, line_number+1)
      end
    end
  end

  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
  #  and stores this result in the highest_count_across_lines attribute.
  #* identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines 
  #  attribute value determined previously and stores them in highest_count_words_across_lines.
  def calculate_line_with_highest_frequency()
    @highest_count_across_lines = 0
    @highest_wf_words = 0
    @highest_count_words_across_lines = []
    
    @analyzers.each do |item|
      @highest_count_across_lines = item.highest_wf_count if @highest_count_across_lines < item.highest_wf_count

      if @highest_count_across_lines == item.highest_wf_count
        @hash_highest_count_words_across_lines.push(item.highest_wf_words => item.line_number)
        @highest_wf_words = item.highest_wf_count
        @highest_count_words_across_lines.push(item.highest_wf_words)
      end
    end
    p highest_count_words_across_lines
    @highest_count_words_across_lines = @highest_count_words_across_lines.reverse.flatten
    p highest_count_words_across_lines
  end

  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the values of objects in highest_count_words_across_lines in the specified format
  #The following words have the highest word frequency per line: 
  #["word1"] (appears in line #)
  #["word2", "word3"] (appears in line #)
  def print_highest_word_frequency_across_lines()
    puts "The following words have the highest word frequency per line:"
    @hash_highest_count_words_across_lines.flatten.each do |hash|
      hash.each do |word, line_number|
        puts "#{word} (appears in line #{line_number})"
      end
    end
  end
end

#content1 = LineAnalyzer.new("This is a really really really cool cool you you you", 2)

#testfile = Solution.new()
#testfile.analyze_file('./test.txt')
#p testfile.analyzers[0]
#testfile.calculate_line_with_highest_frequency()

solution = Solution.new
#expect errors until you implement these methods
solution.analyze_file
solution.calculate_line_with_highest_frequency
solution.print_highest_word_frequency_across_lines
