class Text
  attr_reader :body, :number, :params
  attr_accessor :keyword, :respond_with

  def initialize(params)
    @params = params

    # Once this becomes an ActiveRecord model, normalize with helper
    @number = PhoneNumber.new(params["From"]).national
    @body = params["Body"].strip
  end

  def keyword?
    !!keyword
  end
end
