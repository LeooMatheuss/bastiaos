# STEP 11 — Hardware, drivers e periféricos

| Etapa | Status | Depende de | Anterior | Próximo |
|---|---|---|---|---|
| E2 Desktop | ⬜ Não iniciado | STEP 10 | [STEP 10](STEP-10-aplicativos-essenciais.md) | [STEP 12](STEP-12-loja-de-aplicativos-flatpak-e-atualizacoes.md) |

1. **Objetivo:** compatibilidade ampla, equivalente à do Ubuntu.
2. **Justificativa:** é a principal vantagem de usar Ubuntu como base; não pode se perder ao enxugar.
3. **Implementação:** linux-firmware, microcódigo, `ubuntu-drivers-common` + aba de drivers, CUPS por socket + system-config-printer, Blueman, fwupd, power-profiles-daemon, suporte a MTP.
4. **Arquivos:** `packages/bastia-desktop/` (dependências), `seeds/hardware.list`.
5. **Dependências:** STEP 10.
6. **Comandos:** `ubuntu-drivers list` (no live); `systemctl status cups.socket`.
7. **Conclusão:** drivers proprietários instaláveis pela GUI com Secure Boot (MOK) funcionando; impressora de rede detectável.
8. **Testes:** VM com USB passthrough (pendrive, celular MTP); impressora virtual (cups-pdf); o fluxo de MOK fica para o STEP 18.
9. **Riscos:** remover firmware para economizar disco quebra hardware real → firmware nunca entra em otimização.
10. **Resultado:** compatibilidade de hardware de nível Ubuntu.

---

## Checklist de conclusão (trilhas contínuas)
- [ ] Critérios do item 7 cumpridos e verificados pelos testes do item 8
- [ ] Documentação atualizada no mesmo PR
- [ ] Nenhum serviço novo sem justificativa; AppArmor e ufw ativos
- [ ] `make bench` executado (a partir do STEP 08) sem regressão > 10%
- [ ] ADR aceito para qualquer decisão estrutural
- [ ] Entrada no `CHANGELOG.md` (seção "Não lançado")
- [ ] Status atualizado aqui e em `docs/steps/README.md` no mesmo commit

**Commit sugerido:** `<tipo>(<escopo>): step 11 — hardware, drivers e periféricos`

**Próximo:** [STEP 12 — Loja de aplicativos, Flatpak e atualizações](STEP-12-loja-de-aplicativos-flatpak-e-atualizacoes.md)
