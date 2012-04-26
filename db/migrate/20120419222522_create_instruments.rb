class CreateInstruments < ActiveRecord::Migration
  def change
    create_table :instruments do |t|
      t.string :name
      t.text :desc
      t.text :specs
      t.references :group
      t.references :location
      t.timestamps
    end
  end
end
