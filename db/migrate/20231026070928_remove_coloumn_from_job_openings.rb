class RemoveColoumnFromJobOpenings < ActiveRecord::Migration[7.0]
  def change
    remove_column :job_openings, :job_no, :integer
    remove_column :job_openings, :add_info, :text
    remove_column :job_openings, :file, :string
    remove_column :job_openings, :desired_work, :string
  end
end
