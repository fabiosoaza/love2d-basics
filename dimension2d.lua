 -- dimension metatable:
local Dimension2d = {}
Dimension2d.__index = Dimension2d

-- dimension constructor:
function Dimension2d.new(width, height)
  local v = {width = width or 0, height = height or 0}
  setmetatable(v, Dimension2d)
  return v
end


-- dimension addition:
function Dimension2d.__add(a, b)
  return Dimension2d.new(a.width + b.width, a.height + b.height)
end

-- dimension subtraction:
function Dimension2d.__sub(a, b)
  return Dimension2d.new(a.width - b.width, a.height - b.height)
end

-- multiplication of a dimension by a scalar:
function Dimension2d.__mul(a, b)
  if type(a) == "number" then
    return Dimension2d.new(b.width * a, b.height * a)
  elseif type(b) == "number" then
    return Dimension2d.new(a.width * b, a.height * b)
  else
    error("Can only multiply dimension by scalar.")
  end
end

-- dividing a dimension by a scalar:
function Dimension2d.__div(a, b)
   if type(b) == "number" then
      return Dimension2d.new(a.width / b, a.height / b)
   else
      error("Invalid argument types for dimension division.")
   end
end

-- dimension equivalence comparison:
function Dimension2d.__eq(a, b)
	return a.width == b.width and a.height == b.height
end

-- dimension not equivalence comparison:
function Dimension2d.__ne(a, b)
	return not Dimension2d.__eq(a, b)
end

-- unary negation operator:
function Dimension2d.__unm(a)
	return Dimension2d.new(-a.width, -a.height)
end

-- dimension < comparison:
function Dimension2d.__lt(a, b)
	 return a.width < b.width and a.height < b.height
end

-- dimension <= comparison:
function Dimension2d.__le(a, b)
	 return a.width <= b.width and a.height <= b.height
end

-- dimension value string output:
function Dimension2d.__tostring(d)
	 return "(" .. d.width .. ", " .. d.height .. ")"
end

return Dimension2d