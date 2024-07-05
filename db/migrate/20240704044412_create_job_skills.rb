# frozen_string_literal: true

class CreateJobSkills < ActiveRecord::Migration[6.0]
  def change
    create_table(:job_skills) do |t|
      t.string(:skill)
      t.references(:job, null: false, foreign_key: true)

      t.timestamps
    end
  end
end
