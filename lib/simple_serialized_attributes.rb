module SimpleSerializedAttributes
  module ClassMethods
    def simple_serialized_attributes attr_hash
      db_column = attr_hash.keys.first
      attr_hash.values.flatten.each do |attribute|
        class_eval <<-EVAL
          def #{attribute}; sticky_#{db_column}['#{attribute}']; end
          def #{attribute}=(value); self.sticky_#{db_column}['#{attribute}'] = value; end
        EVAL
      end
      class_eval <<-EVAL
        serialize :#{db_column}
        def sticky_#{db_column}; self.#{db_column} ||= {}; end
      EVAL
    end
  end
end

