# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Droidlandia::Application.initialize!

# Disable paperclip logging
Paperclip.options[:log] = false
