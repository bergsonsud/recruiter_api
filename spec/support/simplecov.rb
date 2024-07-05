require 'simplecov'

SimpleCov.start 'rails' do
  minimum_coverage 80
  maximum_coverage_drop 5

  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'

  # Ignore folders
  add_filter 'app/channels'
  add_filter 'app/mailers'
  add_filter 'app/jobs'
  add_filter 'app/models/application_record.rb'
  # SimpleCov does not recognize model, change to Coverband after
  add_filter 'app/models/recruiter.rb'
end
