# -*- encoding : utf-8 -*-
module GooglePagerank
  require File.join(File.dirname(__FILE__), 'google_pagerank/railtie') if defined?(Rails)
  require File.join(File.dirname(__FILE__), 'google_pagerank/client')
end
