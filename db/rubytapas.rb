require "sequel"

DB = Sequel.sqlite

DB.create_table :people do
  primary_key :id
  String :name
end

DB.create_table :items do
  foreign_key :person_id, :people
  String :name
  Integer :quantity, default: 1
  unique [:person_id, :name]
end

DB.create_table :states do
  Integer :ansi_id;
  String :state_abbrev;
  String :state_name;
end

stacey_id= DB[:people].insert(name: "Stacey")
avdi_id =  DB[:people].insert(name: "Avdi")

DB[:people].count           # => 2
DB[:people].all
# => [{:id=>1, :name="Stacey"}, {:id=>2, :name=>"Avdi"}]

DB[:items].insert(avdi_id, "Pie", 2)
DB[:items].insert(person_id: avdi_id, name: "Granola")

DB[:items].all

DB[:items].insert(avdi_id, "Mineral Water", 1)
DB[:items].insert(stacey_id, "Heads of Kale", 3)
DB[:items].insert(stacey_id, "Mineral Water", 2)

DB[:items].first

DB[:items].sum(:quantity)

DB[:items].where{quantity > 1}.all
