PuppetLint.new_check(:uncuddled_else) do
  def check
    tokens.each do |token|
      next unless token.type == :ELSE || token.type == :ELSIF

      ## 'else/elsif' should follow closing curly and whitespaces
      prev1 = token.prev_token
      prev2 = prev1.prev_token
      next if prev1.type == :WHITESPACE && prev2.type == :RBRACE

      ## otherwise it's not a cuddled else/elsif
      notify :warning, {
        :message => "found uncuddled #{token.type.to_s.downcase}, should be on same line as closing curly",
        :line    => token.line,
        :column  => token.column,
      }
    end
  end
end
