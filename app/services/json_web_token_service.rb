##
# Aus dem Service template von marcel übernommen und angepasst
class JsonWebTokenService
  RSA_PUBLIC_KEY = OpenSSL::PKey::RSA.new(Rails.application.config.jwt.rsa_public_key)

  def self.decode(token)
    decoded = JWT.decode(token.gsub('Bearer ', ''), RSA_PUBLIC_KEY, true, {algorithm: 'RS256'})[0]
    HashWithIndifferentAccess.new decoded
  end
end
