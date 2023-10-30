local Vector2d = require("vector2d")
local Dimension2d = require("dimension2d")

local Rectangle = {}
Rectangle.__index = Rectangle

function Rectangle.new(position, dimension)
  local p = {
    position = position,
    dimension = dimension
  }
  setmetatable(p, Rectangle)
  return p
end

function Rectangle:collided(collidee)
  return  self:getRight() > collidee:getLeft()
  and self:getLeft() < collidee:getRight()
  and self:getBottom() > collidee:getTop()
  and self:getTop() < collidee:getBottom()
end  

function Rectangle:getLeft()
  return self.position.x
end

function Rectangle:getRight()
  return self.position.x + self.dimension.width
end

function Rectangle:getTop()
  return self.position.y
end

function Rectangle:getBottom()
  return self.position.y + self.dimension.height
end




return Rectangle