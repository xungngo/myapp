module Stripper
extend ActiveSupport::Concern
    module ClassMethods
        def strip_attributes(*args)
            mod = Module.new
            args.each do |attribute|
                define_method "#{attribute}=" do |value|
                    value = value.strip if value.respond_to? :strip
                    super(value)
                end
            end
            include mod
        end
    end
end