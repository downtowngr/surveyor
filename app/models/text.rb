class Text
  attr_reader :body, :number, :params
  attr_accessor :keyword, :respond_with

  def initialize(params)
    @params = params

    # Once this becomes an ActiveRecord model, normalize with helper
    @number = Phony.normalize(params["From"])
    @body = params["Body"].strip
  end

  def keyword?
    !!keyword
  end
end
