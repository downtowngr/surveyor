class PhoneNumber
  def initialize(number)
    number = number.to_s

    if number.length == 10
      @phone_number = number.prepend("1")
    elsif number.length == 11
      @phone_number = number
    elsif number.length == 12 && number[0] == "+"
      @phone_number = number[1..-1]
    elsif number.length == 0
      @phone_number = nil
    else
      raise Exception
    end
  end

  def localized
    @phone_number[1..-1]
  end

  def national
    @phone_number
  end

  def e164
    @phone_number.prepend("+")
  end
end
