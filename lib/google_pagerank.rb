module Google
  module Pagerank
    require File.join(File.dirname(__FILE__), 'google/railtie') if defined?(Rails)
    require File.join(File.dirname(__FILE__), 'google/pagerank/constants')
    require File.join(File.dirname(__FILE__), 'google/pagerank/client')
  end
end