require '../lib/app_helper.rb'
RunPal.db_class = RunPal::Database::PostgresDB
RunPal.env = 'development'
RunPal.db_seed
