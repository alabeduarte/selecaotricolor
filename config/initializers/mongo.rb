# MongoMapper.database = "app-#{Rails.env}"
if ENV['MONGOLAB_URI'] =~ /\/([^\/]+)$/
  MongoMapper.database = $1
else
  MongoMapper.database = "app-#{Rails.env}"
end

MongoMapper.connect(Rails.env)

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect_to_master if forked
   end
end