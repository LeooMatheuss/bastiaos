# STEP 01 — Decisões de arquitetura (ADRs)

| Etapa | Status | Depende de | Anterior | Próximo |
|---|---|---|---|---|
| E0 Fundação | 🟡 Em andamento (na `testing`, aguardando `main`) | STEP 00 | [STEP 00](STEP-00-auditoria-e-saneamento-do-repositorio.md) | [STEP 02](STEP-02-governanca-e-documentacao-do-repositorio.md) |

1. **Objetivo:** registrar formalmente as decisões das Partes 2 e 3.
2. **Justificativa:** sem ADR, decisões se perdem ou se contradizem (já aconteceu com o ADR-0001).
3. **Implementação:**

   | ADR | Decisão |
   |---|---|
   | ADR-0001 | Status → *Substituído por ADR-0002* |
   | ADR-0002 | Base Ubuntu 26.04 LTS + Xfce 4.20; LXQt como alternativa com critério de revisão |
   | ADR-0003 | Pipeline de build (mmdebstrap + snapshot + casper + xorriso) |
   | ADR-0004 | Política de snap e Flatpak |
   | ADR-0005 | Instalador Calamares |
   | ADR-0006 | Licença |
   | ADR-0007 | Versionamento e janela de suporte (até 04/2029; rebase 28.04) |
   | ADR-0008 | Repositório próprio em Launchpad PPA |

4. **Arquivos:** `docs/adr/0001…0008`, `docs/adr/README.md`.
5. **Dependências:** STEP 00.
6. **Comandos:** nenhum além de Git; ADRs no template já existente.
7. **Conclusão:** ADRs 0002–0008 com status *Aceito*, cada um com comparação Ubuntu/Debian/Fedora/Arch/NixOS/Gentoo e critério de revisão.
8. **Testes:** revisão cruzada — nenhum ADR contradiz outro; `mkdocs build --strict` (a partir do STEP 02).
9. **Riscos:** decidir a licença sem entender a compatibilidade; atenção a ferramentas que você queira manter fechadas no futuro.
10. **Resultado:** uma arquitetura única e rastreável.

---

## Checklist de conclusão (trilhas contínuas)
- [x] Critérios do item 7 cumpridos e verificados pelos testes do item 8 — *revisão cruzada feita; `mkdocs build --strict` só a partir do STEP 02*
- [x] Documentação atualizada no mesmo PR
- [x] Nenhum serviço novo sem justificativa; AppArmor e ufw ativos — *N/A: nenhum serviço neste step*
- [x] `make bench` executado (a partir do STEP 08) sem regressão > 10% — *N/A antes do STEP 08*
- [x] ADR aceito para qualquer decisão estrutural
- [x] Entrada no `CHANGELOG.md` (seção "Não lançado")
- [x] Status atualizado aqui e em `docs/steps/README.md` no mesmo commit

**Commit sugerido:** `<tipo>(<escopo>): step 01 — decisões de arquitetura (adrs)`

**Próximo:** [STEP 02 — Governança e documentação do repositório](STEP-02-governanca-e-documentacao-do-repositorio.md)
