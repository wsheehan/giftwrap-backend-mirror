CarrierWave.configure do |config|
  config.fog_provider = 'fog/google'
  config.fog_credentials = {
    provider:                         'Google',
    google_storage_access_key_id:     'GOOGBCC3G6HZNCTC6VEZ',
    google_storage_secret_access_key: 'gp2x0VG5GjIyZhKZti0vYmzjn/Q9XWTVG/dtpdjH'
  }
  config.fog_directory = 'giftwrap-test-uploads'
end
