# Steps de implementação do BastiaOS

Base: **Ubuntu 26.04 LTS + Xfce 4.20** · Arquitetura: [proposta-arquitetura-ubuntu.md](../architecture/proposta-arquitetura-ubuntu.md)

Regra: trabalhe apenas no STEP de menor número que não esteja ✅ e cuja dependência esteja concluída. Um STEP só fica ✅ com o commit em `main`.

| STEP | Título | Etapa | Depende de | Status |
|---|---|---|---|---|
| [00](STEP-00-auditoria-e-saneamento-do-repositorio.md) | Auditoria e saneamento do repositório | E0 Fundação | nenhuma. | 🟡 |
| [01](STEP-01-decisoes-de-arquitetura-adrs.md) | Decisões de arquitetura (ADRs) | E0 Fundação | STEP 00. | 🟡 |
| [02](STEP-02-governanca-e-documentacao-do-repositorio.md) | Governança e documentação do repositório | E0 Fundação | STEP 01 (ADR-0006). | ✅ |
| [03](STEP-03-infraestrutura-de-build.md) | Infraestrutura de build | E0 Fundação | STEP 02. | ✅ |
| [04](STEP-04-laboratorio-de-testes-e-baseline-das-referencias.md) | Laboratório de testes e baseline das referências | E0 Fundação | STEP 03; host já validado (KVM, OVMF secboot). | ⬜ |
| [05](STEP-05-rootfs-minimo-reprodutivel.md) | Rootfs mínimo reprodutível | E1 Sistema mínimo | STEP 03. | ⬜ |
| [06](STEP-06-iso-live-minima-tty-com-secure-boot.md) | ISO live mínima (TTY) com Secure Boot | E1 Sistema mínimo | STEP 05. | ⬜ |
| [07](STEP-07-empacotamento-proprio-ppa-e-bastia-base.md) | Empacotamento próprio, PPA e `bastia-base` | E1 Sistema mínimo | STEP 06. | ⬜ |
| [08](STEP-08-ambiente-grafico-xfce-minimo.md) | Ambiente gráfico Xfce mínimo | E2 Desktop | STEP 07. | ⬜ |
| [09](STEP-09-configuracao-padrao-do-desktop.md) | Configuração padrão do desktop | E2 Desktop | STEP 08. | ⬜ |
| [10](STEP-10-aplicativos-essenciais.md) | Aplicativos essenciais | E2 Desktop | STEP 09. | ⬜ |
| [11](STEP-11-hardware-drivers-e-perifericos.md) | Hardware, drivers e periféricos | E2 Desktop | STEP 10. | ⬜ |
| [12](STEP-12-loja-de-aplicativos-flatpak-e-atualizacoes.md) | Loja de aplicativos, Flatpak e atualizações | E2 Desktop | STEP 11. | ⬜ |
| [13](STEP-13-ambiente-de-desenvolvimento-bastia-devsetup.md) | Ambiente de desenvolvimento (`bastia-devsetup`) | E3 Produto | STEP 12. | ⬜ |
| [14](STEP-14-otimizacao-de-desempenho.md) | Otimização de desempenho | E3 Produto | STEP 13. | ⬜ |
| [15](STEP-15-identidade-visual-no-sistema.md) | Identidade visual no sistema | E3 Produto | STEP 14. | ⬜ |
| [16](STEP-16-instalador-calamares-e-iso-instalavel.md) | Instalador (Calamares) e ISO instalável | E4 Entrega | STEP 15. | ⬜ |
| [17](STEP-17-ci-de-release-e-testes-automatizados-de-ponta-a-ponta.md) | CI de release e testes automatizados de ponta a ponta | E4 Entrega | STEP 16. | ⬜ |
| [18](STEP-18-hardware-real.md) | Hardware real | E4 Entrega | STEP 17. | ⬜ |
| [19](STEP-19-correcoes-documentacao-de-usuario-e-beta.md) | Correções, documentação de usuário e beta | E4 Entrega | STEP 18. | ⬜ |

## Portões

| Portão | Ao final de | Critério |
|---|---|---|
| G0 | STEP 04 | Arquitetura única, licença, CI, metas numéricas das referências |
| G1 | STEP 07 | ISO live reproduzível com Secure Boot + PPA funcionando |
| G2 | STEP 12 | Desktop completo, loja e atualizações |
| G3 | STEP 15 | Ambiente dev pronto, consumo dentro das metas, identidade aplicada |
| G4 | STEP 19 | Beta pública |

## Trilhas contínuas (no critério de conclusão de todo STEP)

| Trilha | Regra |
|---|---|
| Documentação | Capítulo atualizado no mesmo PR |
| Testes | Toda funcionalidade com teste em VM a partir do STEP 06 |
| Segurança | Nenhum serviço novo sem justificativa; AppArmor e ufw nunca desativados |
| Benchmark | Toda mudança de seeds roda `make bench` a partir do STEP 08 |
| ADR | Decisão estrutural só com ADR aceito |

**Legenda:** ⬜ não iniciado · 🟡 em andamento · ✅ concluído · ⛔ bloqueado
