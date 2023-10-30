 -- vector metatable:
local Vector2d = {}
Vector2d.__index = Vector2d

-- vector constructor:
function Vector2d.new(x, y)
  local v = {x = x or 0, y = y or 0}
  setmetatable(v, Vector2d)
  return v
end


-- vector addition:
function Vector2d.__add(a, b)
  return Vector2d.new(a.x + b.x, a.y + b.y)
end

-- vector subtraction:
function Vector2d.__sub(a, b)
  return Vector2d.new(a.x - b.x, a.y - b.y)
end

-- multiplication of a vector by a scalar:
function Vector2d.__mul(a, b)
  if type(a) == "number" then
    return Vector2d.new(b.x * a, b.y * a)
  elseif type(b) == "number" then
    return Vector2d.new(a.x * b, a.y * b)
  else
    error("Can only multiply vector by scalar.")
  end
end

-- dividing a vector by a scalar:
function Vector2d.__div(a, b)
   if type(b) == "number" then
      return Vector2d.new(a.x / b, a.y / b)
   else
      error("Invalid argument types for vector division.")
   end
end

-- vector equivalence comparison:
function Vector2d.__eq(a, b)
	return a.x == b.x and a.y == b.y
end

-- vector not equivalence comparison:
function Vector2d.__ne(a, b)
	return not Vector2d.__eq(a, b)
end

-- unary negation operator:
function Vector2d.__unm(a)
	return Vector2d.new(-a.x, -a.y)
end

-- vector < comparison:
function Vector2d.__lt(a, b)
	 return a.x < b.x and a.y < b.y
end

-- vector <= comparison:
function Vector2d.__le(a, b)
	 return a.x <= b.x and a.y <= b.y
end

-- vector value string output:
function Vector2d.__tostring(v)
	 return "(" .. v.x .. ", " .. v.y .. ")"
end

return Vector2d