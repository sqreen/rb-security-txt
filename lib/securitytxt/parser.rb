module SecurityTxt
  # Parser of Security.txt
  class Parser
    def parse(str)
      sections = {}
      str.each_line do |line|
        line.chomp!
        l = line.to_s.gsub(/#.*$/, '')
        next if l.index(': ').nil?
        section, value = l.split(': ', 2)
        key = section.to_s.downcase
        current = sections[key]
        case current
        when NilClass
          sections[key] = value
        when Array
          sections[key] << value.strip
        else
          sections[key] = [current, value]
        end
      end
      sections
    end
  end
end
