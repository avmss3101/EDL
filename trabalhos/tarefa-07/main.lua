-- tarefa-07
jogador = {}
bandeira = {}
monster = {}
chao = {}
dicImagens = {}
tiro = {}

for i = 1, 15 do
	monster[i] = {} -- sempre comeca com pelo menos 15 monsters
	-- comeco de vida de 15 monsters globais
end

function love.load()
	fim = false
	tela = {comp = love.graphics.getWidth(), altu = love.graphics.getHeight()}
	dicImagens["chao"] = 'resources/chao.png'
	dicImagens["jogador"] = 'resources/jogador.png'
	dicImagens["bandeira"] = 'resources/bandeira.png'
	dicImagens["monster"] = 'resources/monster.png'
	dicImagens["tiro"] = 'resources/tiro.png'
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

			if collides(jogador, monster[i]) then -- colisao
				jogador.x = tela.comp/2
				jogador.y = tela.altu - 30
				criarMonstro() -- cria novos objetos monster assim que jogador colide com um deles ja existente
				-- comeco de vida de outros monsters globais
			end	

			if collides(jogador, bandeira) then -- colisao
				fim = true
			end
		end

		for i=1, #tiro do
			local colidiu = false
			tiro[i].y = tiro[i].y - tiro[i].velo*dt
			tiro[i].x = tiro[i].x + tiro[i].velo*dt
			for j=1, #monster do
				if collides(tiro[i], monster[j]) and #monster > 15 then
					table.remove(monster, j) -- objeto monster de indice j e' removido se ao menos ha mais de 15 monsters vivos
					-- fim de vida de um monster global
					colidiu = true
					break
				end
			end
			if tiro[i].y < 0 or tiro[i].x > tela.comp or colidiu then
				table.remove(tiro, i) -- tiro e' removido assim que passa da tela tanto horizontalmente como verticalmente - considerando
				-- fim de vida de um tiro global
				colidiu = false		  -- que a bala tem um movimento em diagonal
				break -- o for(loop) pegou o tamanho da array tiro antes dele ser decrementado pelo table.remove
			end       -- para nao dar problema eu saio do loop com o break
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
		elseif love.keyboard.isDown('r') then -- tiro
			tiro[#tiro+1] = {}
			-- comeco de vida de um tiro global
			tiro[#tiro].img = love.graphics.newImage(dicImagens["tiro"])
			tiro[#tiro].x = jogador.x + jogador.c + 10
			tiro[#tiro].c = tiro[#tiro].img : getWidth()
			tiro[#tiro].y = jogador.y
			tiro[#tiro].a = tiro[#tiro].img : getHeight()
			tiro[#tiro].velo = 300
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

	for i = 1, #tiro do
		love.graphics.draw(tiro[i].img, tiro[i].x, tiro[i].y)
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
