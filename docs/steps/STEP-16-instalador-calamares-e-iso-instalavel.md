# STEP 16 — Instalador (Calamares) e ISO instalável

| Etapa | Status | Depende de | Anterior | Próximo |
|---|---|---|---|---|
| E4 Entrega | ⬜ Não iniciado | STEP 15 | [STEP 15](STEP-15-identidade-visual-no-sistema.md) | [STEP 17](STEP-17-ci-de-release-e-testes-automatizados-de-ponta-a-ponta.md) |

1. **Objetivo:** instalação simples em disco a partir da ISO live.
2. **Justificativa:** "instalação simples" é um requisito; Calamares é maduro no Ubuntu (Lubuntu) e não depende de snap.
3. **Implementação:** pacote `bastia-calamares-settings` derivado de `calamares-settings-lubuntu`; módulos: idioma pt-BR, fuso, teclado, partição (ext4 padrão; LUKS2 opcional), usuários, remoção dos pacotes live, bootloader (shim/GRUB assinados), opção de codecs/drivers de terceiros.
4. **Arquivos:** `packages/bastia-calamares-settings/`.
5. **Dependências:** STEP 15.
6. **Comandos:** `make iso PROFILE=install && make vm-install`.
7. **Conclusão:** instalar em qcow2 vazio → reboot → login, com Secure Boot ativo; pacotes live (casper, calamares) ausentes no sistema instalado.
8. **Testes:** instalação automatizada (configuração não interativa do Calamares ou script de QMP) em UEFI+SB, UEFI e BIOS; com e sem LUKS.
9. **Riscos:** destruir disco errado → apenas VM até o STEP 18; o Calamares exige confirmação.
10. **Resultado:** ISO instalável.

---

## Checklist de conclusão (trilhas contínuas)
- [ ] Critérios do item 7 cumpridos e verificados pelos testes do item 8
- [ ] Documentação atualizada no mesmo PR
- [ ] Nenhum serviço novo sem justificativa; AppArmor e ufw ativos
- [ ] `make bench` executado (a partir do STEP 08) sem regressão > 10%
- [ ] ADR aceito para qualquer decisão estrutural
- [ ] Entrada no `CHANGELOG.md` (seção "Não lançado")
- [ ] Status atualizado aqui e em `docs/steps/README.md` no mesmo commit

**Commit sugerido:** `<tipo>(<escopo>): step 16 — instalador (calamares) e iso instalável`

**Próximo:** [STEP 17 — CI de release e testes automatizados de ponta a ponta](STEP-17-ci-de-release-e-testes-automatizados-de-ponta-a-ponta.md)
