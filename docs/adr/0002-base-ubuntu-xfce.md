# ADR-0002: Base Ubuntu 26.04 LTS + Xfce 4.20

## Status

**Status**: Aceito
**Data**: 2026-11-14
**Tipo**: Técnica
**Substitui**: [ADR-0001](0001-build-system.md) (parte "base do sistema")

## Contexto

O ADR-0001 escolheu Buildroot para construir o sistema do zero. Depois surgiu um plano Debian + mkosi + labwc e, por fim, o objetivo de um desktop leve, compatível com hardware comum e simples de manter por uma pessoa. Três arquiteturas coexistiam (problema A2 da [proposta de arquitetura](../architecture/proposta-arquitetura-ubuntu.md)).

Fatos do ciclo atual:

- Ubuntu 26.04 LTS "Resolute Raccoon" saiu em 23/04/2026 com kernel Linux 7.0.
- O Ubuntu Desktop (GNOME 50) recomenda 6 GB de RAM e removeu a sessão Xorg.
- Xfce 4.20 está em `universe`; o sabor Xubuntu tem suporte de 3 anos (até 04/2029). Existe a ISO Xubuntu Minimal, sem snaps.
- No Xfce 4.20, Wayland é experimental e o xfwm4 é só X11.
- LXQt 2.3 (Lubuntu) também roda em X11 neste ciclo; a loja natural (Discover) traz bibliotecas KDE.

## Fatores de decisão

- Compatibilidade de hardware sem trabalho próprio (kernel, firmware, drivers)
- Secure Boot sem chaves próprias
- Consumo baixo de RAM e CPU em repouso
- Coesão com os aplicativos essenciais (Firefox, LibreOffice: GTK)
- Esforço de manutenção para um mantenedor
- Ciclo de suporte longo e previsível

## Opções consideradas

| Opção | Prós | Contras |
|---|---|---|
| Ubuntu Desktop (GNOME) | Suporte máximo | Pesado (6 GB recomendados); fora do objetivo |
| Xubuntu Desktop | Pronto | Snaps integrados; seleção alheia |
| **Ubuntu mínimo + Xfce curado** | Seleção total; sem fork; boot assinado intacto | Manutenção de seeds, metapacotes e configs |
| Ubuntu mínimo + LXQt | Possivelmente um pouco mais leve | Mistura Qt + GTK; Discover puxa KDE |
| Debian 13 + desktop leve | Comunidade, sem snap | Hardware mais novo exige backports; sem PPA |
| Buildroot / do zero (ADR-0001) | Controle total | Kernel, drivers, Secure Boot e desktop por conta própria |

## Decisão

BastiaOS é construído sobre **Ubuntu 26.04 LTS** (`main` + `universe`), com kernel `linux-generic-hwe-26.04`, e usa **Xfce 4.20 em sessão X11** com LightDM e o greeter GTK. Os pacotes do Ubuntu e do Xfce não são modificados; o que é próprio do BastiaOS vive em pacotes `bastia-*` (ver [ADR-0008](0008-repositorio-ppa.md)).

## Justificativa

- Kernel, firmware, shim e GRUB assinados vêm prontos da Canonical.
- Xfce é maduro, coeso com aplicativos GTK e tem baseline mensurável (Xubuntu Minimal).
- Nada de fork: o trabalho do projeto fica na seleção, na configuração e na integração.

## Consequências

### Positivas
- Hardware amplo e Secure Boot desde a primeira ISO.
- Atualizações de segurança do Ubuntu sem esforço próprio.

### Negativas
- Xfce em `universe` limita o suporte a 3 anos ([ADR-0007](0007-versionamento-e-suporte.md)).
- Sem Wayland durante o ciclo 26.04.
- Dependência das decisões da Canonical (snap, instalador), tratada nos ADRs 0004 e 0005.

## Comparação com as distribuições de referência

| Aspecto | Ubuntu | Debian | Fedora | Arch | NixOS | Gentoo | BastiaOS |
|---|---|---|---|---|---|---|---|
| Modelo | LTS 2 anos | Estável ~2 anos | Semestral | Rolling | Semestral | Rolling | **LTS do Ubuntu** |
| Desktop padrão | GNOME | Escolha no instalador | GNOME (spins: Xfce, KDE…) | Nenhum | Escolha | Nenhum | **Xfce** |
| Kernel | Assinado pela Canonical | Assinado pelo Debian | Assinado pela Fedora | Vanilla-ish, sem assinatura | Configurável | Compilado pelo usuário | **HWE do Ubuntu, assinado** |
| Esforço de hardware | Baixo | Médio (firmware/backports) | Baixo | Médio | Médio | Alto | **Baixo** |

## Critério de revisão

- Reabrir se, no laboratório de baseline, a RAM em repouso do Lubuntu for **mais de 25% menor** que a do Xubuntu Minimal na mesma VM.
- Reabrir a sessão gráfica (Wayland) quando o compositor `xfwl4` estiver utilizável e empacotado.
- Reabrir a base antes do rebase para 28.04 LTS.

## Referências

- [Proposta de arquitetura](../architecture/proposta-arquitetura-ubuntu.md), Partes 1 e 2
- [Ubuntu release cycle](https://ubuntu.com/about/release-cycle)
- [Xfce](https://www.xfce.org/)

## Histórico de revisões

- v1.0 — Decisão inicial (2026-11-14)
