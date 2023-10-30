local Vector2d = require("vector2d")
local Dimension2d = require("dimension2d")
local Player = require("player")
local Enemy = require("enemy")


local SPEED = 200
local LIMIT_LEFT=0
local LIMIT_RIGHT=love.graphics.getWidth()
local LIMIT_TOP=0
local LIMIT_BOTTOM=love.graphics.getHeight()

local WIDTH=200
local HEIGHT=150
local pos_x = 100
local pos_y = 50

local ENEMY_WIDTH=100
local ENEMY_HEIGHT=100
local enemy_pos_x = 150
local enemy_pos_y = 300
local ENEMY_SPEED=60

local player = {} 
local enemy = {}
local collided = false

function love.load()
  local image = love.graphics.newImage("assets/images/sprite.png")
  player = Player.new(
    image,
    Vector2d.new(pos_x, pos_y), 
    Dimension2d.new(image:getWidth()*0.25, image:getWidth()*0.25), 
    Vector2d.new(0, 0), SPEED
  )

  math.randomseed( os.time())
  dir = math.random(-1,1)

  enemy = Enemy.new(
    Vector2d.new(enemy_pos_x, enemy_pos_y), 
    Dimension2d.new(ENEMY_WIDTH, ENEMY_HEIGHT), 
    Vector2d.new(dir, 0), ENEMY_SPEED
  )
end

function love.draw()
  enemy:draw()
  player:draw()
  love.graphics.print("Current FPS: " .. tostring(love.timer.getFPS()), 10, 10)
  love.graphics.print("player : " .. tostring(player), 10, 20)
  love.graphics.print("collided : " .. tostring(collided), 10, 30)
end

function love.keypressed(key)
  -- equivalent to call love.keyboard.isDown("right") in update method
end

function love.update(dt)

  local dir_x = 0
  local dir_y = 0

  if love.keyboard.isDown("right") then
    dir_x = 1
  elseif love.keyboard.isDown("left") then 
    dir_x = -1
  end   

  if love.keyboard.isDown("down") then
    dir_y= 1
  elseif love.keyboard.isDown("up") then 
    dir_y = -1
  end 

  player.direction = Vector2d.new(dir_x, dir_y)

  player:update(dt,  
    Vector2d.new(LIMIT_LEFT, LIMIT_TOP), 
    Vector2d.new(LIMIT_RIGHT, LIMIT_BOTTOM)
  )   

  enemy:update(dt,  
    Vector2d.new(LIMIT_LEFT, LIMIT_TOP), 
    Vector2d.new(LIMIT_RIGHT, LIMIT_BOTTOM)
  )   

  collided = player:getRectangle():collided(enemy:getRectangle())


end