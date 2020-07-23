class Pokemon
  attr_reader :id, :name, :type, :db

  def initialize(params = {})
    @id, @name, @type, @db = params[:id], params[:name], params[:type], params[:db]
  end

  #Class methods
  def self.new_from_db(row)
    Pokemon.new(id: row[0], name: row[1], type: row[2])
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon
        (name, type)
      VALUES
        (?, ?);
    SQL

    db.execute(sql, name, type)
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT * FROM pokemon WHERE id = ?;
    SQL

    new_from_db(db.execute(sql, id)[0])
  end
end
