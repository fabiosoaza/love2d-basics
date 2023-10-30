local Enemy = {}
Enemy.__index = Enemy

local Vector2d = require("vector2d")
local Dimension2d = require("dimension2d")
local Rectangle = require("rectangle")
local util = require("util")

function Enemy.new(position, dimension, direction, start_speed)
  local p = {
    position = position,
    dimension = dimension,
    direction = direction,
    start_speed = start_speed,
    speed = start_speed
  }
  setmetatable(p, Enemy)
  return p
end  

function Enemy:update(dt, min_limit, max_limit)


  self.speed = (self.start_speed * dt)

  move_right = self.direction.x > 0
  move_left = self.direction.x < 0
  move_down = self.direction.y > 0
  move_up = self.direction.y < 0



  if not (move_left or move_right or move_up or move_down) then
    return
  end 


  if move_right and (self.position.x + self.speed) + self.dimension.width  < max_limit.x then
    self.position.x = self.position.x + self.speed
  elseif move_left and self.position.x - self.speed  > min_limit.x   then
    self.position.x = self.position.x - self.speed
  end

  if move_down and (self.position.y + self.speed) + self.dimension.height  < max_limit.y    then
    self.position.y = self.position.y + self.speed
  elseif move_up and self.position.y - self.speed  > min_limit.y   then
    self.position.y = self.position.y - self.speed 
  end


  self.position.x = util.clamp(self.position.x, min_limit.x, max_limit.x-self.dimension.width)
  self.position.y = util.clamp(self.position.y, min_limit.y, max_limit.y-self.dimension.height)

  dir_x =  self.direction.x
  dir_y =  self.direction.y

  if self:getRectangle():getLeft() <= min_limit.x then
    dir_x = 1
  elseif self:getRectangle():getRight()  >= max_limit.x then
    dir_x = -1
  end

  if self:getRectangle():getTop() <= min_limit.y then
    dir_y = 1
  elseif self:getRectangle():getBottom()  >= max_limit.y then
    dir_y = -1
  end

  self.direction = Vector2d.new(dir_x, dir_y) 

end  

function Enemy:getRectangle()
  return Rectangle.new(
    self.position,
    self.dimension
  )
end   

function Enemy:draw()
  love.graphics.rectangle("line", self.position.x, self.position.y, self.dimension.width, self.dimension.height)
end 

function Enemy.__tostring(p)
  return "(pos=" .. tostring(p.position)
  .. ", dimension=" .. tostring(p.dimension) 
  .. ", direction=" .. tostring(p.direction)
  .. ", start_speed="..tostring(p.start_speed)
  .. ", speed="..tostring(p.speed).." )"
end

return Enemy