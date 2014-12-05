require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = "cassettes"
  c.hook_into :webmock
  c.configure_rspec_metadata!
end
