module UUIDUtils
  module_function

  def bin16_uuid
    # TODO: Use https://github.com/assaf/uuid
    s = SecureRandom.uuid.gsub("-", "")
    rearranged = "#{s[12..15]}#{s[8..11]}#{s[0..7]}#{s[16..-1]}"
    hexes = rearranged.scan(/[0-9a-f]{4}/).map { |n| n.to_i(16) }
    hexes.pack("n*")
  end

end
