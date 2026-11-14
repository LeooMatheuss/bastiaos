# STEP 03 — Infraestrutura de build

| Etapa | Status | Depende de | Anterior | Próximo |
|---|---|---|---|---|
| E0 Fundação | ⬜ Não iniciado | STEP 02 | [STEP 02](STEP-02-governanca-e-documentacao-do-repositorio.md) | [STEP 04](STEP-04-laboratorio-de-testes-e-baseline-das-referencias.md) |

1. **Objetivo:** ambiente de build idêntico localmente e no CI.
2. **Justificativa:** os entregáveis da Phase 0 não estão no repositório; sem builder fixado não há reprodutibilidade.
3. **Implementação:**
   - `ci/Dockerfile.builder` a partir de `ubuntu:26.04@sha256:<digest>` com mmdebstrap, squashfs-tools, xorriso, grub-efi-amd64-signed, shim-signed, mtools.
   - `Makefile` como ponto de entrada único.
   - `tools/validate-env.sh`.
   - CI com lint (shellcheck), docs e build do builder.
4. **Arquivos:** `Makefile`, `ci/`, `tools/`, `.github/workflows/ci.yml`.
5. **Dependências:** STEP 02.
6. **Comandos:**
   ```bash
   docker pull ubuntu:26.04 && docker inspect --format '{{index .RepoDigests 0}}' ubuntu:26.04
   make builder && make lint && make docs
   ```
7. **Conclusão:** `make builder` reprodutível (mesmas versões de pacotes em dois builds); CI verde.
8. **Testes:** `docker run --rm bastia-builder:dev mmdebstrap --version`; `bats tests/unit`.
9. **Riscos:** base de imagem por tag flutuante → usar sempre digest.
10. **Resultado:** fundação de build confiável.

---

## Checklist de conclusão (trilhas contínuas)
- [ ] Critérios do item 7 cumpridos e verificados pelos testes do item 8
- [ ] Documentação atualizada no mesmo PR
- [ ] Nenhum serviço novo sem justificativa; AppArmor e ufw ativos
- [ ] `make bench` executado (a partir do STEP 08) sem regressão > 10%
- [ ] ADR aceito para qualquer decisão estrutural
- [ ] Entrada no `CHANGELOG.md` (seção "Não lançado")
- [ ] Status atualizado aqui e em `docs/steps/README.md` no mesmo commit

**Commit sugerido:** `<tipo>(<escopo>): step 03 — infraestrutura de build`

**Próximo:** [STEP 04 — Laboratório de testes e baseline das referências](STEP-04-laboratorio-de-testes-e-baseline-das-referencias.md)
