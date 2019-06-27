require 'excon'
require 'json'

Service = Struct.new(:id, :name, :created_at, :will_be_delete)

class ServiceCleaner
  def initialize(logger: nil, **params)
    @logger = logger
    @params = params
  end

  def connection
    @connection ||= begin
      if 'unix' == @params[:host].scheme
        Excon.new('unix:///', :socket => @params[:host].path)
      else
        Excon.new(@params[:host].to_s)
      end
    end
  end

  def get_services
    response = connection.get(path: '/services')
    unless 200 == response.status
      puts "#{response.status} #{response.body}"
      exit
    end
    response_body = JSON.parse(response.body)
    response_body.map do |hash|
      Service.new(
        hash['ID'],
        hash['Spec']['Name'],
        Time.parse(hash['CreatedAt']),
        false
      )
    end
  end

  def delete_service(service)
    if @params[:destructive]
      response = connection.delete(path: "/services/#{service.id}")
      unless 200 == response.status
        puts "#{service.inspect} -> #{response.status} #{response.body}"
        exit
      end
    end
  end

  def delete_services(services)
    max_name_length = services.map(&:name).map(&:size).max
    services.
      sort { |s1, s2| s1.name <=> s2.name }.
      map { |s| Service.new(s.id, s.name, s.created_at, @params[:threshold] > s.created_at) }.
      map { |s| Service.new(s.id, s.name, s.created_at, @params[:'exclude-names'].include?(s.name) ? false : s.will_be_delete) }.
      map { |s| puts "#{s.id}  #{s.name.ljust(max_name_length, ' ')}  #{s.created_at}  #{s.will_be_delete ? 'delete' : 'keep'}"; s }.
      select(&:will_be_delete).
      each(&method(:delete_service))
  end
end
