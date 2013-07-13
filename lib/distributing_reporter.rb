class DistributingReporter
  def initialize(reporters)
    @reporters = reporters
  end

  def report(*args)
    @reporters.each { |r| r.report(*args) }
  end
end

