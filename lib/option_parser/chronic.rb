require 'chronic'

OptionParser.accept(Chronic) do |s,|
  begin
    Chronic.parse(s) if s
  rescue ArgumentError
    raise OptionParser::InvalidArgument, s
  end
end
