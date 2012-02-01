# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
UcoachManager::Application.initialize!

config.gem "mongo_mapper"
