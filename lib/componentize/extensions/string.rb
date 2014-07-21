class String
  alias_method :strip_ws, :strip

  def strip(chars = '')
    if chars.empty?
      self.strip_ws
    else
      chars = Regexp.escape(chars)
      self.gsub(/\A[#{chars}]+|[#{chars}]+\Z/, '')
    end
  end

  def strip!(chars = '')
    self.replace(self.strip(chars))
  end

  def dasherize
    self.gsub(/[^\p{Alnum}-]/, '-').strip('-')
  end
end
