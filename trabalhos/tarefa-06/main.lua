-- tarefa-06
jogador = {}
--[[
Registro
.Conjunto finito de valores heterogeneos
.elemento identificado pelo nome(campo)
]]
bandeira = {}
monster = {}
--[[
Array
.Conjunto (infinito) de valores homogeneos
.elemento identificado pelo posicao(indice)
]]
chao = {}
dicImagens = {}

for i = 1, 15 do
	monster[i] = {}
end

function love.load()
	fim = false
	tela = {comp = love.graphics.getWidth(), altu = love.graphics.getHeight()}
	dicImagens["chao"] = 'resources/chao.png'
	dicImagens["jogador"] = 'resources/jogador.png'
	dicImagens["bandeira"] = 'resources/bandeira.png'
	dicImagens["monster"] = 'resources/monster.png'
	dicImagens["propMonster"] = 0.3 -- proporcao da imagem do monstro a ser mudada
	dicImagens["propJogador"] = 0.2
	dicImagens["propBandeira"] = 0.5
	chao.img = love.graphics.newImage(dicImagens["chao"])
	jogador.img = love.graphics.newImage(dicImagens["jogador"])
	bandeira.img = love.graphics.newImage(dicImagens["bandeira"])

	for i = 1, #monster do
		monster[i].x = tela.comp * love.math.random()
		monster[i].y = tela.altu/1.5 * love.math.random()
		monster[i].img = love.graphics.newImage(dicImagens["monster"])
		monster[i].a = monster[i].img : getHeight()*dicImagens["propMonster"]
		monster[i].c = monster[i].img : getWidth()*dicImagens["propMonster"]
		monster[i].velo = 300*love.math.random()
		monster[i].sentido = 'esquerda'
		--[[
		Enumeracao
		.Tipo em que todos os valores possiveis sao constantes enumeradas
		.Substituem constantes numericas
		]]
	end

	jogador.x = tela.comp/2
	jogador.c = jogador.img : getWidth()*dicImagens["propJogador"] -- imagem esta diminuida
	jogador.y = tela.altu - 30
	jogador.a = jogador.img : getHeight()*dicImagens["propJogador"]
	jogador.velo = 200

	bandeira.x = tela.comp*love.math.random()
	bandeira.y = 0
	bandeira.c = bandeira.img : getWidth()*dicImagens["propBandeira"]
	bandeira.a = bandeira.img : getHeight()*dicImagens["propBandeira"]

	mensagemGanhou = {'Bandeira conquistada!', tela.comp/4, tela.altu/2, 0, 3, 3} -- com valores acertados para a funcao love.graphics.print
	--[[
	Tupla
	.Conjunto finito de valores heterogeneos
	.elemento identificado pela posicao
	]]
end

function love.update(dt)

	if not fim then
		for i=1, #monster do
			if monster[i].x < monster[i].c/2 then
				monster[i].sentido = 'direita'
			end
			if monster[i].x > tela.comp - monster[i].c/2 then
				monster[i].sentido = 'esquerda'
			end
			if monster[i].sentido == 'esquerda' then
				monster[i].x = monster[i].x - (monster[i].velo*dt)
			end
			if monster[i].sentido == 'direita' then
				monster[i].x = monster[i].x + (monster[i].velo*dt)
			end

			if collides(jogador, monster[i]) then
				jogador.x = tela.comp/2
				jogador.y = tela.altu - 30
				criarMonstro()
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
	love.graphics.draw(jogador.img, jogador.x, jogador.y, 0, dicImagens["propJogador"], dicImagens["propJogador"])
	love.graphics.draw(bandeira.img, bandeira.x, bandeira.y, 0, dicImagens["propBandeira"], dicImagens["propBandeira"])
	
	for i = 1, #monster do
		love.graphics.draw(monster[i].img, monster[i].x, monster[i].y, 0, dicImagens["propMonster"], dicImagens["propMonster"])
	end

	if fim then
		love.graphics.print(mensagemGanhou[1], mensagemGanhou[2], mensagemGanhou[3], mensagemGanhou[4], mensagemGanhou[5], mensagemGanhou[6])
	end
end

function collides (a, b)
	return a.x + a.c >= b.x and 
		   a.x <= b.x + b.c and 
		   a.y + a.a >= b.y and 
		   a.y <= b.y + b.a
end

function  criarMonstro()
	monster[#monster + 1] = {}
	monster[#monster].x = tela.comp * love.math.random()
	monster[#monster].y = tela.altu/1.5 * love.math.random()
	monster[#monster].img = love.graphics.newImage(dicImagens["monster"])
	monster[#monster].a = monster[#monster].img : getHeight()*dicImagens["propMonster"]
	monster[#monster].c = monster[#monster].img : getWidth()*dicImagens["propMonster"]
	monster[#monster].velo = 300*love.math.random()
	monster[#monster].sentido = 'esquerda'
end