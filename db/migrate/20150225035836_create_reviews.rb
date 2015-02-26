class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :merge_request, index: true
      t.string :ref

      t.timestamps
    end
  end
end
