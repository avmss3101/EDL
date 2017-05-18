jogador = {}
bandeira = {}
monster = {}
chao = {}
tesouro = {}

for i = 1, 15 do
	monster[i] = {}
end

function love.load()
	fim = false
	tela = {comp = love.graphics.getWidth(), altu = love.graphics.getHeight()}
	chao.img = love.graphics.newImage('resources/chao.png')
	jogador.img = love.graphics.newImage('resources/jogador.png')
	bandeira.img = love.graphics.newImage('resources/bandeira.png')

	for i = 1, #monster do
		monster[i].x = tela.comp * love.math.random()
		monster[i].y = tela.altu/1.5 * love.math.random()
		-- monster[i].rot = math.rad(180)
		monster[i].img = love.graphics.newImage('resources/monster.png')
		monster[i].a = monster[i].img : getHeight()*0.3
		monster[i].c = monster[i].img : getWidth()*0.3
		monster[i].velo = 300*love.math.random()
		monster[i].sentido = true
	end
	

	jogador.x = tela.comp/2
	jogador.c = jogador.img : getWidth()*0.2 -- imagem esta diminuida
	jogador.y = tela.altu - 30
	jogador.a = jogador.img : getHeight()*0.2
	jogador.velo = 200

	bandeira.x = tela.comp*love.math.random()
	bandeira.y = 0
	bandeira.c = bandeira.img : getWidth()*0.5
	bandeira.a = bandeira.img : getHeight()*0.5
end

function love.update(dt)

	if not fim then
		for i=1, #monster do
			if monster[i].x < monster[i].c/2 then
				monster[i].sentido = false
			end
			if monster[i].x > tela.comp - monster[i].c/2 then
				monster[i].sentido = true
			end
			if monster[i].sentido then
				monster[i].x = monster[i].x - (monster[i].velo*dt)
			end
			if not monster[i].sentido then
				monster[i].x = monster[i].x + (monster[i].velo*dt)
			end

			if collides(jogador, monster[i]) then
				jogador.x = tela.comp/2
				jogador.y = tela.altu - 30
			end	

			if collides(jogador, bandeira) then
				fim = true
			end
		end

		if love.keyboard.isDown('d') then
			if jogador.x < (tela.comp - jogador.c) then
				jogador.x = jogador.x + (jogador.velo*dt) -- andar pra direita
			end
		elseif love.keyboard.isDown('a') then
			if jogador.x > 0 then
				jogador.x = jogador.x - (jogador.velo*dt) -- andar pra esquerda
			end
		elseif love.keyboard.isDown('w') then
			if jogador.y > 0 then
				jogador.y = jogador.y - (jogador.velo*dt) -- andar pra cima
			end
		elseif love.keyboard.isDown('s') then
			if jogador.y < (tela.altu - jogador.a) then
				jogador.y = jogador.y + (jogador.velo*dt) -- andar pra baixo
			end
		end
	end
end

function love.draw()
	love.graphics.draw(chao.img)
	love.graphics.draw(jogador.img, jogador.x, jogador.y, 0, 0.2, 0.2)
	love.graphics.draw(bandeira.img, bandeira.x, bandeira.y, 0, 0.5, 0.5)
	
	for i = 1, #monster do
		love.graphics.draw(monster[i].img, monster[i].x, monster[i].y, 0, 0.3, 0.3)
	end

	if fim then
		love.graphics.print('Bandeira conquistada!', tela.comp/4, tela.altu/2, 0, 3, 3)
	end
end

function collides (a, b)
	return a.x + a.c >= b.x and a.x <= b.x + b.c and a.y + a.a >= b.y and a.y <= b.y + b.a
end