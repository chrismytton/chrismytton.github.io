require 'digest/md5'

module Jekyll
  # Turn an email address into a gravatar url
  module GravatarFilter
    def to_gravatar(input, size = 400)
      "https://secure.gravatar.com/avatar/#{md5(input)}?s=#{size}"
    end

    private
    def md5(email)
      email_address = email ? email.downcase.strip : ''
      Digest::MD5.hexdigest(email_address)
    end
  end
end

Liquid::Template.register_filter(Jekyll::GravatarFilter)
