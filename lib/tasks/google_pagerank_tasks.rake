namespace :google do
  namespace :pagerank do

    task :check, [:url] => :environment do |task, args|
      url       =   args.url.to_s
      
      client    =   Google::Pagerank::Client.new
      pagerank  =   client.pagerank(url)

      puts "Pagerank for url '#{url}' is: #{pagerank}"
    end
    
  end
end