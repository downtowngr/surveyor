class CitizenList
  attr_reader :array

  def initialize(id_array)
    case id_array
    when Array
      @array = id_array
    when String
      @url_encoded = id_array
      @serialized = Base64.urlsafe_decode64(id_array)
      @array = Marshal.restore(@serialized)
    else
      raise Exception
    end
  end

  def url_encoded
    @url_encoded ||= Base64.urlsafe_encode64(serialized)
  end

  def serialized
    @serialized ||= Marshal.dump(@array)
  end
end
