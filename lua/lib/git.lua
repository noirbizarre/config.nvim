--- Some helpers to interact with git

local M = {}

--- Resolve the shared root directory of the current git repository.
--- For worktrees (including the bare sibling layout) this is the directory
--- containing the common `.git`, so every worktree resolves to the same path.
--- Returns nil when not inside a git repository.
---@param path? string directory to resolve from (defaults to cwd)
---@return string?
function M.root(path)
    local cmd = { "git", "rev-parse", "--path-format=absolute", "--git-common-dir" }
    local obj = vim.system(cmd, { text = true, cwd = path or vim.uv.cwd() }):wait()
    if obj.code ~= 0 then
        return nil
    end
    local common = vim.trim(obj.stdout)
    if common == "" then
        return nil
    end
    return vim.fs.dirname(vim.fs.normalize(common))
end

--- Resolve the project-local notes directory:
--- `<git root>/.local/notes`, or `<cwd>/.local/notes` when not in a repo.
---@param path? string
---@return string
function M.notes_dir(path)
    local base = M.root(path) or vim.fs.normalize(vim.uv.cwd())
    return base .. "/.local/notes"
end

return M
