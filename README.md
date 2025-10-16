![Celestia Logo](https://github.com/antth-Luca/godot-Celestia/blob/alpha/logo.png)

# Repositório: godot-Celestia

Este repositório abriga o jogo Celestia, um top-down de sobrevivênca, rico em história e mecânicas. Desenvolvido por [@antthLuca](https://github.com/antth-Luca) na engine [Godot](https://github.com/godotengine/godot) desde 25 de julho de 2025.

## Licença

- [Licença personalizada - PT-BR](https://github.com/antth-Luca/godot-Celestia/blob/main/LICENSE-pt-br)
- [Custom license - EN-US](https://github.com/antth-Luca/godot-Celestia/blob/main/LICENSE)

## Versões:

| Versão         | Título                 | Situação         | Início desenv. | Fim desenv. |
| -------------- | ---------------------- | ---------------- | -------------- | ----------- |
| v1.25-alpha    | Alpha                  | Desenvolvendo ⏳ | 04/10/25       | -           |
| v1.25-beta     | Beta                   | Planejada 📅     | -              | -           |
| v1.25.1.1      | Ato 1 (este é **MVP**) | Planejada 📅     | -              | -           |
| v1.25.1.2      | Novos horizontes       | Planejada 📅     | -              | -           |
| v1.25.1.3      | Vamos ao combate!      | Planejada 📅     | -              | -           |
| v1.25.1.4      | MagEra                 | Planejada 📅     | -              | -           |
| v1.25.1.5      | Cozinheiros a postos!  | Planejada 📅     | -              | -           |
| v1.25.1.6      | Festeiro               | Planejada 📅     | -              | -           |
| v1.25.2.1      | Ato 2                  | Planejando... 📅 | -              | -           |
| v1.25-prealpha | Pré-alpha              | Concluída ✅     | 25/07/25       | 04/10/25    |

> [!NOTE]
> Estou muito entusiasmado em desenvolver Celestia, mas jogos não são o meu trabalho! Novas features virão conforme meu tempo disponível permitir o desenvolvimento.

### Recursos:

#### Alpha

- [ ] Sistema de encantamentos para itens;
- [ ] Sistema de relíquias (atributos e passivas únicas);
- [ ] Sistema de cultivo;
- [ ] Adição de efeitos sonoros;
- [ ] Primeiro chefe/boss;
- [ ] Sistema de eventos históricos;
- [ ] Sistema de dimensões: adição das Cavernas;
- [x] Mudanças no dano a estruturas:
  - [x] Dano por Hit comum;
  - [x] Verificação de tipo de ferramenta e nível de material.
- [x] Mudança no uso e interação de itens e estruturas;
- [x] Item de combate à distância: Arco;
- [x] Movimento de rolagem do Jogador/Player;
- [x] Sistema de efeitos para entidades.

#### Beta

- [ ] Correções:
  - [ ] O resultado em preview do OutPut não é removido se os ingredientes são alterados e uma receita não é encontrada;
  - [ ] Os managers de crafting buscam exatamente a receita pelo tipo de workstation e não consideram níveis, como CLAY_FURNACE e STONE_FURNACE;
  - [ ] Os cliques 'middle' e 'left' não funcionam no inventário, se o Tooltip estiver aberto;
  - [ ] Os botões de aba no MyPanel não funcionam após a primeira vez;
  - [x] Bolso rotativo pula posições se girar antes de coletar algum item.
- [ ] Melhorias:
  - [ ] Botões do menu de pause com TextureButton.
- [ ] Sistema de nível de sobrevivente;
- [ ] Sistema de coleção de itens;
- [ ] Sistema de conquistas;
- [ ] Configurações de mundo;
- [ ] Sistema de biomas;
- [ ] Geração procedural de mundo;
- [ ] Nascimento natural de entidades (levando o bioma em consideração);
- [ ] Cliente/menu do jogo;
- [ ] Configurações do jogo;
- [ ] Salvar mundo e retormar;
- [ ] Carregamento de addons/mods (a se decidir o nível de modificação).

#### Ato 1

- [ ] Melhorias:
  - [ ] Adição: Cliques duplos de 'left' e 'right' no inventário;
  - [ ] Adição: O ícone da aba de crafting muda de acordo com a estrutura usada para abrir;
  - [ ] Adição: Tentar usar uma armadura ou relíquia fará a troca dela com a já equipada;
  - [ ] Adição: Sombras a todas as entidades (como component);
  - [ ] Adição: Animação de "pingar" nos itens dropados no chão;
  - [ ] Adição: Partículas de poeira as entidades ao andar;
  - [ ] Adição: Representação do dano em números flutuantes;
  - [ ] Alteração: Sprite de terrenos mais orgânicos;
  - [ ] Adicionar sobreposição de sprites dinâmica, simulando profundidade;
  - [ ] Alteração: Animação pré-mundo (versão 2);
  - [x] Adição: Contorno branco aos itens dropados no chão;
  - [x] Adição: Brilho branco aos itens dropados no chão.
- [ ] Adição de todo o conteúdo possível com os sistemas desenvolvidos até aqui;
- [ ] Multiplayer em LAN.

#### Novos horizontes

- [ ] Novos biomas;
- [ ] Novos animais;
- [ ] Novos itens: "Tijolo da Ruína", "Eruptite";
- [ ] Nova comida: "Mel Lilás";
- [ ] Novas estruturas: "Colméia Lilás", "Ruína de Templo Celério";
- [ ] Nascimento de estruturas (com baús considerando LootTables);
- [ ] Partícula noturna: Vagalumes.

#### Vamos ao combate!

- [ ] Novas munições;
- [ ] Novas armas;
- [ ] Novos itens de defesa;
- [ ] Novos materiais para armaduras;
- [ ] NPC comerciante e moedas;

#### MagEra

- [ ] Sistema de mana;
- [ ] Pedras preciosas nas cavernas;
- [ ] Cajados mágicos para combate;
- [ ] Novos inimigos mágicos;
- [ ] Novas plantas;
- [ ] Nova relíquia lendária;
- [ ] Novas armas mágicas.

#### Cozinheiros a postos!

- [ ] Novos animais mágicos;
- [ ] Nova estrutura: "Viveiro de lesma";
- [ ] Novas receitas de comidas.

#### Festeiro

- [ ] Novos NPC’s companheiros: "Anin", "Golem Vitrola", "Balle";
- [ ] Novas estruturas decorativas: "Banner", "Estátua";
- [ ] Novo cliente/inicializador do jogo;
- [ ] Contas pessoais;

#### Ato 2

- [ ] Novo bioma: "Bioma Corrupto";
- [ ] Novo inimigo: "Balão de Corrupção";
- [ ] Novo material para armadura;
- 📅 Planejando...

#### Pré-alpha

- [x] Cena do Jogador/Player;
- [x] Sistema de tradução;
- [x] Inventário do Jogador/Player;
- [x] Itens dropados no chão;
- [x] Sistema de registro de conteúdo;
- [x] Sistema de Properties (usado nos atributos/stats de entidades);
- [x] Sistema de Components para entidades;
- [x] Primeira entidade-monstro: Zumbi/Zombie;
- [x] HUD do jogador;
- [x] Sistema de dano;
- [x] Pausa de mundo/jogo;
- [x] Sistema de ressurreição do Player;
- [x] Animação pré-mundo (versão 1);
- [x] Sistema de tempo (dia e noite);
- [x] Estrutura de cama;
- [x] Sistema de fome;
- [x] Sistema de LootTables (drop de entidades);
- [x] Sistema de fabricação;
- [x] Sistema de receitas.
