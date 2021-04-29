class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.bigint :mobile, null: false, default: ""
      t.integer :otp, null:false, default: ""

      t.timestamps
    end
  end
end