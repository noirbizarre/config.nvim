--- AI-related snippets and prompts

--- TODO: make it const in LUA 5.4
local CODE_READABILITY_ANALYSIS = [[
  You must identify any readability issues in the code snippet.
  Some readability issues to consider:
  - Unclear naming
  - Unclear purpose
  - Redundant or obvious comments
  - Lack of comments
  - Long or complex one liners
  - Too much nesting
  - Long variable names
  - Inconsistent naming and code style.
  - Code repetition
  You may identify additional problems. The user submits a small section of code from a larger file.
  Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
  If there's no issues with code respond with only: <OK>
]]

return {
    -- Prompts are function to allow call time context resolution
    prompts = {
        grammar_correction = function()
            return "Correct the text to standard English, but keep any code blocks inside intact."
        end,
        keywords = function() return "Extract the main keywords from the following text" end,
        code_readability_analysis = function() return CODE_READABILITY_ANALYSIS end,
        optimize_code = function() return "Optimize the following code" end,
        summarize = function() return "Summarize the following text" end,
        translate = function() return "Translate this into Chinese, but keep any code blocks inside intact" end,
        explain_code = function() return "Explain the following code" end,
        complete_code = function() return "Complete the following codes written in " .. vim.bo.filetype end,
        add_docstring = function() return "Add docstring to the following codes" end,
        fix_bugs = function() return "Fix the bugs inside the following codes if any" end,
        add_tests = function() return "Implement tests for the following code" end,
    },
}
