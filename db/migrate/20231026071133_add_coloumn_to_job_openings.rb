class AddColoumnToJobOpenings < ActiveRecord::Migration[7.0]
  def change
    add_column :job_openings, :text_info, :string
  end
end
