require 'socket'
 load './redis.rb'

class Server
  def initialize()
    server = TCPServer.new('localhost', 3000)
  end

  def initialize( host, port)
    server = TCPServer.new(host , port)
  end

  def getClientMessage(message)

  end

  def resiveMessage

  end
end



loop do
  Thread.start(server.accept) do |client|
    client.printf "Hello\n"
    
    session = Session.new('127.0.0.1', 6379)
    message = client.gets.chomp.split(';')
  
    command = message[0]
    arg = message[1]

    case command
      when "GET"
        begin
          client.printf session.getSession(arg) + "\n"
          client.printf "GET ОК\t" + arg + "\n"
        end
    
      when "SET" 
        begin
          session.setSession(arg, 'f');
          client.printf "SET ОК\t" + arg + "\n"
        end

      when "QUIT"
        begin
          client.printf "QUIT ОК\n"
          client.close
        end
      end
  end
end

server.close

