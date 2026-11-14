# STEP 12 — Loja de aplicativos, Flatpak e atualizações

| Etapa | Status | Depende de | Anterior | Próximo |
|---|---|---|---|---|
| E2 Desktop | ⬜ Não iniciado | STEP 11 | [STEP 11](STEP-11-hardware-drivers-e-perifericos.md) | [STEP 13](STEP-13-ambiente-de-desenvolvimento-bastia-devsetup.md) |

1. **Objetivo:** instalar e remover programas pela GUI e pelo terminal, e manter o sistema atualizado.
2. **Justificativa:** requisito central de liberdade do usuário.
3. **Implementação:** GNOME Software + plugin Flatpak (sem plugin snap); Flathub ativo; unattended-upgrades apenas para segurança; notificação de atualizações sem processo residente; medição A×B (GNOME Software × update-manager) para decidir a ferramenta de atualização.
4. **Arquivos:** `packages/bastia-base/` (Flathub, unattended), `packages/bastia-desktop-settings/` (autostart).
5. **Dependências:** STEP 11.
6. **Comandos:**
   ```bash
   flatpak remotes                  # flathub listado
   apt install -s htop              # terminal funciona
   systemctl list-timers | grep -E 'apt|unattended'
   ```
7. **Conclusão:** instalar/remover um app APT e um Flatpak pela loja; atualização de segurança aplicada automaticamente em VM com snapshot antigo → atual.
8. **Testes:** VM construída com `SNAPSHOT_ID` antigo, depois apontada para o atual; verificar `/var/log/unattended-upgrades/`.
9. **Riscos:** GNOME Software residente consome RAM → autostart desativado e medido.
10. **Resultado:** liberdade total de instalação com atualizações confiáveis.

---

## Checklist de conclusão (trilhas contínuas)
- [ ] Critérios do item 7 cumpridos e verificados pelos testes do item 8
- [ ] Documentação atualizada no mesmo PR
- [ ] Nenhum serviço novo sem justificativa; AppArmor e ufw ativos
- [ ] `make bench` executado (a partir do STEP 08) sem regressão > 10%
- [ ] ADR aceito para qualquer decisão estrutural
- [ ] Entrada no `CHANGELOG.md` (seção "Não lançado")
- [ ] Status atualizado aqui e em `docs/steps/README.md` no mesmo commit

**Commit sugerido:** `<tipo>(<escopo>): step 12 — loja de aplicativos, flatpak e atualizações`

**Próximo:** [STEP 13 — Ambiente de desenvolvimento (`bastia-devsetup`)](STEP-13-ambiente-de-desenvolvimento-bastia-devsetup.md)
