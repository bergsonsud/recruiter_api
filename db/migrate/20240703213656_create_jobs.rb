# frozen_string_literal: true

class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table(:jobs) do |t|
      t.string(:title)
      t.string(:description)
      t.date(:start_date)
      t.date(:end_date)
      t.integer(:status, default: 0)
      t.references(:recruiter, null: false, foreign_key: true)

      t.timestamps
    end

    add_index(:jobs, :start_date)
    add_index(:jobs, :end_date)
    add_index(:jobs, :status)
    add_index(:jobs, :title)
    add_index(:jobs, :description)
  end
end
