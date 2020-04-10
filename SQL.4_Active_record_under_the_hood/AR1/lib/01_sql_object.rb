require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    if @columns == nil
      @columns = DBConnection.execute2(<<-SQL)
        SELECT
          *
        FROM
          #{self.table_name}
      SQL
      @columns = @columns[0].map { |ele| ele.to_sym}
    end
    @columns
  end

  def self.finalize!
    self.columns.each do |column|
      define_method(column) {attributes[column]}
      define_method("#{column}=") { |val| attributes[column]=val}
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.name.tableize
  end

  def self.all
    all = DBConnection.execute(<<-SQL)
    SELECT
      *
    FROM
      "#{@table_name}"
    SQL
    self.parse_all(all)
  end

  def self.parse_all(results)
    blank = []
    results.each do |result|
      blank << self.new(result)
    end
    blank
  end

  def self.find(id)
    #self.all.find { |obj| obj.id == id } 
    results = DBConnection.execute(<<-SQL,id)
      SELECT
        *
      FROM
        "#{@table_name}"
      WHERE
        id = ?
    SQL
    return nil if results == []
    self.new(results.first)
  end

  def initialize(params = {})
    params.each do |key,value|
      key = key.to_sym
      if !self.class.columns.include?(key)
        raise "unknown attribute '#{key}'"
      end
      self.send "#{key}=", value
    end

  end

  def attributes
    @attributes ||= @attributes = Hash.new
  end

  def attribute_values
    @attributes.values
  end

  def insert
    col_length = self.class.columns.length
    col_names = "(" + attributes.keys.map(&:to_s).join(", ") + ")"
    question_marks = "(" + (['?'] * attribute_values.size).join(', ') + ")"
    insert = DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} #{col_names}
      VALUES
        #{question_marks}
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    updates = self.columns.map 

    update = DBConnection.execute(<<-SQL)
      UPDATE
        #{self.class.table_name}
      SET


    SQL
  end

  def save
    # ...
  end
end
