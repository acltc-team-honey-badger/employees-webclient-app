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
    employee_hashes = Unirest.get("#{ENV['API_BASE_URL']}/employees.json").body
    employee_hashes.each do |employee_hash|
      employees << Employee.new(employee_hash)
    end
    return employees
  end

  def self.find(id)
    employee_hash = Unirest.get("#{ENV['API_BASE_URL']}/employees/#{id}.json").body
    Employee.new(employee_hash)
  end

  def self.create(attributes)
    employee_hash = Unirest.post("#{ENV['API_BASE_URL']}/employees.json", headers: {"Accept" => "application/json"}, parameters: attributes).body
    Employee.new(employee_hash)
  end

  def update(attributes)
    employee_hash = Unirest.patch("#{ENV['API_BASE_URL']}/employees/#{id}.json", headers: {"Accept" => "application/json"}, parameters: attributes).body
    Employee.new(employee_hash)
  end

  def destroy
    Unirest.delete("#{ENV['API_BASE_URL']}/employees/#{id}.json").body
  end

end