--- Avante prompts
local avante = {}

-- NOTE: most templates are inspired from ChatGPT.nvim -> chatgpt-actions.json
avante.grammar_correction = 'Correct the text to standard English, but keep any code blocks inside intact.'
avante.keywords = 'Extract the main keywords from the following text'
avante.code_readability_analysis = [[
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
avante.optimize_code = 'Optimize the following code'
avante.summarize = 'Summarize the following text'
avante.translate = 'Translate this into Chinese, but keep any code blocks inside intact'
avante.explain_code = 'Explain the following code'
avante.complete_code = 'Complete the following codes written in ' .. vim.bo.filetype
avante.add_docstring = 'Add docstring to the following codes'
avante.fix_bugs = 'Fix the bugs inside the following codes if any'
avante.add_tests = 'Implement tests for the following code'

return {
    avante = avante,
}
