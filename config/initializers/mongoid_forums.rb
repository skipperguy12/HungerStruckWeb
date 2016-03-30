require 'sanitize'

# This is exists so formatters can access it if it so pleases them.
module MongoidForums
  module Formatters
    class Sanitizer
      def format(text)
          Sanitize.clean(text, Sanitize::Config::RELAXED).html_safe
      end
      def sanitize(text)
        format(text).html_safe
      end
    end
  end
end


MongoidForums.user_class = "User"
MongoidForums.email_from_address = "please-change-me@example.com"
# If you do not want to use gravatar for avatars then specify the method to use here:
# MongoidForums.avatar_user_method = :custom_avatar_url
MongoidForums.per_page = 20
MongoidForums.formatter = MongoidForums::Formatters::Sanitizer.new
