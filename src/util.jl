import Base.convert

function hex2oct(hex_string::String)
  hex_length = length(hex_string)

  # Left pad with 0 to make hex_string even length
  if hex_length % 2 != 0
    hex_string = string("0", hex_string)
    hex_length += 1
  end

  hex_length = div(hex_length, 2)

  return [uint8(parseint(hex_string[2i-1:2i], 16)) for i in 1:hex_length]
end

function oct2hex(hex_array::Array{Uint8})
  return join([hex(h, 2) for h in hex_array], "")
end

# TODO: String manipulation is really not the best way
function int2oct(x::Integer)
  padding = 0
  if typeof(x) != BigInt
    padding = sizeof(x) * 2
    hex_string = hex(x, padding)
  else
    hex_string = hex(x)
  end
  return hex2oct(hex_string)
end

function oct2int(x::Array{Uint8})
  result = BigInt(0)

  for i in 1:length(x)
    result <<= 8
    result += x[i]
  end

  if length(x) <= 1
    return uint8(result)
  elseif length(x) <= 2
    return uint16(result)
  elseif length(x) <= 4
    return uint32(result)
  elseif length(x) <= 8
    return uint64(result)
  elseif length(x) <= 16
    return uint128(result)
  else
    return result
  end
end