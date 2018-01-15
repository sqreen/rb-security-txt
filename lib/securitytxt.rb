require 'securitytxt/generator'
require 'securitytxt/middleware'

# Rails SecurityTXT generator
module SecurityTxt
  SECTIONS = %i[acknowledgment contact encryption signature policy].freeze
  SECTIONS.each do |section|
    if defined?(Rails)
      mattr_accessor section
    else
      attr_accessor section
    end
  end

  if defined?(Rails)
    # Rails engine that plugs middleware in application
    class Application < Rails::Application
      config = proc do
        SecurityTxt::SECTIONS.inject({}) do |acc, v|
          acc[v] = SecurityTxt.send(v)
          acc
        end
      end
      Rails.application.config.middleware.use SecurityTxt::Middleware, config
    end
  end
end
