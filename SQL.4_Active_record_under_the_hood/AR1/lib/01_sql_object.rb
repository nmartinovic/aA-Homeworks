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
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
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
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
