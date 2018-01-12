module SecurityTxt
  # Rack Middleware that generates a respond.txt
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      req = Rack::Request.new(env)

      if req.path == '/.well-known/security.txt' && any_sections?
        sections = SECTIONS.inject({}) do |acc, v|
          acc[v] = SecurityTxt.send(v)
          acc
        end
        return Rack::Response.new(Generator.new(sections).generate, 200,
                                  'Content-Type' => 'text/plain')
      end
      @app.call(env)
    end

    def any_sections?
      SECTIONS.any? do |section|
        SecurityTxt.send(section).present?
      end
    end
  end
end
