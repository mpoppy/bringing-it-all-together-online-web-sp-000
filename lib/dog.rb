
class Dog

  attr_accessor :name, :breed, :id

  def initialize(name:, breed:, id:nil)
    @name = name
    @breed = breed
    @id = id
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
    if self.id
      self.update
    else
      sql = <<-SQL
      INSERT INTO dogs (name, breed) values (?, ?)
      SQL

      DB[:conn].execute(sql, self.name, self.breed)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
      self
    end
  end

  def self.create(name:, breed:)
    dog = Dog.new(name:name, breed:breed)
    dog.save
  end

  def update
    sql = "UPDATE dogs SET name = ?, breed = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.breed, self.id)
  end

  def self.new_from_db(row)
    new_dog = Dog.new(id:row[0], name:row[1], breed:row[2])
    new_dog
  end

  def self.find_by_id(id)
    #define a query, then run the query against the db
    sql = "SELECT * FROM dogs WHERE id = ?"
  end

end
