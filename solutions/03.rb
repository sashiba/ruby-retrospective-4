module RBFS
        class File
                attr_accessor :data

                def initialize(*args)
                        raise ArgumentError if args.size > 1
                        @data = case args[0]
                        when String, FalseClass, TrueClass, Symbol, Fixnum, Integer, Float then args[0]
                        end
                end

                def data_type
                         case
                   when @data.kind_of?(Numeric)           then :number
                       when (@data == true or @data == false) then :boolean
                       when  @data == nil                     then :nil
                       else @data.class.name.downcase.to_sym
                       end
                end

                def serialize
                        "#{data_type.to_s}:#{@data.to_s}"
                end

                def to_n(temp)
                  if temp[1].include? "." then
                          newFile = RBFS::File.new(temp[1].to_f)
              else
                          newFile = RBFS::File.new(temp[1].to_i)
                  end
                end

                def parse(string_data)
                        temp = string_data.split(/: */)
                        case temp[0]
                        when "nil"     then newFile = RBFS::File.new
                        when "string"  then newFile = RBFS::File.new(temp[1])
                        when "boolean" then newFile = RBFS::File.new(temp[1].to_bool)
                        when "symbol"  then newFile = RBFS::File.new(temp[1].to_sym)
                        when "number"  then to_n(temp)
                        end
                end

                def ser_len
        serialize.length
        end
        end

        class Directory
                attr_reader :files, :directories

                def initialize
                    @files = {}
                     @directories = {}
                end

                def add_file(name, file)
                        @files[name] = file
                end

                def add_directory(name, *directory)
                        @directories[name] = {} if directory == nil
            @directories[name] = directory[0]
                end

                def [](*name)
                        if @directories.has_key?(name[0])
                         @directories[name[0]]
                     elsif @files.has_key?(name[0])
                         @files[name[0]]
                     else
                        nil
                    end
                end

                def len
                     result = @files.size.to_s.length + 1 + @directories.size.to_s.length + 1
          @files.each do |name, file|
                  result += name.size + file.ser_len.to_s.size + file.ser_len + 3
          end
          @directories.each { |name, dir| result += name.size + 2 + dir.len }
          result
          result if @directories.size == 0 or @directories.has_value? nil
                end

                def serialize
                        serial_str = ""
                        serial_str << @files.size.to_s + ":"
                        @files.each { |name, file| serial_str << "#{name}:#{file.ser_len}:#{file.serialize}"}
                        serial_str << @directories.size.to_s + ":"
                        @directories.each { |name, dir| serial_str << "#{name}:#{len}" + dir.serialize }
                        serial_str << "#{name}:4:0:0:" if @directories.has_value? nil
                        serial_str
                end

                def parse(string_data)
                end
        end
end
class String
                def to_bool
                        return true  if self == "true"
                        return false if self == "false"
                end
end