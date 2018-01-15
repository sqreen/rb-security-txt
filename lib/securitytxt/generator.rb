module SecurityTxt
  # Generator of Security.txt
  class Generator
    attr_accessor :sections
    def initialize(data = {})
      @sections = data
    end

    def generate
      ret = StringIO.new
      sections.each do |name, value|
        next if value.nil? || value.empty?
        if value.is_a?(Array)
          value.each { |subvalue| ret << "#{capitalize(name)}: #{subvalue}\n" }
        else
          ret << "#{capitalize(name)}: #{value}\n"
        end
      end
      ret.string
    end

    protected

    if ''.respond_to?(:capitalize)
      def capitalize(w)
        w.capitalize
      end
    else
      # Stolen from rails
      def capitalize(w)
        (w.slice(0) || w.chars('')).upcase +
          (w.slice(1..-1) || w.chars('')).downcase
      end
    end
  end
end
