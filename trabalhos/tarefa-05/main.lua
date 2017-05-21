-- tarefa-05 (Binding Time)
jogador = {}
bandeira = {}
monster = {}
chao = {}
--[[
Nome: variavel "chao"
Propriedade: endereco
Binding time: compile time
Explicacao: por ser uma variavel global
o espaco e' alocado na memoria em tempo de compilacao
]]

for i = 1, 15 do
	monster[i] = {}
end
--[[
Nome: palavra reservada "for"
Propriedade: semantica
Binding time: design time
Explicacao: determinado pela especificacao da linguagem,
foi definido que o "for" abre um bloco de execucao de
repeticao ate um certo valor
]]


function love.load()
	fim = false
	tela = {comp = love.graphics.getWidth(), altu = love.graphics.getHeight()}
	chao.img = love.graphics.newImage('resources/chao.png')
	jogador.img = love.graphics.newImage('resources/jogador.png')
	bandeira.img = love.graphics.newImage('resources/bandeira.png')

	for i = 1, #monster do
		monster[i].x = tela.comp * love.math.random()
		monster[i].y = tela.altu/1.5 * love.math.random()
		monster[i].img = love.graphics.newImage('resources/monster.png')
		monster[i].a = monster[i].img : getHeight()*0.3
		monster[i].c = monster[i].img : getWidth()*0.3
		monster[i].velo = 300*love.math.random()
		monster[i].sentido = true
	end
--[[
Nome: variavel "i"
Propriedade: endereco
Binding time: run time
Explicacao: por ser uma variavel local seu espaco
na memoria sera alocado somente em tempo de execucao
]]

	jogador.x = tela.comp/2
	jogador.c = jogador.img : getWidth()*0.2 -- imagem esta diminuida
	jogador.y = tela.altu - 30
	jogador.a = jogador.img : getHeight()*0.2
	jogador.velo = 200

	bandeira.x = tela.comp*love.math.random()
--[[
Nome: funcao "random()"
Propriedade: valor
Binding time: run time
Explicacao: o valor retornado pela funcao so sera
gerado e passado durante a execucao
]]
	bandeira.y = 0
	bandeira.c = bandeira.img : getWidth()*0.5
	bandeira.a = bandeira.img : getHeight()*0.5
end

function love.update(dt)

	if not fim then
--[[
Nome: palavra reservada "if"
Propriedade: semantica
Binding time: design time
Explicacao: foi especificado na linguagem que
a palavra "if" abre um bloco de condicao, sendo
verdadeiro executa o que estiver no bloco caso
contrario passa adiante
]]
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
	return a.x + a.c >= b.x and 
		   a.x <= b.x + b.c and 
		   a.y + a.a >= b.y and 
		   a.y <= b.y + b.a
end
--[[
Nome: funcao "collides"
Propriedade: endereco
Binding time: compile time
Explicacao: por ser uma funcao ela e' criada em tempo
de compilacao - alocando espaco dentro da memoria
]]