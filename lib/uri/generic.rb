require 'uri'

module URI
  class Generic
    def to_s
      str = ''.dup
      if @scheme
        str << @scheme
        str << ':'
      end

      if @opaque
        str << @opaque
      else
        if @host || %w[file postgres unix].include?(@scheme)
          str << '//'
        end
        if self.userinfo
          str << self.userinfo
          str << '@'
        end
        if @host
          str << @host
        end
        if @port && @port != self.default_port
          str << ':'
          str << @port.to_s
        end
        str << @path
        if @query
          str << '?'
          str << @query
        end
      end
      if @fragment
        str << '#'
        str << @fragment
      end
      str
    end
  end
end
