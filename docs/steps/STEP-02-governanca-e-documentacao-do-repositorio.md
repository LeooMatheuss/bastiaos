# STEP 02 — Governança e documentação do repositório

| Etapa | Status | Depende de | Anterior | Próximo |
|---|---|---|---|---|
| E0 Fundação | ⬜ Não iniciado | STEP 01 (ADR-0006) | [STEP 01](STEP-01-decisoes-de-arquitetura-adrs.md) | [STEP 03](STEP-03-infraestrutura-de-build.md) |

1. **Objetivo:** corrigir o problema A1 (licença) e profissionalizar o repositório.
2. **Justificativa:** o repositório público sem licença impede contribuições; `main` sem proteção aceita push direto.
3. **Implementação:** `LICENSE`; README técnico alinhado aos ADRs; CONTRIBUTING, SECURITY, CODE_OF_CONDUCT, CHANGELOG, templates de issue/PR e MkDocs (reaproveitados do pacote S02, **sem** o logo de fortaleza); proteção de `main`; relato privado de vulnerabilidades.
4. **Arquivos:** raiz do repo, `.github/`, `mkdocs.yml`, `docs/`.
5. **Dependências:** STEP 01 (ADR-0006).
6. **Comandos:**
   ```bash
   gh api repos/{owner}/bastiaos --jq .license      # deve deixar de ser null
   pip install -r requirements-docs.txt && mkdocs build --strict
   ```
7. **Conclusão:** `license` reconhecido pelo GitHub; push direto em `main` recusado; docs publicadas.
8. **Testes:** tentar `git push origin main` direto (deve falhar); README renderiza o logo de `assets/branding/`.
9. **Riscos:** conflitos com o README atual → `diff` manual antes de substituir.
10. **Resultado:** repositório legal e profissionalmente utilizável.

---

## Checklist de conclusão (trilhas contínuas)
- [ ] Critérios do item 7 cumpridos e verificados pelos testes do item 8
- [ ] Documentação atualizada no mesmo PR
- [ ] Nenhum serviço novo sem justificativa; AppArmor e ufw ativos
- [ ] `make bench` executado (a partir do STEP 08) sem regressão > 10%
- [ ] ADR aceito para qualquer decisão estrutural
- [ ] Entrada no `CHANGELOG.md` (seção "Não lançado")
- [ ] Status atualizado aqui e em `docs/steps/README.md` no mesmo commit

**Commit sugerido:** `<tipo>(<escopo>): step 02 — governança e documentação do repositório`

**Próximo:** [STEP 03 — Infraestrutura de build](STEP-03-infraestrutura-de-build.md)
