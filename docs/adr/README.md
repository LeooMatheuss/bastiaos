# Architecture Decision Records (ADRs)

Registro das decisões estruturais do BastiaOS: contexto, opções consideradas, decisão, consequências e quando reabrir. Nenhuma decisão estrutural entra no projeto sem um ADR aceito.

## Índice

| ADR | Título | Status | Data |
|---|---|---|---|
| [0001](0001-build-system.md) | Build System Selection (Buildroot) | Substituído por 0002 e 0003 | 2026-09-22 |
| [0002](0002-base-ubuntu-xfce.md) | Base Ubuntu 26.04 LTS + Xfce 4.20 | Aceito | 2026-11-14 |
| [0003](0003-pipeline-de-build.md) | Pipeline de build (mmdebstrap + snapshot + casper + xorriso) | Aceito | 2026-11-14 |
| [0004](0004-politica-snap-flatpak.md) | Política de snap e Flatpak | Aceito | 2026-11-14 |
| [0005](0005-instalador-calamares.md) | Instalador Calamares | Aceito | 2026-11-14 |
| [0006](0006-licenca.md) | Licença | Aceito | 2026-11-14 |
| [0007](0007-versionamento-e-suporte.md) | Versionamento e janela de suporte | Aceito | 2026-11-14 |
| [0008](0008-repositorio-ppa.md) | Repositório próprio em Launchpad PPA | Aceito | 2026-11-14 |

## Ciclo de vida

| Status | Significado |
|---|---|
| Proposto | Rascunho em discussão |
| Aceito | Decisão em vigor |
| Obsoleto | Não se aplica mais, sem substituto |
| Substituído | Trocado por outro ADR (indicado no cabeçalho) |

Um ADR aceito não é reescrito: mudanças de decisão geram um novo ADR que o substitui. Correções menores entram no histórico de revisões.

## Numeração e nome do arquivo

`NNNN-titulo-curto.md`, com numeração sequencial de quatro dígitos.

## Template

```markdown
# ADR-NNNN: Título

## Status

**Status**: Proposto | Aceito | Obsoleto | Substituído por ADR-XXXX
**Data**: AAAA-MM-DD
**Tipo**: Técnica | Processo | Produto | Jurídica

## Contexto
Problema e fatos que motivam a decisão.

## Fatores de decisão
- Critérios usados para comparar as opções

## Opções consideradas
| Opção | Prós | Contras |
|---|---|---|

## Decisão
O que foi decidido, de forma verificável.

## Justificativa
Por que esta opção, e não as outras.

## Consequências
### Positivas
### Negativas

## Comparação com as distribuições de referência
| | Ubuntu | Debian | Fedora | Arch | NixOS | Gentoo | BastiaOS |
|---|---|---|---|---|---|---|---|

## Critério de revisão
Condições objetivas que reabrem a decisão.

## Referências

## Histórico de revisões
- v1.0 — Decisão inicial (AAAA-MM-DD)
```

## Como propor uma decisão

1. Copie o template para um novo arquivo com o próximo número.
2. Abra com status **Proposto** e discuta.
3. Mude para **Aceito** quando a decisão for tomada, no mesmo commit que atualiza este índice.
4. Referencie o ADR na documentação e no código afetados.
