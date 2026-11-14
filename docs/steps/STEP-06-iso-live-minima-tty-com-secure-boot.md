# STEP 06 — ISO live mínima (TTY) com Secure Boot

| Etapa | Status | Depende de | Anterior | Próximo |
|---|---|---|---|---|
| E1 Sistema mínimo | ⬜ Não iniciado | STEP 05 | [STEP 05](STEP-05-rootfs-minimo-reprodutivel.md) | [STEP 07](STEP-07-empacotamento-proprio-ppa-e-bastia-base.md) |

1. **Objetivo:** ISO híbrida que boota em UEFI (com Secure Boot) e BIOS até um login em TTY.
2. **Justificativa:** valida a cadeia de boot inteira antes de adicionar o desktop.
3. **Implementação:** kernel `linux-generic-hwe-26.04` + casper; initramfs com hooks do casper; squashfs; EFI com `shimx64.efi.signed` + `grubx64.efi.signed` intactos; BIOS via `grub-pc-bin`; `xorriso` híbrido.
4. **Arquivos:** `build/iso.sh`, `iso/boot/grub/grub.cfg`, `seeds/live.list`.
5. **Dependências:** STEP 05.
6. **Comandos:**
   ```bash
   make iso
   # UEFI com Secure Boot (variante com chaves Microsoft):
   qemu-system-x86_64 -machine q35,smm=on -accel kvm -m 2G \
     -global driver=cfi.pflash01,property=secure,value=on \
     -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd \
     -drive if=pflash,format=raw,file=vars.ms.fd -cdrom out/bastiaos.iso
   ```
7. **Conclusão:** boot em UEFI+SB, UEFI sem SB e BIOS; `mokutil --sb-state` = enabled.
8. **Testes:** 10/10 boots por modo; marcador no console serial; teste automatizado no CI (log serial + timeout).
9. **Riscos:** modificar qualquer binário EFI quebra a assinatura → copiar os binários dos pacotes `*-signed` sem alteração.
10. **Resultado:** cadeia de boot completa e confiável.

---

## Checklist de conclusão (trilhas contínuas)
- [ ] Critérios do item 7 cumpridos e verificados pelos testes do item 8
- [ ] Documentação atualizada no mesmo PR
- [ ] Nenhum serviço novo sem justificativa; AppArmor e ufw ativos
- [ ] `make bench` executado (a partir do STEP 08) sem regressão > 10%
- [ ] ADR aceito para qualquer decisão estrutural
- [ ] Entrada no `CHANGELOG.md` (seção "Não lançado")
- [ ] Status atualizado aqui e em `docs/steps/README.md` no mesmo commit

**Commit sugerido:** `<tipo>(<escopo>): step 06 — iso live mínima (tty) com secure boot`

**Próximo:** [STEP 07 — Empacotamento próprio, PPA e `bastia-base`](STEP-07-empacotamento-proprio-ppa-e-bastia-base.md)
