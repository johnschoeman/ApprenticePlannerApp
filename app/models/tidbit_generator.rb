class TidbitGenerator
  def initialize(date)
    @date = date
    @source = StackOverflowApiIntegration.new(date)
    @tidbit = nil
  end

  def self.generate(date = Time.zone.today)
    new(date).tidbit
  end

  def tidbit
    @tidbit ||= Tidbit.new(@source.query)
  end
end
