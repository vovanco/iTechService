class SupplyCategory < ActiveRecord::Base

  attr_accessible :name, :ancestry, :parent_id
  validates_presence_of :name
  #validates_uniqueness_of :name, scope: :ancestry

  has_ancestry

end
