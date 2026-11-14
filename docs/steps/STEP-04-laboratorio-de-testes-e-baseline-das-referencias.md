# STEP 04 — Laboratório de testes e baseline das referências

| Etapa | Status | Depende de | Anterior | Próximo |
|---|---|---|---|---|
| E0 Fundação | ⬜ Não iniciado | STEP 03; host já validado (KVM, OVMF secboot) | [STEP 03](STEP-03-infraestrutura-de-build.md) | [STEP 05](STEP-05-rootfs-minimo-reprodutivel.md) |

1. **Objetivo:** medir as distribuições de referência na mesma VM para definir metas numéricas.
2. **Justificativa:** "leve" só vale com comparação. Sem baseline, otimização é palpite.
3. **Implementação:**
   - Scripts QEMU com OVMF (com e sem Secure Boot).
   - Protocolo de medição: 10 boots, mediana + IQR.
   - Medir **Xubuntu Minimal, Xubuntu Desktop, Lubuntu e Ubuntu Desktop 26.04** instalados em VM idêntica.
4. **Arquivos:** `tools/vm/`, `tests/benchmarks/protocol.md`, `tests/benchmarks/results/reference-26.04.csv`.
5. **Dependências:** STEP 03; host já validado (KVM, OVMF secboot).
6. **Comandos (por referência):**
   ```bash
   sha256sum -c SHA256SUMS --ignore-missing && gpg --verify SHA256SUMS.gpg SHA256SUMS
   qemu-img create -f qcow2 ref-xubuntu-min.qcow2 40G
   # instalar; depois, 60 s após o login, sem apps abertos:
   systemd-analyze; free -m; ps -e --no-headers | wc -l
   systemctl list-units --type=service --state=running --no-legend | wc -l
   df -h /; smem -t -k
   ```
7. **Conclusão:** CSV com RAM idle, boot, processos, serviços e disco das 4 referências; metas do BastiaOS definidas (proposta: RAM e serviços ≤ Xubuntu Minimal, com LibreOffice e Firefox inclusos).
8. **Testes:** variação entre execuções < 10%.
9. **Riscos:** comparar VMs diferentes → mesma configuração de CPU, RAM e disco, documentada.
10. **Resultado:** metas científicas; decisão Xfce × LXQt confirmada ou reaberta.

---

## Checklist de conclusão (trilhas contínuas)
- [ ] Critérios do item 7 cumpridos e verificados pelos testes do item 8
- [ ] Documentação atualizada no mesmo PR
- [ ] Nenhum serviço novo sem justificativa; AppArmor e ufw ativos
- [ ] `make bench` executado (a partir do STEP 08) sem regressão > 10%
- [ ] ADR aceito para qualquer decisão estrutural
- [ ] Entrada no `CHANGELOG.md` (seção "Não lançado")
- [ ] Status atualizado aqui e em `docs/steps/README.md` no mesmo commit

**Commit sugerido:** `<tipo>(<escopo>): step 04 — laboratório de testes e baseline das referências`

**Próximo:** [STEP 05 — Rootfs mínimo reprodutível](STEP-05-rootfs-minimo-reprodutivel.md)
