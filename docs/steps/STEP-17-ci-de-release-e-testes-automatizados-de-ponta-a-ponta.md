# STEP 17 — CI de release e testes automatizados de ponta a ponta

| Etapa | Status | Depende de | Anterior | Próximo |
|---|---|---|---|---|
| E4 Entrega | ⬜ Não iniciado | STEP 16 | [STEP 16](STEP-16-instalador-calamares-e-iso-instalavel.md) | [STEP 18](STEP-18-hardware-real.md) |

1. **Objetivo:** cada tag gera uma ISO testada, assinada e verificável.
2. **Justificativa:** distribuição pública exige cadeia de confiança.
3. **Implementação:** pipeline com build → boot → instalação → smoke tests → SHA256SUMS → assinatura GPG (chave de release com primária offline) → SBOM (manifesto) → GitHub Release; build duplo para verificar reprodutibilidade.
4. **Arquivos:** `.github/workflows/release.yml`, `tools/release/`.
5. **Dependências:** STEP 16.
6. **Comandos:** `gpg --verify SHA256SUMS.asc SHA256SUMS && sha256sum -c SHA256SUMS`.
7. **Conclusão:** um terceiro verifica a ISO com a chave publicada; dois builds com o mesmo manifesto.
8. **Testes:** release candidate interno `v0.9.0-rc.1`.
9. **Riscos:** chave privada no CI → subchave de assinatura dedicada, com rotação documentada.
10. **Resultado:** release engineering profissional.

---

## Checklist de conclusão (trilhas contínuas)
- [ ] Critérios do item 7 cumpridos e verificados pelos testes do item 8
- [ ] Documentação atualizada no mesmo PR
- [ ] Nenhum serviço novo sem justificativa; AppArmor e ufw ativos
- [ ] `make bench` executado (a partir do STEP 08) sem regressão > 10%
- [ ] ADR aceito para qualquer decisão estrutural
- [ ] Entrada no `CHANGELOG.md` (seção "Não lançado")
- [ ] Status atualizado aqui e em `docs/steps/README.md` no mesmo commit

**Commit sugerido:** `<tipo>(<escopo>): step 17 — ci de release e testes automatizados de ponta a ponta`

**Próximo:** [STEP 18 — Hardware real](STEP-18-hardware-real.md)
