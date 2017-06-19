class FilelessIO < StringIO
  attr_accessor :original_filename

  def initialize(*args)
    super(*args[1..-1])
    @original_filename = args[0]
  end
end