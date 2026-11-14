# STEP 10 — Aplicativos essenciais

| Etapa | Status | Depende de | Anterior | Próximo |
|---|---|---|---|---|
| E2 Desktop | ⬜ Não iniciado | STEP 09 | [STEP 09](STEP-09-configuracao-padrao-do-desktop.md) | [STEP 11](STEP-11-hardware-drivers-e-perifericos.md) |

1. **Objetivo:** instalar a seleção da Parte 3.1.
2. **Justificativa:** pronto para uso após a instalação, sem excesso.
3. **Implementação:** metapacote `bastia-desktop` com Firefox (Mozilla), seleção do LibreOffice + pt-BR, Mousepad, Atril, Ristretto, screenshooter, Engrampa + 7zip/unar; associações MIME padrão.
4. **Arquivos:** `packages/bastia-desktop/`, `packages/bastia-desktop-settings/mimeapps.list`.
5. **Dependências:** STEP 09.
6. **Comandos:** `make iso && make vm-gui && make bench`.
7. **Conclusão:** cada aplicativo abre um arquivo de exemplo; tamanho da ISO e RAM idle dentro das metas do STEP 04.
8. **Testes:** abrir `.odt`, `.docx`, `.xlsx`, `.pdf`, `.png`, `.zip` por script dentro da VM; tempo de abertura com hyperfine.
9. **Riscos:** o LibreOffice puxar Java por recomendação → `--no-install-recommends` e auditoria do manifesto.
10. **Resultado:** sistema útil desde o primeiro login.

---

## Checklist de conclusão (trilhas contínuas)
- [ ] Critérios do item 7 cumpridos e verificados pelos testes do item 8
- [ ] Documentação atualizada no mesmo PR
- [ ] Nenhum serviço novo sem justificativa; AppArmor e ufw ativos
- [ ] `make bench` executado (a partir do STEP 08) sem regressão > 10%
- [ ] ADR aceito para qualquer decisão estrutural
- [ ] Entrada no `CHANGELOG.md` (seção "Não lançado")
- [ ] Status atualizado aqui e em `docs/steps/README.md` no mesmo commit

**Commit sugerido:** `<tipo>(<escopo>): step 10 — aplicativos essenciais`

**Próximo:** [STEP 11 — Hardware, drivers e periféricos](STEP-11-hardware-drivers-e-perifericos.md)
