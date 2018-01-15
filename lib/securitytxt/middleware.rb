module SecurityTxt
  # Rack Middleware that generates a respond.txt
  class Middleware
    def initialize(app, sections = {})
      @app = app
      @sections = sections
    end

    def call(env)
      req = Rack::Request.new(env)

      sections = @sections
      sections = @sections.call if @sections.respond_to?(:call)
      if req.path == '/.well-known/security.txt' && !sections.empty?
        return Rack::Response.new(Generator.new(sections).generate, 200,
                                  'Content-Type' => 'text/plain')
      end
      @app.call(env)
    end
  end
end
