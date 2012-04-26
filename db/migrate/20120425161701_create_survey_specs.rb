class CreateSurveySpecs < ActiveRecord::Migration
  def change
    create_table :survey_specs do |t|
      t.string :name
      t.text :desc
      t.references :instrument
      t.timestamps
    end
  end
end
