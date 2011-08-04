# -*- encoding : utf-8 -*-
require 'open-uri'
require 'net/http'
require 'uri'
require 'cgi'
require 'iconv'

module GooglePagerank
  class Client
    attr_accessor :http_client
    
    def initialize
      self.http_client = HttpUtilities::Http::Client.new
    end
    
    def pagerank(url, http_options = {}, fallback_to_proxies = true)
      url = "http://toolbarqueries.google.com/search?client=navclient-auto&ch=#{checksum(url)}&ie=UTF-8&oe=UTF-8&features=Rank&q=info:#{CGI::escape(url)}"
      response = (fallback_to_proxies) ? self.http_client.retrieve_raw_content_and_fallback_to_proxies(url, http_options) : self.http_client.retrieve_raw_content(url, http_options)
      return (response && response =~ /Rank_1:\d:(\d+)/) ? $1.to_i : nil 
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