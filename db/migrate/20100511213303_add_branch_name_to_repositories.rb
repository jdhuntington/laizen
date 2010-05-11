class AddBranchNameToRepositories < ActiveRecord::Migration
  def self.up
    add_column :repositories, :branch, :string
  end

  def self.down
    remove_column :repositories, :branch
  end
end
