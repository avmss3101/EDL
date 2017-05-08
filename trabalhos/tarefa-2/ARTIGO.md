# Linguagem de Programação FORTRAN

### Origens e influências

Certamente um dos maiores avanços particulares na computação veio com a introdução do IBM 704 em 1954, em grande medida porque suas capacidades motivaram o desenvolvimento do FORTRAN.
Embora o Fortran seja frequentemente creditado como sendo a primeira linguagem de alto nível compilada, a questão de quem merece o crédito pela iniciativa de implementação é bastante aberta. Knuth and Pardo (1977) dão os créditos a Alick E. Glennie pelo seu compilador Autocode para o computador Manchester Mark I. Glennie desenvolveu o compilador em Fort Halstead, Royal Armaments Research Establishment, Inglaterra. O compilador estava operacional em Setembro de 1952. Entretanto, de acordo com John Backus (Wexelblat, 1981, p.26), o Autocode de Glennie era tão baixo nível e orientado à máquina que não deve ser considerado um sistema compilado. Backus dá o crédito a Laning e Zierler, do Massachussetts Institute of Technology.  O sistema foi implementado no computador Whirlwind do MIT, na forma de protótipo experimental no verão de 1952, em uma forma mais utilizável em maio de 1953.
Apesar desses  trabalhos anteriores, a primeira linguagem de alto nível compilada bem aceita foi o FORTRAN.

Mesmo antes do sistema 704 ter sido anunciado em maio de 1954, os planos para o FORTRAN já haviam sido iniciados. Em novembro de 1954, John Backus e seu grupo na IBM haviam produzido o relatório intitulado “The IBM Mathmatical FORmula TRANslating System: FORTRAN” (IBM, 1954). Esse documento descrevia a primeira versão do FORTRAN, ou FORTRAN 0, antes de sua implementação. Ele também declarava que o FORTRAN ofereceria a eficiência dos programas codificados à mão e a facilidade de programação dos sistemas de pseudocódigo interpretativos.
O ambiente em que o FOTRAN foi desenvolvido era o seguinte: (1) os computadores ainda eram pequenos, lentos e relativamente pouco confiáveis; (2) seu principal uso era para computações científicas; (3) não existia nenhuma maneira eficiente de programar computadores; (4) por causa de seu elevado custo em comparação com o custo dos programadores, a velocidade do código-objeto gerado era a meta principal dos primeiros compiladores FORTRAN. As características das suas primeiras versões do FORTRAN decorrem diretamente desse ambiente.

A mais audaciosa reivindicação feita pelo grupo de desenvolvimento do FORTRAN durante o seu projeto foi que o código de máquina produzido pelo compilador seria quase tão eficiente quanto aquilo que poderia ser produzido manualmente. Para surpresa de quase todo mundo, entretanto, o grupo de desenvolvimento do FORTRAN quase atingiu sua meta em termos de eficiência.
O sucesso inicial do FORTRAN é mostrado pelos resultados de uma pesquisa feita em abril de 1958. Naquela época, aproximadamente metade do código escrito para os 704 estava sendo feita em FORTRAN, apesar do extremo ceticismo da maior parte do mundo da programação a apenas um ano antes.

Destaques das versões:

FORTRAN II (primavera de 1958): compilação independente de sub-rotinas.
FORTRAN IV (1960): declarações de tipo explícitas para variáveis, capacidade de passar subprogramas como parâmetros a outros subprogramas.
FORTRAN 77 (1978): ANSI, manipulação de cadeias de caracteres, instruções lógicas de controle de laço e um IF com a cláusula opcional ELSE.
Fortran 90 (1992): conjunto de funções é incorporado para operações com matrizes,  matrizes podem ser dinamicamente alocadas e desalocadas (mudança radical em relação aos FORTRANs anteriores, os quais tinham apenas dados estáticos), novas instruções de controle foram adicionadas: CASE, EXIT, CYCLE, subprogramas podem ser recursivos
Fortran 95 (1997): nova construção interativa, Forall,foi adicionado para facilitar a tarefa de paralelismo nos programas.
Fortran 2003 (2004):  suporte para programação orientada a objeto, ponteiros procedurais,  tipos derivados parametrizados e interação com a linguagem de programação em C.
Fortran 2008 (2010): suporte para os blocos definirem escopos locais.

