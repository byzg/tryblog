class AddSubjectToPost < ActiveRecord::Migration
  def change
    add_column :posts, :subject, :string
  end
end
