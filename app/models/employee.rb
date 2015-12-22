class Employee

  attr_accessor :id, :first_name, :last_name, :email, :birthdate, :ssn, :full_name

  def initialize(hash)
    @id = hash["id"]
    @first_name = hash["first_name"]
    @last_name = hash["last_name"]
    @email = hash["email"]
    @birthdate = hash["birthdate"]
    @ssn = hash["ssn"]
    @full_name = hash["full_name"]
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.all
    employees = []
    employee_hashes = Unirest.get("http://localhost:3000/api/v1/employees.json").body
    employee_hashes.each do |employee_hash|
      employees << Employee.new(employee_hash)
    end
    return employees
  end

  def self.find(id)
    employee_hash = Unirest.get("http://localhost:3000/api/v1/employees/#{id}.json").body
    Employee.new(employee_hash)
  end

  def self.create(attributes)
    employee_hash = Unirest.post("http://localhost:3000/api/v1/employees.json", headers: {"Accept" => "application/json"}, parameters: attributes).body
    Employee.new(employee_hash)
  end

  def update(attributes)
    employee_hash = Unirest.patch("http://localhost:3000/api/v1/employees/#{id}.json", headers: {"Accept" => "application/json"}, parameters: attributes).body
    Employee.new(employee_hash)
  end

  def destroy
    Unirest.delete("http://localhost:3000/api/v1/employees/#{id}.json").body
  end

end