# STEP 14 — Otimização de desempenho

| Etapa | Status | Depende de | Anterior | Próximo |
|---|---|---|---|---|
| E3 Produto | ⬜ Não iniciado | STEP 13 | [STEP 13](STEP-13-ambiente-de-desenvolvimento-bastia-devsetup.md) | [STEP 15](STEP-15-identidade-visual-no-sistema.md) |

1. **Objetivo:** atingir as metas do STEP 04 sem remover nada essencial.
2. **Justificativa:** otimizar só depois que o sistema está completo evita otimizar o que vai mudar.
3. **Implementação:** inventário de serviços (`docs/architecture/services-inventory.md`); itens da tabela 3.3; zram; limites do journald; revisão de autostarts; `systemd-analyze critical-chain`.
4. **Arquivos:** `packages/bastia-base/` (drop-ins), `docs/architecture/`.
5. **Dependências:** STEP 13.
6. **Comandos:** `systemd-analyze blame`; `smem -t -k`; `make bench`.
7. **Conclusão:** RAM idle, boot, serviços e disco dentro das metas; cada serviço ativo justificado.
8. **Testes:** benchmark comparativo com as referências; regressão > 10% falha o CI.
9. **Riscos:** desativar algo usado por hardware específico → regra "na dúvida, ativação condicionada, não remoção".
10. **Resultado:** "leve" comprovado por números.

---

## Checklist de conclusão (trilhas contínuas)
- [ ] Critérios do item 7 cumpridos e verificados pelos testes do item 8
- [ ] Documentação atualizada no mesmo PR
- [ ] Nenhum serviço novo sem justificativa; AppArmor e ufw ativos
- [ ] `make bench` executado (a partir do STEP 08) sem regressão > 10%
- [ ] ADR aceito para qualquer decisão estrutural
- [ ] Entrada no `CHANGELOG.md` (seção "Não lançado")
- [ ] Status atualizado aqui e em `docs/steps/README.md` no mesmo commit

**Commit sugerido:** `<tipo>(<escopo>): step 14 — otimização de desempenho`

**Próximo:** [STEP 15 — Identidade visual no sistema](STEP-15-identidade-visual-no-sistema.md)
