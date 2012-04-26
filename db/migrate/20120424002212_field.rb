class Field < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.references :instrument
    end
  end
end
