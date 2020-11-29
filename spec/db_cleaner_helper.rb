module DbCleaner
  def self.run
    Module.constants.select do |constant_name|
      constant = eval constant_name.to_s
      next unless constant&.is_a?(Class) &&
                  constant.ancestors.include?(ActiveRecord::Base) &&
                  constant != ApplicationRecord

      constant.destroy_all
    end
  end
end
