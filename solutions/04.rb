module UI
    class TextScreen
        attr_accessor :temp
        def self.draw (&block)
            @temp = []
            self.instance_eval(&block)
            @temp.join('') if @temp.class != String
        end

        def self.label(text:, style: nil, border: nil)
            case style
            when :upcase   then text = text.upcase
            when :downcase then text = text.downcase
            end
            text = "#{border}#{text}#{border}" if border != nil
            @temp << text
        end

        def self.horizontal(border: nil, style: nil, &block)
            self.instance_eval(&block)
            horizontal_text = ""
            @temp.each do |text|
                horizontal_text << text
            end
            horizontal_text = "#{border}#{horizontaltext}#{border}" if border != nil
            @temp = horizontal_text
            end
    end
end