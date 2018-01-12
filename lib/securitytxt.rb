require 'securitytxt/generator'
require 'securitytxt/middleware'

# Rails SecurityTXT generator
module SecurityTxt
  SECTIONS = %i[acknowledgment contact encryption signature policy].freeze
  SECTIONS.each do |section|
    mattr_accessor section
  end

  if defined?(Rails)
    # Rails engine that plugs middleware in application
    class Application < Rails::Application
      Rails.application.config.middleware.use SecurityTxt::Middleware
    end
  end
end
