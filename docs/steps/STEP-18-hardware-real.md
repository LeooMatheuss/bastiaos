# STEP 18 — Hardware real

| Etapa | Status | Depende de | Anterior | Próximo |
|---|---|---|---|---|
| E4 Entrega | ⬜ Não iniciado | STEP 17 | [STEP 17](STEP-17-ci-de-release-e-testes-automatizados-de-ponta-a-ponta.md) | [STEP 19](STEP-19-correcoes-documentacao-de-usuario-e-beta.md) |

1. **Objetivo:** validar fora da VM.
2. **Justificativa:** Wi-Fi, suspensão, GPU híbrida e fluxo de MOK não aparecem em QEMU.
3. **Implementação:** matriz de hardware (pelo menos 2 máquinas: uma moderna, uma com ≤ 4 GB de RAM), live USB e instalação em disco dedicado; teste de driver NVIDIA com MOK.
4. **Arquivos:** `docs/hardware/compatibility.md`.
5. **Dependências:** STEP 17.
6. **Comandos:** `sudo dd if=bastiaos.iso of=/dev/sdX bs=4M status=progress oflag=sync` (conferir `/dev/sdX` com `lsblk` antes); `inxi -Fxz` para o relatório.
7. **Conclusão:** relatório de compatibilidade publicado; nenhum bloqueador aberto.
8. **Testes:** Wi-Fi, Bluetooth, áudio, suspender/retomar, brilho, monitor externo, impressão, webcam.
9. **Riscos:** gravar no disco errado → nunca usar a máquina principal; `lsblk` obrigatório.
10. **Resultado:** confiança para a release pública.

---

## Checklist de conclusão (trilhas contínuas)
- [ ] Critérios do item 7 cumpridos e verificados pelos testes do item 8
- [ ] Documentação atualizada no mesmo PR
- [ ] Nenhum serviço novo sem justificativa; AppArmor e ufw ativos
- [ ] `make bench` executado (a partir do STEP 08) sem regressão > 10%
- [ ] ADR aceito para qualquer decisão estrutural
- [ ] Entrada no `CHANGELOG.md` (seção "Não lançado")
- [ ] Status atualizado aqui e em `docs/steps/README.md` no mesmo commit

**Commit sugerido:** `<tipo>(<escopo>): step 18 — hardware real`

**Próximo:** [STEP 19 — Correções, documentação de usuário e beta](STEP-19-correcoes-documentacao-de-usuario-e-beta.md)
