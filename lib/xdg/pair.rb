# frozen_string_literal: true

module XDG
  PAIR_DELIMITER = "="

  # A generic key-value pair (KVP).
  Pair = Struct.new :key, :value do
    def to_env = Hash[*values]

    def key? = key.to_s.size.positive?

    def value? = value.to_s.size.positive?

    def empty? = !(key? && value?)

    def inspect
      return "" unless key? || value?

      "#{key}#{PAIR_DELIMITER}#{value}"
    end
  end
end
