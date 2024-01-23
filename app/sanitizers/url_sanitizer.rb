class URLSanitizer
  def self.call(url)
    CGI.unescape(url)
  end
end
