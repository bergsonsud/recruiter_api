json.extract! job, :id, :title, :description, :start_date, :end_date, :status
json.skills job.skills, :skill
json.recruiter job.recruiter, :name, :email
