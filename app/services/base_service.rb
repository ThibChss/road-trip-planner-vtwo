class BaseService
  def self.call(*args, **kwargs, &block)
    new(*args, **kwargs, &block).call
  end
end
