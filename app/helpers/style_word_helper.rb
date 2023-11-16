module StyleWordHelper
  def style_words(input_string)
    words = input_string.scan(/\b\w+\b/) # Use regex to find words
    styled_string = input_string.dup
    words = words.join(' ')

    styled_string.gsub!(words, "<span class='user_last_name_profile'>#{words}</span>")

    styled_string.html_safe
  end
end
