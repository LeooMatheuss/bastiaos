# ADR-0008: Repositório próprio em Launchpad PPA

## Status

**Status**: Aceito
**Data**: 2026-11-14
**Tipo**: Técnica / Infraestrutura

## Contexto

Toda configuração e seleção do BastiaOS nasce como pacote `.deb` (`bastia-base`, `bastia-desktop`, `bastia-desktop-settings`, `bastia-artwork`, `bastia-devsetup`, `bastia-calamares-settings`), para poder ser atualizada via APT sem reinstalar o sistema. Esses pacotes precisam de um repositório APT assinado, confiável e de baixo custo de operação.

## Fatores de decisão

- Assinatura do repositório e confiança do APT
- Builds limpos e reproduzíveis a partir do código-fonte
- Custo e esforço de operação para um mantenedor
- Integração com ferramentas padrão do Ubuntu (`add-apt-repository`)
- Possibilidade de sair da plataforma no futuro

## Opções consideradas

| Opção | Prós | Contras |
|---|---|---|
| **Launchpad PPA** | Gratuito; builda a partir do pacote-fonte em builders limpos; assina automaticamente; `ppa:` integrado ao Ubuntu | A chave de assinatura é gerada e guardada pelo Launchpad; só séries do Ubuntu |
| aptly autohospedado | Chave e infraestrutura próprias | Hospedagem, builders e custódia de chaves por conta própria |
| GitHub Pages / releases como repositório APT | Gratuito | Build e assinatura manuais; sem builders limpos |
| Open Build Service (openSUSE) | Multi-distro | Menos usado no ecossistema Ubuntu |

## Decisão

- Pacotes próprios publicados em um **PPA no Launchpad** (`ppa:<equipe>/bastiaos`), com um PPA separado para testes (`bastiaos-testing`).
- Só **pacotes-fonte** assinados pelo mantenedor são enviados (`debuild -S` + `dput`); o Launchpad builda e assina os binários.
- A fonte do PPA é instalada pelo `bastia-base` com `signed-by` e a chave do PPA em `/usr/share/keyrings/`.
- O código dos pacotes vive neste repositório em `packages/`; o PPA é só o canal de distribuição.

## Justificativa

O PPA resolve build limpo, assinatura e hospedagem sem custo e sem infraestrutura própria, que é o gargalo de um projeto de uma pessoa. Como a fonte dos pacotes fica no Git, a migração para outro repositório exige apenas mudar a origem no `bastia-base`.

## Consequências

### Positivas
- Repositório assinado desde o primeiro pacote.
- Builds feitos fora da máquina do mantenedor.

### Negativas
- Exige conta no Launchpad, chave GPG do mantenedor registrada e a assinatura do Código de Conduta do Ubuntu.
- A chave de assinatura do repositório pertence ao Launchpad, não ao projeto.
- Dependência de disponibilidade do Launchpad para publicar.

## Comparação com as distribuições de referência

| | Ubuntu | Debian | Fedora | Arch | NixOS | Gentoo | BastiaOS |
|---|---|---|---|---|---|---|---|
| Repositório de terceiros | PPA (Launchpad) | Repositórios próprios (sem serviço oficial) | COPR | AUR (receitas, sem binários) | Flakes / caches binários | Overlays (ebuilds) | **PPA (Launchpad)** |
| Quem builda | Launchpad | O próprio terceiro | COPR | O usuário | Nix / cache | O usuário | **Launchpad** |

## Critério de revisão

- Reabrir se o Launchpad descontinuar PPAs públicos gratuitos ou deixar de suportar a série 26.04.
- Reabrir se o projeto precisar de chave de assinatura sob controle próprio (por exemplo, para assinar a release completa com a mesma chave); alternativa: aptly autohospedado.
- Reabrir se for necessário suportar uma base não Ubuntu.

## Referências

- [Launchpad PPAs](https://help.launchpad.net/Packaging/PPA)
- [Proposta de arquitetura](../architecture/proposta-arquitetura-ubuntu.md), seção 2.5

## Histórico de revisões

- v1.0 — Decisão inicial (2026-11-14)
