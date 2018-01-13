local bump = require "bump"
world = bump.newWorld()
font = love.graphics.setNewFont("Quicksand-Light.ttf")



enemy = {x = 0,
	y = 0,
	width = 32,
	height = 64,
	jump = -350,
	gravity = 500,
	runSpeed = 400,
	xVelocity = 0,
	yVelocity = 0,
	terminalVelocity = 1900
	}

player = {
	x = 0,
	y = 0,
	width = 32,
	height = 64,
	jump = -350,
	gravity = 500,
	runSpeed = 400,
	xVelocity = 0,
	yVelocity = 0,
	terminalVelocity = 1900
}

function player.setPosition(x, y)
	player.x, player.y = x, 1100
end

function player.update(dt)
	player.move(dt)
	player.applyGravity(dt)
	player.collied(dt)
end

function player.move(dt)

if love.keyboard.isDown("e") then
love.event.quit()
end

if love.keyboard.isDown("r") then  
love.event.quit("restart")
	 end
	 
 if love.keyboard.isDown("q") then  
love.window.setMode( 1800, 900)
end

if love.keyboard.isDown("d") then
	player.xVelocity = player.runSpeed
elseif love.keyboard.isDown("a") then
	player.xVelocity = -player.runSpeed
else
	player.xVelocity = 0
	end
	
	
	if love.keyboard.isDown("w") then
	
		if player.yVelocity == 0 then
			player.yVelocity = player.jump
			end
			 
			 
	end
end

if player.yVelocity ~= 0 then
		player.y = player.y + player.yVelocity 
		player.yVelocity = player.yVelocity - player.gravity 
	end

function player.applyGravity(dt)
	if player.yVelocity < player.terminalVelocity then
		player.yVelocity = player.yVelocity + player.gravity * dt
	else
		player.yVelocity = player.terminalVelocity
	end
end

function player.collied(dt)
	local futureX = player.x + player.xVelocity * dt
	local futureY = player.y + player.yVelocity * dt
	local nextX, nextY, cols, len = world:move(player, futureX, futureY )
	
	for i = 1, len do
	local col = cols[i]
	if col.normal.y == -1 or col.normal.y == 1 then
		player.yVelocity = 0 
		end
	end
	
	player.x = nextX
	player.y = nextY
end

function player.draw()
end

local level = require "level_1"

function loadObjects(level)
local objects = level.layers[1].objects
for i = 1, #objects do
local obj = objects[i]
world:add(obj, obj.x, obj.y, obj.width, obj.height)
	end
end

local function boxesIntersect(a,b)
  return a.l < b.l+b.w and
         a.l+a.w > b.l and
         a.t < b.t+b.h and
         a.t+a.h > b.t
end

function drawObjects(level)
local objects = level.layers[1].objects
love.graphics.setColor(0,20,200)
for i = 1, #objects do
local obj = objects[i]
love.graphics.rectangle("line", obj.x, obj.y, obj.width, obj.height, love.graphics.setColor(255, 5, 255))
    love.graphics.setColor(255, 0, 0, 255)
    love.graphics.print("A is for left, D is for right, W is for jump.", 10, 1230, 200, 2, 2, love.graphics.setColor(255, 0, 0))
	love.graphics.print("E is to quit, Q is to change screen size.", 10, 1150, 200, 2, 2, love.graphics.setColor(255, 0, 0))
	love.graphics.print("R is for reset.", 10, 1050, 200, 2, 2, love.graphics.setColor(255, 0, 0))
	 love.graphics.print("Hello Welcome to my game, I hope you enjoy.", 10, 1250, 0, 2, 2, love.graphics.setColor(0, 255, 0))
	 love.graphics.print("The Objective of the game is get to the end.", 1150, 1040, 0, 2, 2, love.graphics.setColor(150, 150, 150))
	  love.graphics.print("You can climb upside down if you hold Jump.", 1690, 840, 0, 1, 1, love.graphics.setColor(0, 150, 255))
	  love.graphics.print("Careful if the cube monser hits you then you'll have to restart.", 3584.00, 1790.00, 0, 2, 2, love.graphics.setColor(0, 150, 255))
	  love.graphics.print("Jump off trust me.", 6172.00, 320.00, 0, 2, 2, love.graphics.setColor(0, 150, 255))
	  love.graphics.print("Jump fuzzy cat dude you can make it!!!", 2408.00, 210.00, 0, 1, 1, love.graphics.setColor(0, 150, 255))
	end
end
--Main

function love.load()

	player.setPosition(love.graphics.getWidth()/2, 0)
	world:add(player, player.x, player.y, player.width, player.height)
	loadObjects(level)
	sound = love.audio.newSource("bensound-scifi.mp3")
	love.audio.play(sound)
print(love.system.getPowerInfo())
end

function love.update(dt)
 time = love.timer.getTime()
	player.update(dt)
end

function love.draw()
	scale = 0.8
  dx = player.x - (love.graphics.getWidth() / 2) / scale
  dy = player.y - (love.graphics.getHeight() / 2) / scale

  love.graphics.scale(scale)
  love.graphics.translate(-dx, -dy)
	player.draw()
	player.img = love.graphics.newImage('purple.png')
	love.graphics.draw(player.img, player.x, player.y, 0, 1, 1, 20, 30, love.graphics.setColor(255,255,255))
	drawObjects(level)
  end
  