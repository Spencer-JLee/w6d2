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
    @columns.each do |column|
      getter = column.to_s
      setter = column.to_s + "="

      define_method(getter){
        @attributes[column]
      }
      
      define_method(setter){ |arg|
        @attributes[column] = arg
      }
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
    # ...
  end

  def self.table_name
    if @table_name.nil?
      self.to_s.downcase.pluralize
    else 
      @table_name
    end
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
