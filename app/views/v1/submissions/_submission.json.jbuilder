json.extract! submission, :name, :email, :mobile_phone, :resume
json.set! :job do
  json.partial! "v1/recruiters/jobs/job", job: submission.job
end
