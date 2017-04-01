module SerializerNormalization
  refine ActiveModel::Serializer.singleton_class do
    def normalize(target)
      case target
        when Array
          {data: target.map{|attributes| {type: self._type}.merge(attributes: attributes)}}
      end
    end
  end
end