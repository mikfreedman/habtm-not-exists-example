class AddModels < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.timestamps
    end

    create_table :users do |t|
      t.timestamps
    end

    create_table :leads_users do |t|
      t.integer :user_id
      t.integer :lead_id
      t.timestamps
    end
  end
end
