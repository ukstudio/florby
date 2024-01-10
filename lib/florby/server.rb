require 'webrick'

module Florby
  class Server
    def self.run
      new.run
    end

    def run
      server = WEBrick::HTTPServer.new(
        DocumentRoot: File.join(Dir.pwd, '_build'),
        Port: 8081,
      )

      trap(:INT) do
        server.shutdown
      end

      server.start
    end
  end
end
