# -*- encoding : utf-8 -*-
module GooglePagerank
  require File.join(File.dirname(__FILE__), 'google/railtie') if defined?(Rails)
  require File.join(File.dirname(__FILE__), 'google/pagerank/client')
end
