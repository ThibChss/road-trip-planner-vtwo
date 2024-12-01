class String
  def record
    @record ||= begin ObjectSpace.each_object(Class)
                                 .select { |klass| klass < ApplicationRecord }
                                 .each do |model|
                        result = model.find_by(id: self)
                        return result if result
                      end
                      nil
    end
  end
end
