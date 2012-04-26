class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.text :desc
      t.string :contact
      t.timestamps
    end
  end
end
