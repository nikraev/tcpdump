require 'redis'

class Session
  
  def initialize
    @host = '127.0.0.1'
    @port = 6379
  end

  def initialize(server, port)
    @host = server
    @port = port
  end

  def getSession(key)
    self.connectRedis
    a = @redis.get(key)
    

  end
  
  def setSession(key, value)
      self.connectRedis
      @redis.set(key, value)
  end

  def close

  end

protected
  def connectRedis
    @redis = Redis.new(:host => @host, :port => @port)
  end

  def closeRedis

  end

end

