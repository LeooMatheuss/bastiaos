# STEP 00 — Auditoria e saneamento do repositório

| Etapa | Status | Depende de | Anterior | Próximo |
|---|---|---|---|---|
| E0 Fundação | 🟡 Em andamento (na `testing`, aguardando `main`) | nenhuma. | — | [STEP 01](STEP-01-decisoes-de-arquitetura-adrs.md) |

1. **Objetivo:** deixar o repositório com uma única arquitetura e sem artefatos contraditórios.
2. **Justificativa:** hoje coexistem Buildroot, o plano Debian e o novo objetivo Ubuntu (problema A2).
3. **Implementação:** taguear e arquivar o experimento Buildroot; remover do `main`; corrigir os status que não correspondem ao repositório.
4. **Arquivos:** `build/`, `scripts/setup-buildroot.sh`, `docs/` (ordem antiga), `README.md`.
5. **Dependências:** nenhuma.
6. **Comandos:**
   ```bash
   git switch -c chore/step00-cleanup
   git tag -a archive/buildroot -m "Experimento Buildroot arquivado (substituído pela base Ubuntu)"
   git rm -r build/ scripts/setup-buildroot.sh
   git push origin archive/buildroot
   ```
7. **Conclusão:** `main` sem Buildroot; a tag existe no remoto; o README não cita Buildroot.
8. **Testes:** `git ls-tree -r archive/buildroot --name-only | grep defconfig` (histórico preservado); `grep -ri buildroot README.md` sem resultado.
9. **Riscos:** perder o trabalho de configuração → mitigado pela tag anotada.
10. **Resultado:** repositório coerente, pronto para receber os ADRs.

---

## Checklist de conclusão (trilhas contínuas)
- [x] Critérios do item 7 cumpridos e verificados pelos testes do item 8
- [x] Documentação atualizada no mesmo PR
- [x] Nenhum serviço novo sem justificativa; AppArmor e ufw ativos — *N/A: nenhum serviço neste step*
- [x] `make bench` executado (a partir do STEP 08) sem regressão > 10% — *N/A antes do STEP 08*
- [x] ADR aceito para qualquer decisão estrutural — *N/A: a substituição formal do ADR-0001 é o STEP 01*
- [x] Entrada no `CHANGELOG.md` (seção "Não lançado")
- [x] Status atualizado aqui e em `docs/steps/README.md` no mesmo commit

**Commit sugerido:** `<tipo>(<escopo>): step 00 — auditoria e saneamento do repositório`

**Próximo:** [STEP 01 — Decisões de arquitetura (ADRs)](STEP-01-decisoes-de-arquitetura-adrs.md)
