require 'socket'
require 'redis'


server = TCPServer.new('localhost', 3000)
redis = Redis.new(:host => "127.0.0.1", :port => '6379') 

loop do
  Thread.start(server.accept) do |client|
    client.printf "Hello\n"
    message = client.gets.chomp.split(';')
  
    command = message[0]
    arg = message[1]

    case command
      when "GET"
        begin
          client.printf #{redis.get(arg)}
          client.printf "GET ОК\n"
        end
    
      when "SET" 
        begin
          redis.set(arg, rand(6));
        end

      when "QUIT"
        begin
          client.close
        end
      end
  end
end

server.close

