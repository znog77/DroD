class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.references :field
      t.references :survey_spec
      t.string :type
      t.string :value_str
      t.float  :value_flt
      t.timestamp :value_time
      t.timestamps
    end
  end
end
