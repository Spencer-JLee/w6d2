require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    @columns ||= DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL


    @columns.first.map! {|ele| ele.to_sym}

    @columns.first
  end

  def self.finalize!
    columns = self.columns
    columns.each do |column|
      getter = column.to_sym
      setter = ("#{column}=").to_sym

      define_method(getter){
        self.attributes[column]
      }
      
      define_method(setter){ |arg|
        self.attributes[column] = arg
      }
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
    # ...
  end

  def self.table_name
    @table_name ||= self.to_s.downcase.pluralize
    # ...
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
    # ...
    params.each do |key, value|
      columns = self.columns
      raise "unknown attribute '#{key}'" if !columns.include?(key.to_sym)
      self.send(:setter, key, value)
    end
  end

  def attributes
    # ...
    @attributes ||= Hash.new(0)
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
