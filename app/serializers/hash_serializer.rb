# custom serializer to access the JSON object with symbols as well.
class HashSerializer
  def self.dump(hash)
    hash.to_json
  end

  def self.load(hash)
    if hash && hash.is_a?(String)
      eval(hash).with_indifferent_access
    else
      (hash || {}).with_indifferent_access
    end
  end
end
