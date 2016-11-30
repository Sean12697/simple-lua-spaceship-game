player = { x = 400, y = 500 }
enemy = {x = 400, y = 100}
bullets = {}
gamemode = 0
score = 0

shootCounter = 0

function shoot()
	if shootCounter == 0 then
		bullets[#bullets+1] = { x = player.x + player.image:getWidth()/2 -bulletImage:getWidth()/2 , y = player.y }
		love.audio.stop(bulletSound)
		love.audio.play( bulletSound )
		shootCounter = 5
	end
end

function updateBullets()
	for i = #bullets, 1, -1 do
		bullets[i].y = bullets[i].y - 20
		if bullets[i].y < -100 then
			table.remove(bullets, i)
		end
	end
end

function love.load(arg)
	player.image = love.graphics.newImage("ship_albertov_1.png")
	enemy.image = love.graphics.newImage("ship_enemy_1.png")
	bulletImage = love.graphics.newImage("redLaserRay.png")
	bulletSound  = love.audio.newSource("Laser_Shoot15.wav")
end

function love.update(dt)
	
	if gamemode == 0 then
		if love.keyboard.isDown('escape') then
			love.event.push('quit')
		end
		if love.keyboard.isDown('right') then -- and love.graphics.getWidth() > player.x then
			player.x = player.x + 10
		end
		if love.keyboard.isDown('left') then -- and love.graphics.getWidth() < player.x then
			player.x = player.x - 10	
		end
		if love.keyboard.isDown('space') then
			shoot()
		end
		updateBullets()
		enemy.x = enemy.x + love.math.random(-5, 5)
		enemy.y = enemy.y + 1
		if enemy.y > 400 then
			gamemode = 1
		end
	end
	
	if gamemode == 1 then
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.print("YOU HAVE LOST", 200, 300)
	end
	
	if love.keyboard.isDown('return') and gamemode == 1 then
		gamemode = 0
		reset()
	end
	
end

function reset() 
	enemy.x = 400
	enemy.y = 100
end

function love.draw(dt)
	if shootCounter > 0 then
		shootCounter = shootCounter - 1
	end
	for i = 1, #bullets do
		love.graphics.draw( bulletImage, bullets[i].x, bullets[i].y )
	end
	love.graphics.draw( player.image, player.x, player.y )
	love.graphics.draw( enemy.image, enemy.x, enemy.y )
end
