local function ensureHtmlDeps()
  quarto.doc.add_html_dependency({
  name = "line-highlight",
  version = "1.0.0",
  scripts = {
    { path = "resources/js/line-highlight.js", attribs = {defer = "true"} }
  },
  stylesheets = {"resources/css/line-highlight.css"}
})
end


local function isEmpty(s)
  return s == nil or s == ''
end


function get_lines(text)
  local lines = {}
  local code = text .. "\n"
  for line in code:gmatch("([^\r\n]*)[\r\n]") do
    table.insert(lines, line)
  end
  return lines
end


function remove_pattern(lines, pattern)
  local code_lines = {}
  for _, line in ipairs(lines) do
    if line:match(pattern) then
      local cleaned_line = line:gsub(pattern, "")
      table.insert(code_lines, cleaned_line)
    else
      table.insert(code_lines, line)
    end
  end
  return table.concat(code_lines, "\n")
end
 

-- create escaped highlight_directive_pattern
function escape_pattern(s)
  local escaped = ""
  for c in s:gmatch(".") do
    escaped = escaped .. "%" .. c
  end
  return escaped
end


function get_lines_to_ht(cb, pattern)
  if not cb.classes:includes("cell-output") then
    local lines_to_ht = {}
    pattern = pattern .. "$"
    local code_lines = get_lines(cb.text)
    for i, line in ipairs(code_lines) do
      if line:match(pattern) then
        table.insert(lines_to_ht, i)
      end
    end
    return table.concat(lines_to_ht, ",")
  end
end


local function highlight_source(line_number)
  -- adding line-number attrs for executable code blocks
  local source_highlighter = {
    CodeBlock = function(block)
      local lines_to_ht = get_lines_to_ht(block, "#<<")
      line_number = isEmpty(lines_to_ht) and line_number or lines_to_ht
      block.attributes["data-code-line-numbers"] = line_number
      block.text = remove_pattern(get_lines(block.text), "#<<$")
      return block
    end
    }
  return source_highlighter
end


local function highlight_output(line_number)
  -- adding line-number attrs for output blocks
  local output_highlighter = {
    CodeBlock = function(block)
      if block.classes:includes('highlight') then
        block.attributes["data-code-line-numbers"] = line_number
        return block
      end
    end
  }
  return output_highlighter
end


if FORMAT == "html" then
  -- ensuring dependencies for line-highlighting
  ensureHtmlDeps()
  
  -- line-highlighting for executable code blocks and output block
  function Div(el)
    if el.classes:includes('cell') then
      source_line_number = tostring(el.attributes["source-line-numbers"])
      output_line_number = tostring(el.attributes["output-line-numbers"])
      local div = el:walk(highlight_source(source_line_number))
      div = div:walk(highlight_output(output_line_number))
      return div
    end
  end
  
  -- line-highlighting for syntactically formatted markdown code blocks
  -- (i.e. for non-executable code blocks)
  function CodeBlock(cb)
    local lines_to_ht =  get_lines_to_ht(cb, "#<<")
    local line_number
    if not isEmpty(lines_to_ht) then
      line_number = lines_to_ht
    elseif cb.attributes["source-line-numbers"] then
      line_number = cb.attributes["source-line-numbers"]
    else
      line_number = ""
    end
    cb.attributes["data-code-line-numbers"] = line_number
    cb.text = remove_pattern(get_lines(cb.text), "#<<$")
    return cb
  end
end





