module GenerateUuidv7
  extend ActiveSupport::Concern

  included do
    before_create :generate_uuid_v7
  end

  def generate_uuid_v7
    return if self.class.attribute_types['id'].type != :uuid

    self.id ||= UUID7.generate
  end
end
