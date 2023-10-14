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
        key = name.to_s.split("_").map { |k| capitalize(k) }.join('-')
        next if value.nil? || value.empty?
        if value.is_a?(Array)
          value.each { |subvalue| ret << "#{key}: #{subvalue}\n" }
        else
          ret << "#{key}: #{value}\n"
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
