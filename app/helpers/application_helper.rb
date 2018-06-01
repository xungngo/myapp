module ApplicationHelper

    def pluralize_no_count(obj, desc)
        pluralize(obj.count, desc).sub("#{obj.count}", "")
    end
end
