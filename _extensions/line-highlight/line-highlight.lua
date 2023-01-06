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


function highlight(line_number)
  local highlighter = {
    CodeBlock = function(block)
      if block.classes:includes('highlight') then
        block.attributes["data-code-line-numbers"] = line_number
        return block
      end
    end
    }
  return highlighter
end


function Div(el)
  if FORMAT == 'html' then
    ensureHtmlDeps()
    if el.classes:includes('cell') then
      line_number = tostring(el.attributes["highlight-line-numbers"])
      return el:walk(highlight(line_number))
    end
  end
end