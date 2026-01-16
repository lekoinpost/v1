# app/services/turnstile_verifier.rb
require "net/http"
require "json"

class TurnstileVerifier
  def self.verify(token, ip)
    return false if token.blank?

    response = Net::HTTP.post_form(
      URI("https://challenges.cloudflare.com/turnstile/v0/siteverify"),
      {
        secret: ENV["TURNSTILE_SECRET_KEY"],
        response: token,
        remoteip: ip
      }
    )

    JSON.parse(response.body)["success"] == true
  rescue
    false
  end
end
