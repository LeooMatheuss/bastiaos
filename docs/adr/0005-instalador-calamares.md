# ADR-0005: Instalador Calamares

## Status

**Status**: Aceito
**Data**: 2026-11-14
**Tipo**: Técnica

## Contexto

Os sabores do Ubuntu migraram para o instalador Flutter/subiquity da Canonical, distribuído como snap. Isso contradiz o [ADR-0004](0004-politica-snap-flatpak.md) (sem snapd pré-instalado). O Lubuntu continua usando o **Calamares**, que está no archive Ubuntu e não depende de snap.

## Fatores de decisão

- Não depender de snap na ISO
- Maturidade no Ubuntu e suporte a UEFI, Secure Boot, BIOS e LUKS2
- Configuração declarativa e versionável
- Possibilidade de instalação automatizada em VM para testes

## Opções consideradas

| Opção | Prós | Contras |
|---|---|---|
| Instalador oficial (Flutter + subiquity) | Mesmo do Ubuntu | Distribuído como snap; personalização limitada |
| **Calamares** | No archive; usado pelo Lubuntu; modular; configuração em YAML | Interface Qt numa ISO Xfce (GTK) |
| Instalador próprio (systemd-repart / script) | Controle total | Muito trabalho e risco de destruir discos |
| Ubiquity | Conhecido | Descontinuado no Ubuntu |

## Decisão

O BastiaOS usa o **Calamares**, com o pacote próprio `bastia-calamares-settings` derivado de `calamares-settings-lubuntu`. Módulos previstos: idioma (pt-BR padrão), fuso, teclado, particionamento (ext4 padrão; LUKS2 opcional), usuários, remoção dos pacotes live e bootloader (shim/GRUB assinados). O filesystem padrão continua ext4; Btrfs com snapshots fica para depois da beta.

## Justificativa

É a única opção madura, já integrada ao Ubuntu e livre de snap. Partir da configuração do Lubuntu reduz o trabalho a ajustes, sem escrever um instalador.

## Consequências

### Positivas
- Instalação gráfica simples sem snap.
- Configuração versionada no repositório, testável em VM.

### Negativas
- Bibliotecas Qt na ISO live (removidas do sistema instalado).
- Mudanças do Lubuntu nos settings precisam ser acompanhadas.

## Comparação com as distribuições de referência

| | Ubuntu | Debian | Fedora | Arch | NixOS | Gentoo | BastiaOS |
|---|---|---|---|---|---|---|---|
| Instalador | Flutter + subiquity | debian-installer; Calamares nas ISOs live | Anaconda | archinstall (texto) | Calamares (ISO gráfica) | Manual (Handbook) | **Calamares** |

## Critério de revisão

- Reabrir se o Calamares for removido do archive do Ubuntu ou deixar de suportar Secure Boot com shim.
- Reabrir se a Canonical oferecer o instalador oficial como `.deb`, sem snap.
- Antes de derivar `calamares-settings-lubuntu`, conferir a licença dele (compatível com o [ADR-0006](0006-licenca.md)).

## Referências

- [Calamares](https://calamares.io/)
- [Proposta de arquitetura](../architecture/proposta-arquitetura-ubuntu.md), seções 2.1 e 2.5

## Histórico de revisões

- v1.0 — Decisão inicial (2026-11-14)
