class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.string :name
      t.string :course
      t.string :phone
      t.string :matricula, unique: true
      t.timestamps null: false
    end
  end
end
