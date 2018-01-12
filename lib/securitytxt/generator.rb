module SecurityTxt
  # Generator of Security.txt
  class Generator
    attr_accessor :sections
    def initialize(data)
      @sections = data
    end

    def generate
      ret = StringIO.new
      sections.each do |name, value|
        next if value.blank?
        if value.is_a?(Array)
          value.each { |subvalue| ret << "#{name.capitalize}: #{subvalue}\n" }
        else
          ret << "#{name.capitalize}: #{value}\n"
        end
      end
      ret.string
    end
  end
end
