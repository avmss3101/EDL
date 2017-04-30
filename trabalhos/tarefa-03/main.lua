jogador = {}
cacador = {}
muro = {}
chao = {}
tesouro = {}

for i = 1, 10 do
	muro[i] = {}
end

function love.load()
	posicao = {comp = love.graphics.getWidth(), altu = love.graphics.getHeight()}
	chao.img = love.graphics.newImage('resources/chao.png')
	jogador.img = love.graphics.newImage('resources/jogador.jpg')

	for i = 1, #muro do
		muro[i].x = posicao.comp * love.math.random()
		muro[i].y = posicao.altu/1.5 * love.math.random()
		if i % 2 == 0 then
			muro[i].rot = math.rad(90)
		else
			muro[i].rot = math.pi/32
		end
		muro[i].img = love.graphics.newImage('resources/muro.png')
	end
end

function love.update(dt)
	for i = 1, #muro do
		muro[i].rot = muro[i].rot + math.pi/love.math.random(100, 1000)

	end
end

function love.draw()
	love.graphics.draw(chao.img)
	love.graphics.draw(jogador.img, jogador.x, jogador.y, 0, 0.2, 0.2)
	
	for i = 1, #muro do
		love.graphics.draw(muro[i].img, muro[i].x, muro[i].y, muro[i].rot, 1, 1, muro[i].img:getWidth()/2, muro[i].img:getHeight()/2)
	end
end

function collides (a, b)
	return a.x + 32 >= b.x and a.x <= b.x + 32 and a.y + 32 >= b.y and a.y <= b.y + 32
end
