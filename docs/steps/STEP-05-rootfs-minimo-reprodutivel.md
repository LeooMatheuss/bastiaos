# STEP 05 — Rootfs mínimo reprodutível

| Etapa | Status | Depende de | Anterior | Próximo |
|---|---|---|---|---|
| E1 Sistema mínimo | ⬜ Não iniciado | STEP 03 | [STEP 04](STEP-04-laboratorio-de-testes-e-baseline-das-referencias.md) | [STEP 06](STEP-06-iso-live-minima-tty-com-secure-boot.md) |

1. **Objetivo:** gerar o sistema base Ubuntu mínimo a partir de um snapshot fixo do archive.
2. **Justificativa:** reprodutibilidade; a lista de pacotes passa a ser explícita e versionada.
3. **Implementação:** lista de pacotes em `seeds/` (formato próprio, uma lista por camada: `base`, `live`, `desktop`); bootstrap via mmdebstrap; manifesto de pacotes; exclusões explícitas (snapd, apport, whoopsie, ubuntu-insights).
4. **Arquivos:** `seeds/base.list`, `build/rootfs.sh`, `build/config.env` (`SNAPSHOT_ID`, release), `out/manifest.txt`.
5. **Dependências:** STEP 03.
6. **Comandos:**
   ```bash
   SNAP=20261114T000000Z
   mmdebstrap --variant=minbase --components="main restricted universe multiverse" \
     --include="$(paste -sd, seeds/base.list)" resolute out/rootfs.tar \
     "deb https://snapshot.ubuntu.com/ubuntu/$SNAP resolute resolute-updates resolute-security"
   ```
7. **Conclusão:** dois builds com o mesmo `SNAPSHOT_ID` produzem manifestos idênticos; nenhum pacote proibido.
8. **Testes:** `diff manifest1 manifest2`; `grep -E 'snapd|apport|whoopsie' manifest.txt` sem resultado; inspeção em `systemd-nspawn`.
9. **Riscos:** o snapshot service garante datas de ao menos ~2 anos no passado → registrar o `SNAPSHOT_ID` de cada release e manter cache de pacotes no CI.
10. **Resultado:** base auditável e reproduzível.

---

## Checklist de conclusão (trilhas contínuas)
- [ ] Critérios do item 7 cumpridos e verificados pelos testes do item 8
- [ ] Documentação atualizada no mesmo PR
- [ ] Nenhum serviço novo sem justificativa; AppArmor e ufw ativos
- [ ] `make bench` executado (a partir do STEP 08) sem regressão > 10%
- [ ] ADR aceito para qualquer decisão estrutural
- [ ] Entrada no `CHANGELOG.md` (seção "Não lançado")
- [ ] Status atualizado aqui e em `docs/steps/README.md` no mesmo commit

**Commit sugerido:** `<tipo>(<escopo>): step 05 — rootfs mínimo reprodutível`

**Próximo:** [STEP 06 — ISO live mínima (TTY) com Secure Boot](STEP-06-iso-live-minima-tty-com-secure-boot.md)
