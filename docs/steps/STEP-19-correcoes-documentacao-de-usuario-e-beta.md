# STEP 19 — Correções, documentação de usuário e beta

| Etapa | Status | Depende de | Anterior | Próximo |
|---|---|---|---|---|
| E4 Entrega | ⬜ Não iniciado | STEP 18 | [STEP 18](STEP-18-hardware-real.md) | Pós-beta |

1. **Objetivo:** primeira versão pública.
2. **Justificativa:** consolidar o que foi aprendido nos testes reais.
3. **Implementação:** correção dos bugs bloqueadores; documentação de usuário (instalação, primeiros passos, devsetup, Flatpak, FAQ); verificação de nome e marca; anúncio no site; canal de feedback.
4. **Arquivos:** `docs/user/`, site `BastiaOS-Site`, `CHANGELOG.md`.
5. **Dependências:** STEP 18.
6. **Comandos:** `git tag -s v0.19.0-beta.1 -m "BastiaOS beta 1"`.
7. **Conclusão:** beta publicada, verificável e documentada.
8. **Testes:** instalação feita por outra pessoa seguindo apenas a documentação.
9. **Riscos:** prometer suporte além da janela do 26.04 → declarar o suporte até 04/2029 no site.
10. **Resultado:** BastiaOS beta pública.

---

## Checklist de conclusão (trilhas contínuas)
- [ ] Critérios do item 7 cumpridos e verificados pelos testes do item 8
- [ ] Documentação de usuário completa
- [ ] `CHANGELOG.md` com a versão da beta
- [ ] Status atualizado aqui e em `docs/steps/README.md`

**Próximo:** pós-beta — ver [plano de arquitetura §4.4](../architecture/proposta-arquitetura-ubuntu.md)
