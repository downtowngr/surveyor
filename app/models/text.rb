class Text
  attr_reader :body, :number, :params
  attr_accessor :keyword, :respond_with

  def initialize(params)
    @params = params

    @number = params["From"].split(//).last(10).join
    @body = params["Body"]

    @keyword = @body.upcase if @body =~ /^[[[:alnum:]]|#][\w|-]+$/
  end

  def keyword?
    !!keyword
  end
end
