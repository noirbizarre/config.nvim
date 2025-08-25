Agent Quick Reference (keep ~20 lines)
1. Build/Install: Use lazy.nvim (init.lua). Run: nvim +"Lazy sync" +qa to sync plugins. Update lock: nvim +"Lazy lock" +qa.
2. Lint/Format: Pre-commit provides trailing-whitespace, eof-fixer, check-yaml, Stylua. Run all: pre-commit run -a. Format Lua: stylua .  (config stylua.toml: width 120, indent 4 spaces, collapse_simple_statement=FunctionOnly). EditorConfig: 4-space indent (yaml/json:2), LF endings, utf-8, final newline, keep trailing spaces unless hook trims.
3. Tests: Uses neotest + adapters (pytest, jest, go, busted, rust). From inside nvim: Run nearest: <leader>tn, file: <leader>tf, last: <leader>tl, stop: <leader>tS. CLI single python test: pytest path/to/test_file.py::TestClass::test_name. Jest: npx jest path/to/file -t "test name". Go: go test ./... or go test ./pkg/xyz -run TestName.
4. Debug tests: add DAP via capital variants (<leader>tN / tF / tL).
5. LSP: Enabled servers (see lua/plugins/lsp.lua): basedpyright (type checking standard), ruff, lua_ls, jsonls (schemastore), yamlls (yaml-companion), etc. Avoid committing generated/large dirs: node_modules, .yarn, target, .venv.
6. Imports/Requires: Group std libs first, then third-party plugins, then local (lib.*, plugins.*). Use local var for require result (local mod = require("mod")). Avoid global pollution; add intentional globals in .luarc.json.
7. Types/Annotations: Use EmmyLua/LuaLS annotations (---@param, ---@return, ---@class) for public helpers; keep concise.
8. Naming: snake_case for locals/functions, PascalCase for classes/tables acting as namespaces, ALL_CAPS for immutable constants. Module tables named M returned at end.
9. Error handling: Prefer early return; use assert or vim.validate for programmer errors; surface user-facing issues via vim.notify with appropriate level.
10. Diagnostics: Severity-sorted; rely on LSP signs configured in plugins/lsp.lua; do not override globally unless needed.
11. Performance: Avoid heavy work in top-level plugin specs; defer via config/functions and filetype events.
12. Secrets: Centralize secret access in lua/lib/secrets.lua (if created); never commit real tokens; use placeholders.
13. Adding a plugin: Place spec under lua/plugins; keep feature vs language separation; pin versions via lazy-lock.json; run Lazy lock after changes.
14. Refactors: Run pre-commit & tests before commit. Ensure stylua clean. Keep functions < ~50 LOC; extract UI helpers into lib/ui.
15. Git hygiene: small commits; no trailing debug prints. Commit message: imperative, short summary (<=72 chars).
16. No Cursor/Copilot rule files detected; if added, summarize them here.
17. Neovim minimum version helper in lib/system.lua (M.isNeovimVersionsatisfied); use it before version-specific code.
18. Avoid watching large dirs (already excluded in lsp.lua); keep additions consistent.
19. When in doubt, search existing patterns (grep for similar code) and mirror style.
20. Always keep this file concise; expand only with new enforced conventions.
