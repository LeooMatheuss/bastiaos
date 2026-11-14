# STEP 08 — Ambiente gráfico Xfce mínimo

| Etapa | Status | Depende de | Anterior | Próximo |
|---|---|---|---|---|
| E2 Desktop | ⬜ Não iniciado | STEP 07 | [STEP 07](STEP-07-empacotamento-proprio-ppa-e-bastia-base.md) | [STEP 09](STEP-09-configuracao-padrao-do-desktop.md) |

1. **Objetivo:** boot até um desktop Xfce funcional, com o mínimo de componentes.
2. **Justificativa:** construir de baixo para cima permite medir o custo de cada adição.
3. **Implementação:** metapacote `bastia-desktop-core` com xorg, LightDM + greeter GTK, xfce4-session, xfwm4, xfce4-panel, xfdesktop4, xfce4-settings, xfce4-notifyd, Thunar, PipeWire + pavucontrol, nm-applet, polkit agent; `--no-install-recommends` com recomendações escolhidas uma a uma.
4. **Arquivos:** `packages/bastia-desktop-core/`, `seeds/desktop.list`.
5. **Dependências:** STEP 07.
6. **Comandos:** `make iso PROFILE=desktop-core && make vm-gui`.
7. **Conclusão:** login gráfico; áudio, rede e montagem de USB funcionando; RAM idle medida.
8. **Testes:** captura de tela automatizada via QMP; `systemctl --failed` vazio; `wpctl status`.
9. **Riscos:** recomendações puxando tracker ou evolution-data-server → conferir o manifesto a cada build.
10. **Resultado:** desktop mínimo com baseline próprio.

---

## Checklist de conclusão (trilhas contínuas)
- [ ] Critérios do item 7 cumpridos e verificados pelos testes do item 8
- [ ] Documentação atualizada no mesmo PR
- [ ] Nenhum serviço novo sem justificativa; AppArmor e ufw ativos
- [ ] `make bench` executado (a partir do STEP 08) sem regressão > 10%
- [ ] ADR aceito para qualquer decisão estrutural
- [ ] Entrada no `CHANGELOG.md` (seção "Não lançado")
- [ ] Status atualizado aqui e em `docs/steps/README.md` no mesmo commit

**Commit sugerido:** `<tipo>(<escopo>): step 08 — ambiente gráfico xfce mínimo`

**Próximo:** [STEP 09 — Configuração padrão do desktop](STEP-09-configuracao-padrao-do-desktop.md)
