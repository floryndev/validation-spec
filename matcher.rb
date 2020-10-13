RSpec::Matchers.define :have_error_for do |key|
  match do |model|
    error_for_key_present = model.errors.key?(key)
    return error_for_key_present if @reason.blank?

    (model.errors.details[key].find { |e| e[:error] == @reason }).present?
  end

  description do |model|
    message = "to have validation error for field :#{key}"
    message += " with reason :#{@reason}" if @reason.present?
    message += " Present errors: #{model.errors.details}"
    message
  end

  chain :with_reason do |reason|
    @reason = reason
  end
end
