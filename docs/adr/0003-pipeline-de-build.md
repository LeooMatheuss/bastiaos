# ADR-0003: Pipeline de build (mmdebstrap + snapshot + casper + xorriso)

## Status

**Status**: Aceito
**Data**: 2026-11-14
**Tipo**: Técnica
**Substitui**: [ADR-0001](0001-build-system.md) (parte "sistema de build")

## Contexto

Com a base Ubuntu ([ADR-0002](0002-base-ubuntu-xfce.md)), o projeto não compila o sistema: ele **seleciona e monta** pacotes do archive. É preciso uma forma de gerar a ISO que seja reproduzível, rode no CI e não dependa de ferramentas gráficas ou da infraestrutura interna da Canonical.

## Fatores de decisão

- Reprodutibilidade: mesmas entradas → mesmo manifesto de pacotes
- Execução não interativa no CI e local (`make`)
- Boot assinado do Ubuntu preservado
- Controle explícito sobre o que entra e o que fica de fora (snapd, telemetria)
- Curva de aprendizado e quantidade de código próprio

## Opções consideradas

| Método | Prós | Contras | Veredito |
|---|---|---|---|
| Cubic / remaster manual | Rápido | Não reproduzível; não roda em CI | ❌ |
| Remaster da ISO Xubuntu Minimal | Mantém o instalador oficial | squashfs em camadas + instalador distribuído como snap; frágil | ❌ |
| livecd-rootfs | Ferramenta oficial dos sabores | Acoplado ao Launchpad/cdimage; curva alta | ⚠️ referência |
| mkosi | Moderno, declarativo | Não gera live com casper; foco em imagens de disco | ❌ |
| **mmdebstrap + snapshot.ubuntu.com → casper → xorriso** | Reproduzível, roda em contêiner, controle total | Mais código próprio no início | ✅ |

## Decisão

1. **Rootfs:** `mmdebstrap --variant=minbase` a partir de `https://snapshot.ubuntu.com/ubuntu/<timestamp>`, com listas de pacotes versionadas em `seeds/` (uma por camada: `base`, `live`, `desktop`) e exclusões explícitas.
2. **Live:** `casper` no initramfs; rootfs comprimido em squashfs.
3. **Boot:** `shimx64.efi.signed` e `grubx64.efi.signed` do Ubuntu, **sem modificação**; BIOS via `grub-pc-bin`.
4. **ISO:** `xorriso` gerando ISO híbrida (UEFI + BIOS, gravável em USB).
5. **Ambiente:** tudo roda num contêiner builder fixado por digest, com `SOURCE_DATE_EPOCH` derivado do timestamp do snapshot.
6. Cada build publica o manifesto de pacotes (`dpkg-query`) como artefato.

## Justificativa

O snapshot fixa o estado do archive; o mmdebstrap é determinístico dado o mesmo snapshot; casper e os binários assinados são os mesmos usados pelo Ubuntu, o que preserva o Secure Boot e o comportamento live conhecido.

## Consequências

### Positivas
- Builds comparáveis por manifesto e, depois, por hash.
- Atualizar o sistema = mudar o timestamp do snapshot em um commit.

### Negativas
- Scripts próprios para montar a árvore da ISO (GRUB, squashfs, manifestos).
- O snapshot.ubuntu.com passa a ser dependência crítica do build.

## Comparação com as distribuições de referência

| | Ubuntu | Debian | Fedora | Arch | NixOS | Gentoo | BastiaOS |
|---|---|---|---|---|---|---|---|
| Ferramenta de ISO | livecd-rootfs | live-build / debian-cd | Kiwi / lorax | archiso | módulos de imagem do Nix | catalyst | **mmdebstrap + casper + xorriso** |
| Fixação do archive | snapshot.ubuntu.com | snapshot.debian.org | Parcial | Archive histórico | Nativo (lock de entradas) | Local | **snapshot.ubuntu.com** |

## Critério de revisão

- Reabrir se dois builds do mesmo snapshot gerarem manifestos diferentes e a causa não puder ser corrigida no pipeline.
- Reabrir se o snapshot.ubuntu.com ficar indisponível ou deixar de cobrir 26.04 por mais de uma semana; alternativa: espelho próprio com aptly.
- Reavaliar o livecd-rootfs se o volume de scripts próprios passar a dificultar a manutenção.

## Referências

- [snapshot.ubuntu.com](https://snapshot.ubuntu.com/)
- [mmdebstrap](https://gitlab.mister-muffin.de/josch/mmdebstrap)
- [SOURCE_DATE_EPOCH](https://reproducible-builds.org/docs/source-date-epoch/)
- [Proposta de arquitetura](../architecture/proposta-arquitetura-ubuntu.md), seção 2.4

## Histórico de revisões

- v1.0 — Decisão inicial (2026-11-14)
