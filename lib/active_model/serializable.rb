module ActiveModel
  module Serializable
    def as_json(options={})
      if root = options.fetch(:root, json_key)
        hash              = {}
        hash[:response]   = response            if response
        hash[root]        = serializable_object
        hash[:pagination] = pagination          if pagination

        hash.merge!(serializable_data)
        hash
      else
        serializable_object
      end
    end

    def serializable_data
      embedded_in_root_associations.tap do |hash|
        if respond_to?(:meta) && meta
          hash[meta_key] = meta
        end
      end
    end

    def embedded_in_root_associations
      {}
    end
  end
end
