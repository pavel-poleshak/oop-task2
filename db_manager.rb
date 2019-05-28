require 'rubygems'
require 'active_record'
require 'table_print'

class DbManager
  attr_accessor :db_name

  def initialize(db_name)
    connect(db_name)
    set_up_db unless schema_exists?
  end

  def find_company(id)
    Company.find(id)
    rescue ActiveRecord::RecordNotFound
      puts "Entry does not exist"
  end

  def find_employee(id)
    Employee.find(id)
    rescue ActiveRecord::RecordNotFound
      puts "Entry does not exist"
  end

  def get_all_companies
    Company.all
  end

  def get_all_employees
    Employee.all
  end

  def delete_employee_by_id(id)
    Employee.destroy(id) if Employee.find(id)
  end

  def delete_company_by_id(id)
    Company.destroy(id) if Company.find(id)
  end

  def create_company(name)
    Company.create(name: name)
  end

  def create_employee(first_name, last_name, company = nil)
    Employee.create(first_name: first_name, last_name: last_name, company: company)
  end

  def edit_company(id, name)
    company = Company.find(id)

    if company
      company.name = name
      company.save
    end
  end

  def edit_employee(id, first_name = nil, last_name = nil, company = nil)
    employee = Employee.find(id)

    if employee
      employee.first_name = first_name if first_name
      employee.last_name = last_name if last_name
      employee.company = company if company
      employee.save
    end
  end

  def print_companies
    tp Company.all
  end

  def print_employees
    tp Employee.all
  end

  private

  def connect(db_name)
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: db_name
    )
  end

  def set_up_db
    ActiveRecord::Schema.define do
      create_table :companies, force: true do |t|
        t.string :name
      end
      create_table :employees, force: true do |t|
        t.string :first_name
        t.string :last_name
        t.references :company
      end
    end
  end

  def connection
    ActiveRecord::Base.connection
  end

  def database_exists?
    connection
  rescue ActiveRecord::NoDatabaseError
    false
  else
    true
  end

  def schema_exists?
    ActiveRecord::Base.connection.tables.present?
  end
end
