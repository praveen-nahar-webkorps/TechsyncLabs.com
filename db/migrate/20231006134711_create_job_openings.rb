class CreateJobOpenings < ActiveRecord::Migration[7.0]
  def change
    create_table :job_openings do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :phone
      t.string :address
      t.integer :job_no
      t.text :add_info
      t.string :education
      t.string :skills
      t.string :total_exp
      t.string :personal_quality
      t.string :file
      t.string :desired_work

      t.timestamps
    end
  end
end
