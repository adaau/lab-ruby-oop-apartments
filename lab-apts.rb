class Building
  attr_reader :address, :apartments

  def initialize (address)
    @address = address
    @apartments = []
  end

  def add_apartment(apartment)
    @apartments << apartment
  end

  def remove_apartment(number)
    @apartments.delete_if {|key, value| value = number }
  end

  def total_sqft
    @apartments.sqft.reduce(:+)
  end
end

class Apartment < Building
  attr_reader :number, :rent, :sqft, :bedrooms, :bathrooms, :tenants, :avg_credit_score, :avg_credit_rating

  def initialize (number, rent, sqft, bedrooms, bathrooms)
    @number = number
    @rent = rent
    @sqft = sqft
    @bedrooms = bedrooms
    @bathrooms = bathrooms
    @tenants = []
  end


# add to tenants array. to access, apt1.tenants[0].name etc
  def add_tenant(tenant)
    if tenant.credit_rating == "bad"
      raise "Tenant's credit rating is bad."
    end
    if @tenants.length > @bedrooms
      raise "Apartment is full."
    end
    @tenants << tenant
  end

  def remove_tenant(index)
    @tenants.slice!(index)
  end

  def remove_all_tenants
    @tenants.slice!(0..-1)
  end

  def avg_credit_score
    @tenants.inject(0){ |sum, n| sum + n.credit_score }.to_f / @tenants.size
  end

  def avg_credit_rating
    if @avg_credit_score >= 760
      "excellent"
    elsif @avg_credit_score >= 725
      "great"
    elsif @avg_credit_score >= 660
      "good"
    elsif @avg_credit_score >= 560
      "mediocre"
    else
      "bad"
    end
  end

end

class Tenant < Apartment
  attr_reader :name, :age, :credit_score

  def initialize (name, age, credit_score)
    @name = name
    @age = age
    @credit_score = credit_score
  end

  def credit_rating
    if @credit_score >= 760
      "excellent"
    elsif @credit_score >= 725
      "great"
    elsif @credit_score >= 660
      "good"
    elsif @credit_score >= 560
      "mediocre"
    else
      "bad"
    end
  end

end
building1 = Building.new("1 Queen's Road")

apt1 = Apartment.new(19, 20000, 2700, 4, 3)
tenant1 = Tenant.new("Anna", 25, 700)
tenant2 = Tenant.new("Bob", 30, 600)
tenant3 = Tenant.new("Cate", 35, 700)
tenant4 = Tenant.new("Dan", 40, 800)
tenant5 = Tenant.new("Eric", 20, 500)
apt1.add_tenant(tenant1)