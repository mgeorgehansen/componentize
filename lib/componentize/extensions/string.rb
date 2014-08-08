## Copyright M. George Hansen, 2014
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

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
