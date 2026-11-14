# STEP 07 — Empacotamento próprio, PPA e `bastia-base`

| Etapa | Status | Depende de | Anterior | Próximo |
|---|---|---|---|---|
| E1 Sistema mínimo | ⬜ Não iniciado | STEP 06 | [STEP 06](STEP-06-iso-live-minima-tty-com-secure-boot.md) | [STEP 08](STEP-08-ambiente-grafico-xfce-minimo.md) |

1. **Objetivo:** toda personalização do BastiaOS distribuída como pacote `.deb` atualizável.
2. **Justificativa:** configuração solta na imagem não recebe atualização; pacote recebe (correção de ordem nº 1).
3. **Implementação:**
   - PPA no Launchpad (`ppa:<equipe>/bastiaos`).
   - Pacote `bastia-base` com: `/etc/os-release` (`ID=bastiaos`, `ID_LIKE=ubuntu`), fonte APT da Mozilla com pin 1000, pins `-1` para os pacotes de transição snap, remote Flathub, ufw com entrada negada, drop-ins do journald.
   - Validação Firefox rapid-release × ESR em 26.04.
4. **Arquivos:** `packages/bastia-base/debian/`, `packages/bastia-base/etc/apt/preferences.d/`.
5. **Dependências:** STEP 06.
6. **Comandos:**
   ```bash
   cd packages/bastia-base && debuild -S -sa && dput ppa:<equipe>/bastiaos ../bastia-base_*_source.changes
   lintian --pedantic ../*.changes
   ```
7. **Conclusão:** ISO instala `bastia-base` do PPA; `apt install firefox` traz o deb da Mozilla; `apt install chromium-browser` **não** instala snapd silenciosamente.
8. **Testes:** `apt-cache policy firefox`; `apt install -s chromium-browser`; `lsb_release -a` e `os-release` corretos; o upgrade do pacote preserva arquivos editados pelo usuário (conffiles).
9. **Riscos:** usar `ID=ubuntu` quebra a identidade; usar `ID=bastiaos` sem `ID_LIKE=ubuntu` quebra scripts de terceiros → manter os dois campos.
10. **Resultado:** política de pacotes da distribuição viva e atualizável.

---

## Checklist de conclusão (trilhas contínuas)
- [ ] Critérios do item 7 cumpridos e verificados pelos testes do item 8
- [ ] Documentação atualizada no mesmo PR
- [ ] Nenhum serviço novo sem justificativa; AppArmor e ufw ativos
- [ ] `make bench` executado (a partir do STEP 08) sem regressão > 10%
- [ ] ADR aceito para qualquer decisão estrutural
- [ ] Entrada no `CHANGELOG.md` (seção "Não lançado")
- [ ] Status atualizado aqui e em `docs/steps/README.md` no mesmo commit

**Commit sugerido:** `<tipo>(<escopo>): step 07 — empacotamento próprio, ppa e `bastia-base``

**Próximo:** [STEP 08 — Ambiente gráfico Xfce mínimo](STEP-08-ambiente-grafico-xfce-minimo.md)
