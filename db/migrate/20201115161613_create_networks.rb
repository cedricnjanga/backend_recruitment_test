class CreateNetworks < ActiveRecord::Migration[5.2]
  def change
    create_table :networks do |t|
      t.string :name

      t.timestamps
    end

    %i[users rides].each do |table_name|
      add_reference table_name, :network, foreign_key: true
    end
  end
end
