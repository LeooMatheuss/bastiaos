# STEP 09 — Configuração padrão do desktop

| Etapa | Status | Depende de | Anterior | Próximo |
|---|---|---|---|---|
| E2 Desktop | ⬜ Não iniciado | STEP 08 | [STEP 08](STEP-08-ambiente-grafico-xfce-minimo.md) | [STEP 10](STEP-10-aplicativos-essenciais.md) |

1. **Objetivo:** layout, atalhos e comportamento padrão do BastiaOS.
2. **Justificativa:** a experiência pronta para uso vem das configurações, não da quantidade de programas.
3. **Implementação:** pacote `bastia-desktop-settings` instalando padrões em `/etc/xdg/xdg-bastia/` e exportando `XDG_CONFIG_DIRS` na sessão (mesmo mecanismo do `xubuntu-default-settings`); painel, atalhos (incluindo terminal e captura de tela), configuração do Thunar, power manager.
4. **Arquivos:** `packages/bastia-desktop-settings/`.
5. **Dependências:** STEP 08.
6. **Comandos:** `make pkg-bastia-desktop-settings && make iso && make vm-gui`.
7. **Conclusão:** um usuário novo recebe o layout BastiaOS; usuário com `~/.config` próprio **não** é sobrescrito.
8. **Testes:** criar dois usuários (limpo e customizado) e conferir o comportamento; upgrade do pacote.
9. **Riscos:** gravar em `/etc/skel` congela configurações → usar XDG.
10. **Resultado:** identidade funcional consistente e atualizável.

---

## Checklist de conclusão (trilhas contínuas)
- [ ] Critérios do item 7 cumpridos e verificados pelos testes do item 8
- [ ] Documentação atualizada no mesmo PR
- [ ] Nenhum serviço novo sem justificativa; AppArmor e ufw ativos
- [ ] `make bench` executado (a partir do STEP 08) sem regressão > 10%
- [ ] ADR aceito para qualquer decisão estrutural
- [ ] Entrada no `CHANGELOG.md` (seção "Não lançado")
- [ ] Status atualizado aqui e em `docs/steps/README.md` no mesmo commit

**Commit sugerido:** `<tipo>(<escopo>): step 09 — configuração padrão do desktop`

**Próximo:** [STEP 10 — Aplicativos essenciais](STEP-10-aplicativos-essenciais.md)
