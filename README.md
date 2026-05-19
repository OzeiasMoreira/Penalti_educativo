# Penalti Educativo

## Visao geral

**Penalti Educativo** e um jogo digital desenvolvido em Godot que combina a dinamica ludica de cobrancas de penalti com atividades de alfabetizacao. O jogador observa uma imagem, identifica a palavra representada e escolhe a silaba inicial correta para completar essa palavra. Ao selecionar a resposta, a bola e chutada em direcao ao gol: se a silaba estiver correta, o jogador marca; se estiver incorreta, o goleiro defende e a crianca pode tentar novamente.

O projeto foi pensado como uma experiencia curta, visual e interativa para apoiar criancas em processo de alfabetizacao, especialmente no reconhecimento de silabas, associacao entre imagem e palavra, consciencia fonologica e leitura inicial.

## Objetivo do projeto

O objetivo principal e oferecer um recurso pedagogico gamificado que auxilie o estudante a:

- reconhecer a silaba inicial de palavras simples;
- relacionar imagem, som mental da palavra e escrita;
- formar palavras por meio de escolhas guiadas;
- receber feedback imediato sobre acertos e erros;
- manter-se motivado por meio de uma narrativa esportiva familiar e divertida.

## Publico-alvo

O jogo e indicado para criancas em fase inicial de alfabetizacao, principalmente nos anos iniciais do Ensino Fundamental, podendo tambem ser usado como recurso de apoio em atividades de reforco, atendimento individualizado, salas de recursos ou praticas pedagogicas mediadas por tecnologia.

## Como funciona

1. O jogo inicia com uma introducao em video.
2. O menu permite iniciar a partida, acessar o tutorial ou sair.
3. No tutorial, o estudante recebe orientacoes visuais sobre a mecanica do jogo.
4. Na fase principal, uma imagem e uma palavra incompleta sao exibidas.
5. O estudante escolhe entre quatro silabas possiveis.
6. A bola e chutada para uma regiao do gol associada a opcao escolhida.
7. Em caso de acerto, o jogo mostra uma mensagem positiva, toca som de gol e soma ponto.
8. Em caso de erro, o goleiro defende, o jogo mostra feedback de tentativa e soma erro no placar.
9. Apos o acerto, o jogo avanca para a proxima palavra.

## Conteudos trabalhados

O jogo trabalha, de forma integrada:

- silabas simples;
- formacao de palavras;
- leitura de palavras familiares;
- associacao imagem-palavra;
- percepcao da posicao da silaba na palavra;
- tomada de decisao com base em pistas visuais e textuais;
- persistencia diante do erro.

Atualmente, as fases principais usam palavras como **BOLA**, **CASA** e **PATO**, apresentando a parte final da palavra e pedindo que o estudante escolha a silaba inicial correta.

## Contribuicoes pedagogicas

O **Penalti Educativo** contribui pedagogicamente porque transforma um exercicio de alfabetizacao em uma situacao de jogo com objetivo claro, feedback rapido e envolvimento emocional. Em vez de apenas completar palavras em uma folha, a crianca participa de uma acao concreta: escolher uma silaba para realizar um chute.

Entre as principais contribuicoes estao:

- **Aprendizagem ativa:** o estudante precisa observar, comparar, escolher e testar sua resposta.
- **Feedback imediato:** o jogo informa rapidamente se a escolha foi adequada, favorecendo a correcao de rota.
- **Gamificacao do erro:** o erro nao encerra a atividade; ele aparece como uma defesa do goleiro e convida a nova tentativa.
- **Associacao multimodal:** imagem, palavra incompleta, movimento da bola, sons e placar reforcam o conteudo por diferentes canais.
- **Motivacao e engajamento:** a tematica do futebol aproxima a atividade de um universo ludico e culturalmente reconhecivel.
- **Autonomia:** o tutorial e a interface simples ajudam a crianca a compreender a tarefa com menor dependencia de instrucoes externas.
- **Acompanhamento simples:** o placar de gols e erros permite ao professor observar desempenho, persistencia e necessidade de intervencao.

Para uma descricao mais detalhada, consulte [docs/CONTRIBUICOES_PEDAGOGICAS.md](docs/CONTRIBUICOES_PEDAGOGICAS.md).

## Estrutura do projeto

```text
penalti-educativo/
+-- assets/              # Imagens, icones e sons usados no jogo
+-- intro/               # Video de introducao
+-- scenes/              # Cenas Godot: intro, menu, tutorial, jogo e componentes
+-- scripts/             # Scripts GDScript com a logica do jogo
+-- project.godot        # Configuracao principal do projeto Godot
+-- README.md            # Documentacao geral
```

## Principais cenas

- `scenes/Intro.tscn`: executa o video de abertura e direciona para o menu.
- `scenes/Menu.tscn`: tela inicial com opcoes de jogar, tutorial e sair.
- `scenes/Tutorial.tscn`: explica visualmente como jogar.
- `scenes/Main.tscn`: cena principal da atividade pedagogica.
- `scenes/AudioManager.tscn`: gerencia musicas, efeitos sonoros, volume e botao de retorno ao menu.

## Principais scripts

- `scripts/main.gd`: controla as fases, silabas, respostas, placar e feedback de acerto/erro.
- `scripts/tutorial.gd`: organiza os passos do tutorial.
- `scripts/menu.gd`: controla a navegacao do menu.
- `scripts/AudioManager.gd`: centraliza sons, musica e controle de volume.
- `scripts/bola.gd`: anima o chute e o retorno da bola.
- `scripts/jogador.gd`: anima o movimento de chute do jogador.
- `scripts/goleiro.gd`: movimenta o goleiro quando a resposta esta incorreta.
- `scripts/intro.gd`: troca para o menu ao final do video de introducao.

## Recursos de acessibilidade e usabilidade

O projeto ja inclui elementos importantes para uma experiencia mais amigavel:

- tutorial antes da atividade principal;
- imagens grandes para apoiar a leitura;
- botoes com silabas em destaque;
- feedback visual de acerto e erro;
- efeitos sonoros que reforcam as acoes;
- controle de volume e opcao de mudo;
- retorno ao menu durante a experiencia.

Como melhorias futuras, podem ser adicionados recursos como leitura em voz alta das palavras, escolha de nivel de dificuldade, fonte ampliada configuravel, contraste alternativo e registro de desempenho por estudante.

## Como executar

1. Instale o Godot 4.x.
2. Abra o Godot.
3. Selecione **Importar** e escolha o arquivo `project.godot`.
4. Abra o projeto.
5. Execute a cena principal do projeto.

A cena inicial configurada e `res://scenes/Intro.tscn`.

## Possibilidades de expansao

O jogo pode ser ampliado pedagogicamente com:

- novas palavras organizadas por nivel de dificuldade;
- familias silabicas especificas;
- modo de revisao para palavras com mais erros;
- banco de imagens tematico;
- narracao das instrucoes;
- relatorio simples para o professor;
- fases com silaba final, silaba medial ou formacao completa da palavra;
- progressao por unidades didaticas.

## Consideracoes finais

O **Penalti Educativo** demonstra como um jogo simples pode apoiar objetivos de alfabetizacao quando suas mecanicas estao alinhadas ao conteudo pedagogico. A escolha da silaba nao e apenas um clique: ela aciona uma consequencia visual, sonora e narrativa, tornando a aprendizagem mais significativa, participativa e memoravel.
