class Pokemon
    attr_accessor :name, :id, :type, :db

    def initialize(name: name, id: id=nil, type: type, db: db)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
    end

    def self.new_from_db(row)
        x = self.new
        x.id = row[0]
        x.name = row[1]
        x.type = row[2]
        x
    end
    

    def self.find(id, db)
        sql = <<-SQL
        SELECT * FROM pokemon
        WHERE id = ?
        SQL

        db.execute(sql, id).map do |row|
            self.new_from_db(row)
        end.first
    end
end
