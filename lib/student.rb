class Student
  attr_accessor :name, :grade
  attr_reader :id
  #this is an attr_reader because you are not setting it- the database is. 
  
  def initialize (name, grade, id = nil)
    @name = name
    @grade = grade 
    @id = id 
  end 
  
  def self.create_table
    sql =  <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grade INTEGER
        )
    SQL
    DB[:conn].execute(sql) 
  end 
  
  def self.drop_table 
    sql =  <<-SQL 
      DROP TABLE students
    SQL
    DB[:conn].execute(sql) 
  end 
  
  
  def self.save 
    sql = <<-SQL 
      INSERT INTO students(name, grade) VALUES (?, ?)
    SQL
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
    #above saves to the database... INCLUDING the id 
    DB[:conn].execute(sql, student.name, student.grade)
  end 
  
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
end
