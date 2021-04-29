class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.string :category
      t.integer :exp
      t.boolean :status
      t.timestamps
    end
  end
end