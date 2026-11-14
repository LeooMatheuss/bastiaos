# STEP 13 — Ambiente de desenvolvimento (`bastia-devsetup`)

| Etapa | Status | Depende de | Anterior | Próximo |
|---|---|---|---|---|
| E3 Produto | ⬜ Não iniciado | STEP 12 | [STEP 12](STEP-12-loja-de-aplicativos-flatpak-e-atualizacoes.md) | [STEP 14](STEP-14-otimizacao-de-desempenho.md) |

1. **Objetivo:** perfis de desenvolvimento sob demanda (Parte 3.2).
2. **Justificativa:** pronto para desenvolver, sem impor ferramentas.
3. **Implementação:** metapacotes `bastia-dev-*`; CLI `bastia-devsetup` (listar, instalar, remover perfis; adicionar repositórios de terceiros com `signed-by` somente sob demanda); oferta no primeiro login.
4. **Arquivos:** `src/bastia-devsetup/`, `packages/bastia-dev-*/`.
5. **Dependências:** STEP 12.
6. **Comandos:** `bastia-devsetup list`; `bastia-devsetup install web python containers`.
7. **Conclusão:** cada perfil instala, funciona (`node -v`, `docker run hello-world`, `javac -version`, `psql --version`) e remove sem resíduo.
8. **Testes:** matriz instalar → validar → remover por perfil, automatizada em VM.
9. **Riscos:** repositórios de terceiros (Docker, Microsoft, NodeSource) mudam de chave → isolar a chave por repositório e testar semanalmente no CI.
10. **Resultado:** produtividade de desenvolvimento sem inchaço.

---

## Checklist de conclusão (trilhas contínuas)
- [ ] Critérios do item 7 cumpridos e verificados pelos testes do item 8
- [ ] Documentação atualizada no mesmo PR
- [ ] Nenhum serviço novo sem justificativa; AppArmor e ufw ativos
- [ ] `make bench` executado (a partir do STEP 08) sem regressão > 10%
- [ ] ADR aceito para qualquer decisão estrutural
- [ ] Entrada no `CHANGELOG.md` (seção "Não lançado")
- [ ] Status atualizado aqui e em `docs/steps/README.md` no mesmo commit

**Commit sugerido:** `<tipo>(<escopo>): step 13 — ambiente de desenvolvimento (`bastia-devsetup`)`

**Próximo:** [STEP 14 — Otimização de desempenho](STEP-14-otimizacao-de-desempenho.md)
