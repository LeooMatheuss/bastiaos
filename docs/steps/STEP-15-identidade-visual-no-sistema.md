# STEP 15 — Identidade visual no sistema

| Etapa | Status | Depende de | Anterior | Próximo |
|---|---|---|---|---|
| E3 Produto | ⬜ Não iniciado | STEP 14 | [STEP 14](STEP-14-otimizacao-de-desempenho.md) | [STEP 16](STEP-16-instalador-calamares-e-iso-instalavel.md) |

1. **Objetivo:** aplicar a marca existente (`assets/branding/`) ao sistema.
2. **Justificativa:** identidade coesa, medida depois da otimização.
3. **Implementação:** pacote `bastia-artwork` com tema Plymouth (usando o boot splash existente), tema do GRUB, greeter do LightDM, wallpapers, tema GTK/ícones (base Greybird/Elementary-Xfce + acentos).
4. **Arquivos:** `packages/bastia-artwork/`, `assets/branding/`.
5. **Dependências:** STEP 14.
6. **Comandos:** `plymouth-set-default-theme -l`; `make iso && make bench`.
7. **Conclusão:** marca visível do GRUB ao desktop; impacto no boot ≤ 5%.
8. **Testes:** capturas automatizadas de cada tela; contraste WCAG nos temas.
9. **Riscos:** tema do GRUB e Secure Boot (o tema não afeta a assinatura); fontes com licença incompatível.
10. **Resultado:** produto com identidade própria.

---

## Checklist de conclusão (trilhas contínuas)
- [ ] Critérios do item 7 cumpridos e verificados pelos testes do item 8
- [ ] Documentação atualizada no mesmo PR
- [ ] Nenhum serviço novo sem justificativa; AppArmor e ufw ativos
- [ ] `make bench` executado (a partir do STEP 08) sem regressão > 10%
- [ ] ADR aceito para qualquer decisão estrutural
- [ ] Entrada no `CHANGELOG.md` (seção "Não lançado")
- [ ] Status atualizado aqui e em `docs/steps/README.md` no mesmo commit

**Commit sugerido:** `<tipo>(<escopo>): step 15 — identidade visual no sistema`

**Próximo:** [STEP 16 — Instalador (Calamares) e ISO instalável](STEP-16-instalador-calamares-e-iso-instalavel.md)
