module Florby
  require 'florby/builder'
  require 'florby/server'

  class CLI
    def self.run(args)
      subcommand = args.shift

      case subcommand
      when "build"
        Florby::Builder.run
      when "server"
        Florby::Server.run
      else
        puts "unknown command"
      end
    end
  end
end
