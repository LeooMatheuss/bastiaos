# ADR-0006: Licença

## Status

**Status**: Aceito
**Data**: 2026-11-14
**Tipo**: Jurídica / Processo

## Contexto

O repositório é público e está **sem licença**. Sem licença, vale "todos os direitos reservados": ninguém pode copiar, modificar ou contribuir legalmente (problema A1 da [proposta de arquitetura](../architecture/proposta-arquitetura-ubuntu.md)).

O que o projeto produz: scripts de build, configurações e metapacotes Debian (`bastia-*`), pequenas ferramentas (`bastia-devsetup` e outras), documentação e arte (logo, wallpapers, temas). O sistema integra componentes de terceiros sob as próprias licenças: kernel (GPL-2.0-only), Xfce (majoritariamente GPL-2.0-or-later), Calamares (GPL-3.0-or-later), entre outros.

## Fatores de decisão

- Compatibilidade com o ecossistema Debian/Ubuntu e com o que será redistribuído
- Garantir que derivados do BastiaOS continuem abertos
- Clareza para contribuidores
- Proteção do nome e do logo
- Flexibilidade futura do autor

## Opções consideradas

| Opção | Prós | Contras |
|---|---|---|
| **GPL-2.0-or-later + CC BY-SA 4.0 + política de marca** | Mesma família do kernel, do Xfce e da maioria dos scripts Debian; "or later" permite combinar com GPL-3 (ex.: Calamares); derivados continuam abertos | Empresas não podem fechar derivados |
| GPL-3.0-or-later | Copyleft mais forte (patentes, anti-tivoização) | Incompatível com código GPL-2.0-only que se queira incorporar |
| MIT / Apache-2.0 | Máxima adoção; permite fechar derivados | Qualquer um pode fechar uma versão do BastiaOS |
| Sem licença | — | Bloqueia contribuições (situação atual) |

## Decisão

| O quê | Licença |
|---|---|
| Código, scripts, configurações e empacotamento (`ci/`, `seeds/`, `packages/`, ferramentas `bastia-*`) | **GPL-2.0-or-later** |
| Documentação (`docs/`, README, site) | **CC BY-SA 4.0** |
| Arte não-marca (wallpapers, temas, ícones genéricos) | **CC BY-SA 4.0** |
| Nome "BastiaOS", logo e ícone (`assets/branding/`) | **Marca reservada** — uso permitido conforme política de marca |
| Componentes de terceiros | Mantêm a licença original (registrada em `debian/copyright` de cada pacote) |

Regras complementares:

- Cada arquivo de código recebe um cabeçalho SPDX (`SPDX-License-Identifier: GPL-2.0-or-later`).
- Contribuições usam o **Developer Certificate of Origin** (`Signed-off-by` do próprio contribuidor) — sem CLA.
- O arquivo `LICENSE`, a política de marca e a configuração do GitHub são aplicados na etapa de governança do repositório.

## Justificativa

GPL-2.0-or-later é a escolha mais compatível com o que o BastiaOS integra: combina com GPL-2.0 e GPL-3.0, é a licença dominante nos scripts e pacotes Debian/Ubuntu e garante que quem redistribuir uma versão modificada publique o código. A CC BY-SA 4.0 é a licença copyleft padrão para documentação e arte, e é compatível no sentido CC BY-SA → GPL-3.0. A marca fica separada da licença: o código é livre, mas uma versão modificada não pode se apresentar como "BastiaOS" oficial.

## Consequências

### Positivas
- Contribuições passam a ser legalmente possíveis.
- Derivados continuam livres; o nome fica protegido.
- O GitHub reconhece a licença do repositório.

### Negativas
- Quem quiser fechar um derivado não pode — intencional.
- Ferramentas que o autor queira manter fechadas no futuro precisam ficar em **repositório separado** desde o início e não podem incorporar código GPL de terceiros. O código do próprio autor pode ser relicenciado por ele; o de contribuidores, não.

## Comparação com as distribuições de referência

| | Ubuntu | Debian | Fedora | Arch | NixOS | Gentoo | BastiaOS |
|---|---|---|---|---|---|---|---|
| Ferramentas próprias | Majoritariamente GPL-3.0 | Majoritariamente GPL-2.0+ | Padrão do FPCA: MIT | pacman: GPL-2.0-or-later | nixpkgs: MIT | ebuilds: GPL-2 | **GPL-2.0-or-later** |
| Documentação | CC BY-SA | Várias (GPL, DFSG) | CC BY-SA 4.0 | Wiki: GFDL 1.3+ | MIT | CC BY-SA 4.0 | **CC BY-SA 4.0** |
| Marca | Política de IP da Canonical | Política de marca do Debian | Diretrizes de marca da Fedora | Política de marca do Arch | Política de marca do NixOS | Política de marca do Gentoo | **Política de marca própria** |
| Contribuições | CLA da Canonical | Sem CLA | FPCA | Sem CLA | Sem CLA | Gentoo Certificate of Origin (variante do DCO) | **DCO** |

## Critério de revisão

- Reabrir se um componente essencial for GPL-2.0-only e precisar ser combinado com código GPL-3.0 do projeto.
- Reabrir antes de aceitar a primeira contribuição externa relevante, se o autor decidir manter alguma parte proprietária.
- Reabrir se a verificação de marca mostrar conflito com o nome "BastiaOS".

## Referências

- [GPL-2.0-or-later](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html)
- [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)
- [Developer Certificate of Origin](https://developercertificate.org/)
- [SPDX License List](https://spdx.org/licenses/)

## Histórico de revisões

- v1.0 — Decisão inicial (2026-11-14)
