require 'uri'
require 'net/http'
class Erlyfire

  def initialize(url_string)
    @url = URI.parse(url_string)
  end

  def message(body)
    send(body, false)
  end

  def paste(body)
    send(body, true)
  end

  private

  def send(message, paste)
    req = Net::HTTP::Post.new(@url.path)
    req.set_form_data({'message'=> message, 'paste' => paste})
    res = Net::HTTP.new(@url.host, @url.port).start {|http| http.request(req) }
    case res
    when Net::HTTPSuccess
      true
    else
      false
    end
  end

end