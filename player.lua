local Player = {}
Player.__index = Player

local Vector2d = require("vector2d")
local Dimension2d = require("dimension2d")
local util = require("util")
local Rectangle = require("rectangle")

function Player.new(sprite, position, dimension, direction, start_speed)
  local p = {
    position = position,
    dimension = dimension,
    direction = direction,
    start_speed = start_speed,
    speed = start_speed,
    sprite = sprite 
  }
  setmetatable(p, Player)
  return p
end  

function Player:getRectangle()
  return Rectangle.new(
    self.position,
    self.dimension
  )
end   

function Player:update(dt, min_limit, max_limit)
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

end   

function Player:draw()
  --love.graphics.rectangle("line", self.position.x, self.position.y, self.dimension.width, self.dimension.height)
  local width_scaled = self.dimension.width/self.sprite:getWidth()
  local height_scaled = self.dimension.height/self.sprite:getHeight()
  local rotation = 0
  love.graphics.draw(self.sprite, self.position.x, self.position.y, rotation, width_scaled ,  height_scaled)
end 

function Player.__tostring(p)
  return "(pos=" .. tostring(p.position)
  .. ", dimension=" .. tostring(p.dimension) 
  .. ", direction=" .. tostring(p.direction)
  .. ", start_speed="..tostring(p.start_speed)
  .. ", speed="..tostring(p.speed).." )"
end



return Player