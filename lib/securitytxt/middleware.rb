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
        headers = { 'Content-Type' => 'text/plain' }
        response_text = Generator.new(sections).generate

        return [200, headers, [response_text]]
      end

      @app.call(env)
    end
  end
end