O efeito que o FORTRAN teve no uso dos computadores, juntamente com o fato das linguagens de programação subsequentes terem uma dívida com o FORTRAN, são, realmente impressionantes à luz das modestas metas de seus projetistas.
Alan Perlis, um dos desenvolvedores do ALGOL 60, disse do Fortran em 1978,
“Fortran é a língua franca do mundo da computação. É a linguagem das ruas no melhor sentido da palavra, não no sentido prostituído da palavra. E ela sobreviveu e sobreviverá porque tornou-se uma parte notavelmente útil de um comércio muito vital" (Wexelblat, 1981, p. 161).

### Classificação

FORTRAN é uma linguagem imperativa, procedural, compilada e estática. Recentemente em novas versões o FORTRAN passou a suportar programação orientada a objetos.

### FORTRAN X Java

Na questão da **legibilidade** ambas são fáceis de ler. Já a **escrita** o FORTRAN se destaca mais, apesar da diferença da facilidade de escrever não ser tão gritante,sendo mais pelo fato do Java ser muito verbosa, precisar de muitas exceções e ter que chamar muitas funções "pais" por ser fortemente orientada a objetos, bem diferente do FORTRAN 90 - mas já mudada na versão FORTRAN 2003.
O FORTRAN por ser uma linguagem muita relacionada com a computação científica e análise numérica tem muita facilidade para resolver problemas envolvendo contas matemáticas ao contrário do Java que é mais voltada a empresas de ramos variados.

### Exemplos de código

#### Em FORTRAN

```
program media

! Le alguns numeros e faz uma media

  implicit none
  integer :: qnt
  real, dimension(:), allocatable :: nums
  real :: media_nums=0., media_positiva=0., media_negativa=0.

  write (*,*) "Quantidade de numeros:"
  read (*,*) qnt

  allocate (nums(qnt))

  write (*,*) "Numeros:"
  read (*,*) nums

  if (qnt > 0) media_nums = sum(nums)/qnt

! medias dos numeros positivos e negativos
  if (count(nums > 0.) > 0) media_positiva = sum(nums, nums > 0.) &
        /count(nums > 0.)
  if (count(nums < 0.) > 0) media_negativa = sum(nums, nums < 0.) &
        /count(nums < 0.)

  deallocate (nums)

! Print do resultado no terminal
  write (*,'(''Media = '', 1g12.4)') media_nums
  write (*,'(''Media dos numeros positivos = '', 1g12.4)') media_positiva
  write (*,'(''Media dos numeros negativos = '', 1g12.4)') media_negativa

end program media
```

#### Em Java

```
import java.util.Scanner;
class Media{
	public static void main(String[] args) {
		Scanner in= new Scanner(System.in); 
		System.out.print("Quantidade de numeros:");
		final int qnt= in.nextInt();;
		System.out.println("Numeros:");
		double[] nums = new double[qnt];
		double media = 0, media_positiva=0, media_negativa=0;
		int count_neg = 0, count_pos=0;
		double soma = 0;
		for (int i = 0; i < qnt; i++) {
			nums[i] = in.nextDouble();
			if(nums[i] > 0) count_pos++;
			if(nums[i] < 0) count_neg++;
			soma += nums[i];
		}
    
    if (qnt > 0) media = soma / qnt;
    if (count_pos > 0) {
	double soma_pos = 0;
    	for (int i = 0; i < qnt; i++) {
		if(nums[i] > 0) soma_pos = soma_pos + nums[i];
	}
	media_positiva = soma_pos/count_pos;
    }
    if (count_neg > 0) {
	double soma_neg = 0;
    	for (int i = 0; i < qnt; i++) {
		if(nums[i] < 0) soma_neg = soma_neg + nums[i];
	}
	media_negativa = soma_neg/count_neg;
    }
    System.out.println("");
    System.out.println("Media = " + media);
    System.out.println("Media dos numeros positivos = " + media_positiva);
    System.out.println("Media dos numeros negativos = " + media_negativa);
	}
}
```
