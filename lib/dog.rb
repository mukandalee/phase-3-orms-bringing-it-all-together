class Dog
  attr_accessor :name, :breed, :id

  def initialize(name:,breed:, id:nil)
      @id = id
      @name= name
      @breed= breed
end

#create table

  def self.create_table 
      sql= <<-SQL
      CREATE TABLE IF NOT EXISTS dogs (
          id INTEGER PRIMARY KEY,
          name TEXT,
          breed TEXT
      )
      SQL
      DB[:conn].execute(sql)
  end

# drop table
  def self.drop_table 
      sql= <<-SQL
      DROP TABLE IF EXISTS dogs
      SQL

  DB[:conn].execute(sql)
  end

#.save do

  def save 
      if self.id
          self.update
      sql =<<-SQL
      INSERT INTO dogs (name, breed)
      VALUES(?, ?)
      SQL

      DB[:conn].execute(sql, self.name, self.breed)

     self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
      
      #return a new instance
  self
end

#.create do
 def self.create(name:, breed:)
  dog = dog.new(name: name, breed: breed)
  dog.save
end

#.new_from_db

def self.new_from_db(row)
  self.new(id:row [0], name:row[1], breed:row[2])
end

#.all do
  def self.all
      sql = <<-SQL
      SELECT *
      FROM dogs
      SQL
  DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
  end

#.find_by_name
   def self.find_by_name(name)
      sql = <<-SQL
      SELECT *
      FROM dogs
      WHERE dog.name = ?
      LIMIT 1
      SQL
  DB[:conn].execute(sql).map do |row|
  
      self.new_from_db(row)
  end

#.find do
  def self.find(id)
      sql = <<-SQL
      SELECT *
      FROM dogs
      WHERE dog.id = 2
      LIMIT 1
      SQL
  DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
  end
end
  

