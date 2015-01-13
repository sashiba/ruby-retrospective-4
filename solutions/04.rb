module UI
  class Horizontal
    @arr_items
    @border
    @style
    def initialize(hash, &block)
            @border = hash[:border]
            @style = hash[:style]
            instance_eval &block
    end
    def horizontal(hash, &block)
      horizon = Horizontal.new hash(&block)
      @arr_items << horizon
    end
    def vertical(hash, &block)
      vertical = Vertical.new hash(&block)
      @arr_items << vertical
    end
    def label(parameters)
            parameters[:border] = "" unless parameters.has_key?(:border)
            style = TextScreen::style(parameters[:style], parameters[:text])
            @str << parameters[:border] << style << parameters[:border]
            @arr_items << @str
          end
          def top
          end
    def get_top
     @border << @border unless border.nil?
    end
  end
  class Vertical
    @arr_items
    @border
    @style
    def initialize(hash, &block)
            @border = hash[:border]
            @style = hash[:style]
            instance_eval &block
    end
    def horizontal(hash, &block)
      horizon = Horizontal.new hash(&block)
      @arr_items << horizon
    end
    def vertical(hash, &block)
      vertical = Vertical.new(hash, &block)
      @arr_items << vertical
    end
    def label(parameters)
            parameters[:border] = "" unless parameters.has_key?(:border)
            style = TextScreen::style(parameters[:style], parameters[:text])
            @str << parameters[:border] << style << parameters[:border]
            @arr_items << @str
          end
           def top
          end
    def get_top
     @border << @border unless border.nil?
    end
  end
  class TextScreen
          @screen_string = ""
          def self.style (style, text)
      case style
        when :uppercase then text.upcase
        when :downcase  then text.downcase
        else                 text
      end
          end
          def print(group)
            group.each do |elem|
                    @screen_string << elem.get_top
            end
          end
    def self.draw(&block)
      group = Hroizontal.new &block
      print group
      @screen_string
    end
  end
end