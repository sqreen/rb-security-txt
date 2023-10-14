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
    class Railtie < ::Rails::Railtie
      config = proc do
        SecurityTxt::SECTIONS.inject({}) do |acc, v|
          vd = SecurityTxt.send(v)
          acc[v] = vd unless vd.blank?
          acc
        end
      end
      initializer "security-txt.middleware" do |app|
        app.middleware.use(SecurityTxt::Middleware, config)
      end
    end
  end
end
