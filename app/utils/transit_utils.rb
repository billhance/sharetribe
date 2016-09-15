module TransitUtils
  module_function

  def encode(content, encoding)
    io = StringIO.new('', 'w+')

    converted = content.map { |k, v|
      [
        k,
        v.is_a?(UUIDTools::UUID) ? Transit::UUID.new(v.to_s) : v
      ]
    }.to_h

    # TODO: change to a custom uuid handler that overrides the Transit
    # uuid handler, being compatible with the on-wire representation

    writer = Transit::Writer.new(encoding, io)
    writer.write(converted)
    io.string
  end

  def decode(content, encoding)
    Transit::Reader.new(encoding, StringIO.new(content)).read
  end
end
