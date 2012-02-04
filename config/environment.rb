# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
UcoachManager::Application.initialize!

Time::DATE_FORMATS[:day] = "%d/%m/%Y - %H:%M"
