class CreateApplyjobs < ActiveRecord::Migration[6.1]
  def change
    create_table :applyjobs do |t|
      t.string :name
      t.references :user, foreign_key:true
      t.boolean :status

      t.timestamps
    end
  end
end
