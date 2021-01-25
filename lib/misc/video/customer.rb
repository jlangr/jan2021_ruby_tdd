class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(rental)
    @rentals << rental
  end

  def statement
    total_amount, frequent_renter_points = 0, 0
    result = "Rental record for #{@name}\n"
    for element in @rentals
      this_amount = 0

      # determine amounts for each line
      case element.movie.price_code
        when Movie::REGULAR
          this_amount += 2
          if element.days_rented > 2
            this_amount += (element.days_rented - 2) * 1.5
          end
        when Movie::NEW_RELEASE
          this_amount += element.days_rented * 3
        when Movie::CHILDRENS
          this_amount += 1.5
          if element.days_rented > 3
            this_amount += (element.days_rented - 3) * 1.5
          end
        else
          # do nothing for a while
      end

      # add frequent renter points
      frequent_renter_points += 1
      if element.movie.price_code == Movie::NEW_RELEASE && element.days_rented > 1
        frequent_renter_points += 1
      end

      # add footer lines
      result += "\t#{element.movie.title}\t#{this_amount}\n"
      total_amount += this_amount
    end

    result += "Amount owed is $#{total_amount}\n"
    result += "You earned #{frequent_renter_points} frequent renter points"
    result
  end
end
