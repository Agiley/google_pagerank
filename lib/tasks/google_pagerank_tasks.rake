namespace :google_pagerank do
  desc "Google PageRank tasks"

  task :check_pagerank, [:url] => :environment do |task, args|
    url = args.url.to_s
    
    google_pagerank = Google::Pagerank::Client.new
    pagerank = google_pagerank.pagerank(url)
    
    puts "Pagerank for url '#{url}' is: #{pagerank}"
  end
end