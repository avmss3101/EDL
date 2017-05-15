jogador = {}
bandeira = {}
muro = {}
chao = {}
tesouro = {}

for i = 1, 10 do
	muro[i] = {}
end

function love.load()
	fim = false
	posicao = {comp = love.graphics.getWidth(), altu = love.graphics.getHeight()}
	chao.img = love.graphics.newImage('resources/chao.png')
	jogador.img = love.graphics.newImage('resources/jogador.jpg')
	bandeira.img = love.graphics.newImage('resources/bandeira.png')

	for i = 1, #muro do
		muro[i].x = posicao.comp * love.math.random()
		muro[i].y = posicao.altu/1.5 * love.math.random()
		muro[i].rot = math.rad(180)
		muro[i].img = love.graphics.newImage('resources/muro.png')
		muro[i].a = muro[i].img : getHeight()
		muro[i].c = muro[i].img : getWidth()
		muro[i].velo = 300*love.math.random()
		muro[i].sentido = true
	end
	

	jogador.x = posicao.comp/2
	jogador.c = jogador.img : getWidth()*0.2 -- imagem esta diminuida
	jogador.y = posicao.altu - 30
	jogador.a = jogador.img : getHeight()*0.2
	jogador.velo = 200

	bandeira.x = posicao.comp*love.math.random()
	bandeira.y = 0
	bandeira.c = bandeira.img : getWidth()*0.1
	bandeira.a = bandeira.img : getHeight()*0.1
end

function love.update(dt)

	if not fim then
		for i=1, #muro do
			if muro[i].x < muro[i].c/2 then
				muro[i].sentido = false
			end
			if muro[i].x > posicao.comp - muro[i].c/2 then
				muro[i].sentido = true
			end
			if muro[i].sentido then
				muro[i].x = muro[i].x - (muro[i].velo*dt)
			end
			if not muro[i].sentido then
				muro[i].x = muro[i].x + (muro[i].velo*dt)
			end

			if collides(jogador, muro[i]) then
				jogador.x = posicao.comp/2
				jogador.y = posicao.altu - 30
			end	

			if collides(jogador, bandeira) then
				fim = true
			end
		end

		if love.keyboard.isDown('d') then
			if jogador.x < (posicao.comp - jogador.c) then
				jogador.x = jogador.x + (jogador.velo*dt) -- andar pra direita
			end
		elseif love.keyboard.isDown('a') then
			if jogador.x > 0 then
				jogador.x = jogador.x - (jogador.velo*dt) -- andar pra esquerda
			end
		elseif love.keyboard.isDown('w') then
			if jogador.y > jogador.img : getHeight()*0.05 then
				jogador.y = jogador.y - (jogador.velo*dt) -- andar pra cima
			end
		elseif love.keyboard.isDown('s') then
			if jogador.y < (posicao.altu - jogador.c) then
				jogador.y = jogador.y + (jogador.velo*dt) -- andar pra baixo
			end
		end
	end
end

function love.draw()
	love.graphics.draw(chao.img)
	love.graphics.draw(jogador.img, jogador.x, jogador.y, 0, 0.2, 0.2)
	love.graphics.draw(bandeira.img, bandeira.x, bandeira.y, 0, 0.1, 0.1)
	
	for i = 1, #muro do
		love.graphics.draw(muro[i].img, muro[i].x, muro[i].y, muro[i].rot, 1, 1, muro[i].c/2, muro[i].a/2)
	end

	if fim then
		love.graphics.print('Bandeira conquistada!', posicao.comp/4, posicao.altu/2, 0, 3, 3)
	end
end

function collides (a, b)
	return a.x + a.c >= b.x - b.c/2 and a.x <= b.x + b.c/2 and a.y + a.a >= b.y and a.y <= b.y + b.a
end
