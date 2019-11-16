
class Dog

  attr_accessor :name, :breed, :id

  @@all = []

  def initialize(name:, breed:, id:nil)
    @name = name
    @breed = breed
    @@all << self
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE dogs(
      id INTEGER PRIMARY KEY,
      name TEXT,
      breed TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
    DROP TABLE dogs
    SQL

    DB[:conn].execute(sql)
  end

  def save

  end

  def update

  end

end
