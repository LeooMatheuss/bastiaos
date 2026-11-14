# ADR-0007: Versionamento e janela de suporte

## Status

**Status**: Aceito
**Data**: 2026-11-14
**Tipo**: Processo / Produto

## Contexto

O BastiaOS herda dois prazos diferentes do Ubuntu 26.04 LTS:

- Pacotes de `main` (kernel, systemd, bibliotecas base): suporte padrão de 5 anos, até 04/2031.
- Xfce, em `universe`: o sabor Xubuntu garante 3 anos, até **04/2029**.

O próximo LTS (28.04) está previsto para abril de 2028. O Ubuntu costuma liberar a atualização entre LTS a partir do primeiro point release (`.1`). O projeto precisa de um esquema de versão que comunique estabilidade e base de forma clara.

## Fatores de decisão

- Versão legível por pessoas e por ferramentas (tags, `os-release`)
- Relação clara entre versão do BastiaOS e base Ubuntu
- Prazo de suporte honesto, limitado pelo componente de suporte mais curto
- Tempo de sobreposição para migrar entre bases

## Opções consideradas

| Opção | Prós | Contras |
|---|---|---|
| Mesmo número do Ubuntu (26.04) | Base óbvia | Confunde com o Ubuntu; não expressa releases próprias |
| Data (2026.11) | Simples | Não diz se houve mudança de base |
| **SemVer: MAJOR = base Ubuntu, MINOR = release, PATCH = correção** | Base e compatibilidade explícitas | Precisa de regra escrita |

## Decisão

### Esquema de versão

- Formato **`MAJOR.MINOR.PATCH`** ([SemVer](https://semver.org/)), com sufixos de pré-release `-rc.N` e `-beta.N`.
- **MAJOR** muda só com troca de base: **1.x = Ubuntu 26.04**, **2.x = Ubuntu 28.04**.
- **MINOR**: nova ISO com mudança de seleção de pacotes, configuração ou funcionalidade.
- **PATCH**: correções e atualizações de segurança sem mudança de funcionalidade.
- Antes da 1.0, as releases usam **0.MINOR.PATCH**; o MINOR não tem relação fixa com a numeração das etapas do roadmap.
- Tags Git assinadas: `vMAJOR.MINOR.PATCH[-pre]` (ex.: `v0.9.0-rc.1`, `v1.0.0`).
- Codinome por base: **"Muralha"** para toda a série sobre 26.04 (0.x e 1.x).

### Identificação no sistema (`/etc/os-release`)

```
NAME="BastiaOS"
ID=bastiaos
ID_LIKE="ubuntu debian"
VERSION_ID="1.0"
VERSION_CODENAME=muralha
UBUNTU_CODENAME=resolute
```

`UBUNTU_CODENAME` mantém PPAs e repositórios de terceiros funcionando, como fazem outros derivados do Ubuntu.

### Janela de suporte

| Série | Base | Suporte | Observação |
|---|---|---|---|
| 1.x "Muralha" | Ubuntu 26.04 LTS | até **04/2029** | Limitado pelo Xfce em `universe` |
| 2.x | Ubuntu 28.04 LTS | a definir em ADR próprio | Lançada após o `28.04.1` |

Entre o lançamento da 2.0 e o fim da 1.x há sobreposição mínima de 6 meses, com caminho de atualização documentado.

## Justificativa

O MAJOR atrelado à base comunica de imediato o que muda de verdade para o usuário (kernel, bibliotecas, versão do Xfce). O prazo de suporte segue o componente mais curto, para não prometer o que o Ubuntu não garante.

## Consequências

### Positivas
- Usuários sabem pela versão qual é a base e até quando terão suporte.
- Ferramentas de terceiros reconhecem o sistema como derivado do Ubuntu.

### Negativas
- O rebase para 28.04 é obrigatório antes de 04/2029.
- Correções no Xfce dependem do fluxo de `universe`.

## Comparação com as distribuições de referência

| | Ubuntu | Debian | Fedora | Arch | NixOS | Gentoo | BastiaOS |
|---|---|---|---|---|---|---|---|
| Esquema | AA.MM | Número inteiro + point releases | Número inteiro | Rolling (ISO mensal por data) | AA.MM | Rolling | **SemVer, MAJOR = base** |
| Cadência | Semestral; LTS a cada 2 anos | ~2 anos | ~6 meses | Contínua | Semestral | Contínua | **MINOR conforme necessário** |
| Suporte | LTS: 5 anos padrão | ~3 anos + LTS | ~13 meses | Sem versões | ~7 meses | Sem versões | **Até 04/2029 (1.x)** |

## Critério de revisão

- Reabrir se o Xfce passar a ter suporte de 5 anos no 26.04 (por exemplo, migração para `main`).
- Reabrir no planejamento do rebase para 28.04, para definir o suporte da 2.x.

## Referências

- [Ubuntu release cycle](https://ubuntu.com/about/release-cycle)
- [Semantic Versioning 2.0.0](https://semver.org/)
- [os-release](https://www.freedesktop.org/software/systemd/man/latest/os-release.html)

## Histórico de revisões

- v1.0 — Decisão inicial (2026-11-14)
