require 'faraday'

module Google
  module Pagerank
    class Client
      attr_accessor :endpoint
      
      include Google::Pagerank::Constants
      
      def initialize
        self.endpoint       =   "http://toolbarqueries.google.com/tbr"
      end
      
      def pagerank(url, options: {timeout: 15, open_timeout: 15}, retries: 3)
        result              =   nil
        
        begin
          arguments         =   {
            client:     "navclient-auto",
            ch:         checksum(url),
            ie:         "UTF-8",
            oe:         "UTF-8",
            features:   "Rank",
            q:          "info:#{CGI::escape(url)}"
          }
        
          response          =   get_response(self.endpoint, arguments, options)
          result            =   (response && !response.empty? && response =~ /Rank_1:\d:(\d+)/) ? $1.to_i : nil
          
        rescue Faraday::TimeoutError, Net::ReadTimeout, Timeout::Error, StandardError => e
          puts "[Google::Pagerank::Client] - #{Time.now.to_s(:db)}: An error occurred while trying to fetch PageRank. Error Class: #{e.class.name}. Error Message: #{e.message}."
          retries          -=   1
          retry if retries > 0
        end

        return result
      end
      
      def get_response(url, arguments = {}, options = {})
        connection        =   build_connection(options)
        response          =   connection.get(url, arguments)
        response          =   (response && response.body) ? response.body : nil

        return response
      end
  
      def build_connection(options = {})
        options.merge!(ssl: {:verify => false})
    
        timeout         =   options.delete(:timeout)            { |opt| 60 }
        open_timeout    =   options.delete(:open_timeout)       { |opt| 60 }

        proxy_options   =   generate_proxy_options
        user_agent      =   USER_AGENTS.sample
    
        connection      =   Faraday.new(options) do |builder|
          builder.headers[:user_agent]      =   user_agent
          builder.options[:timeout]         =   timeout
          builder.options[:open_timeout]    =   open_timeout        
          builder.proxy     proxy_options unless proxy_options.empty?
          builder.adapter   Faraday.default_adapter
        end
    
        return connection
      end
  
      def generate_proxy_options
        proxy_options   =   {}
        class_exists    =   Module.const_get('Proxy').is_a?(Class) rescue false
        
        if class_exists
          proxy         =   ::Proxy.get_random_proxy(protocol: :http, proxy_type: :private, maximum_failed_attempts: 10)
    
          if (proxy)
            proxy_options[:uri]       =   "http://#{proxy.host}:#{proxy.port}"
            proxy_options[:user]      =   proxy.username if proxy.username && proxy.username.present?
            proxy_options[:password]  =   proxy.password if proxy.password && proxy.password.present?
          end
        end
    
        return proxy_options
      end

      def checksum(str)
        check1 = str_to_num(str, 0x1505, 0x21)
        check2 = str_to_num(str, 0, 0x1003F)
        check1 >>= 2
        check1 = ((check1 >> 4) & 0x3FFFFC0) | (check1 & 0x3F)
        check1 = ((check1 >> 4) & 0x3FFC00) | (check1 & 0x3FF)
        check1 = ((check1 >> 4) & 0x3C000) | (check1 & 0x3FFF)
        t1 = ((((check1 & 0x3C0) << 4) | (check1 & 0x3C)) << 2) | (check2 & 0xF0F)
        t2 = ((((check1 & 0xFFFFC000) << 4) | (check1 & 0x3C00)) << 0xA) | (check2 & 0xF0F0000)
        hash = (t1 | t2)
        check_byte = 0
        flag = 0
        hash_str = sprintf('%u', hash)
        (hash_str.size - 1).downto(0) do |i|
          re = hash_str[i..i].to_i
          if (1 == (flag % 2))
            re += re
            re = (re / 10).to_i + (re % 10)
          end
          check_byte += re
          flag += 1
        end
        check_byte %= 10
        if (0 != check_byte)
          check_byte = 10 - check_byte
          if (1 == (flag % 2))
            check_byte += 9 if (1 == (check_byte % 2))
            check_byte >>= 1
          end
        end
        return '7' + check_byte.to_s + hash_str;
      end

      private
      def str_to_num(str, check, magic)
        int32 = 4294967296 # 2^32
        str.each_byte do |char|
          check *= magic
          if check >= int32
            check = (check - int32 * (check / int32).to_i)
            check = (check < -2147483648) ? check + int32 : check
          end
          check += char
        end
        return check
      end

    end
  end
end