ActiveModelSerializers.config.adapter = :json
ActiveModelSerializers.config.key_transform = :underscore

ActiveModelSerializers.config.default_includes = '**'



module ActiveModel
  class Serializer
    include Rails.application.routes.url_helpers

    class CollectionSerializer
      def paginated?
        false
      end
    end
  end
end