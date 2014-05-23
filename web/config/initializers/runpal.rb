require '../lib/app_helper.rb'
RunPal.db_class = RunPal::Database::PostgresDB
RunPal.env = ENV['RAILS_ENV']
RunPal.db_seed
