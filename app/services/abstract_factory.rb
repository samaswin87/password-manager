class AbstractFactory

  # @abstract
  # return instance of a class
  def instance
    raise NotImplementedError, "#{self.class} has not implemented #{__method__}"
  end

end
