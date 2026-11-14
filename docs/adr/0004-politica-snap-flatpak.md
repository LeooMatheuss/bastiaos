# ADR-0004: Política de snap e Flatpak

## Status

**Status**: Aceito
**Data**: 2026-11-14
**Tipo**: Técnica / Produto

## Contexto

No Ubuntu 26.04, Firefox, Thunderbird e Chromium do archive são **pacotes de transição**: o `apt install` instala o `snapd` e baixa o snap sem aviso. O Xubuntu Desktop ainda traz Firefox e a loja em snap. Snaps aumentam o uso de disco e de RAM e criam montagens loop no boot. Ao mesmo tempo, retirar a opção de snap restringe o usuário.

O objetivo do BastiaOS é **liberdade sem surpresa**.

## Fatores de decisão

- Nada instalado silenciosamente
- Consumo de disco e RAM e tempo de boot
- Acesso a um catálogo amplo de aplicativos
- Liberdade do usuário para escolher outro formato
- Atualizações do navegador rápidas e confiáveis

## Opções consideradas

| Opção | Prós | Contras |
|---|---|---|
| Snap incluído (padrão Ubuntu) | Zero trabalho | Contraria o objetivo de leveza; instalação silenciosa |
| Bloqueio total do snapd (modelo Mint) | Nenhuma surpresa | Restringe o usuário |
| **Sem snapd pré-instalado; pins só nos pacotes de transição** | Nenhuma surpresa e escolha preservada | Precisa manter pins e a fonte APT da Mozilla |
| Flatpak como único formato de aplicativos | Simples | IDEs e ferramentas de desenvolvimento sofrem com o sandbox |

## Decisão

1. **`snapd` não é pré-instalado** e não é bloqueado: `sudo apt install snapd` continua funcionando.
2. Os pacotes de transição do archive Ubuntu (`firefox`, `thunderbird`, `chromium-browser`) recebem **pin `-1`** com origem no Ubuntu, para não instalarem snap sem consentimento.
3. **Firefox** vem como `.deb` do repositório APT oficial da Mozilla, com chave dedicada (`signed-by`) e **pin 1000**. O canal (rapid-release × ESR) é validado ao empacotar o `bastia-base`, antes de ser fixado.
4. **Flatpak + Flathub** ficam ativos por padrão. A loja é o GNOME Software com `gnome-software-plugin-flatpak` e **sem** plugin snap.
5. Aplicativos do sistema e ferramentas de desenvolvimento continuam via APT.

## Justificativa

O problema real é a instalação silenciosa, não a existência do snap. Bloquear só o caminho silencioso resolve o problema sem limitar quem quer usar snap. O Flathub oferece o maior catálogo de aplicativos de desktop fora do archive.

## Consequências

### Positivas
- Boot sem montagens loop de snap; menos RAM e disco.
- O usuário mantém as três opções: APT, Flatpak e snap.

### Negativas
- Pins e fonte APT da Mozilla viram responsabilidade do projeto (pacote `bastia-base`).
- Chromium não tem `.deb` no Ubuntu; quem quiser usa Flatpak ou snap.

## Comparação com as distribuições de referência

| | Ubuntu | Debian | Fedora | Arch | NixOS | Gentoo | BastiaOS |
|---|---|---|---|---|---|---|---|
| Snap | Padrão | Disponível, não instalado | Disponível, não instalado | AUR | Não empacotado oficialmente | Overlay | **Disponível, não instalado** |
| Flatpak | Disponível | Disponível | **Padrão** (Fedora Flatpaks; Flathub opt-in) | Repositório oficial | Opção `services.flatpak` | Disponível | **Padrão, Flathub ativo** |
| Navegador | Firefox snap | Firefox ESR deb | Firefox RPM | Firefox | Firefox | Firefox | **Firefox deb da Mozilla** |

## Critério de revisão

- Reabrir se o Ubuntu passar a exigir snap para um componente do sistema base que o BastiaOS instala.
- Reabrir se a Mozilla descontinuar o repositório APT ou o pin deixar de impedir a reinstalação do snap.
- Reabrir se o Flathub mudar de política de forma que afete a distribuição de aplicativos livres.

## Referências

- [Instalar o Firefox no Linux (Mozilla)](https://support.mozilla.org/kb/install-firefox-linux)
- [Flathub](https://flathub.org/)
- [Proposta de arquitetura](../architecture/proposta-arquitetura-ubuntu.md), seção 2.6

## Histórico de revisões

- v1.0 — Decisão inicial (2026-11-14)
