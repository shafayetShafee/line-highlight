# Line-highlight Extension For Quarto

Quarto Extension to implement code line highlighting for HTML documents similar as how [`code-line-numbers`](https://quarto.org/docs/presentations/revealjs/index.html#line-highlighting) works for RevealJs output.

## Installing


```bash
quarto add shafayetShafee/line-highlight
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

Here we have highlighted the fourth line using `highlight-line-numbers: "4"` and **we must add `highlight` source-class to implement line highlighting in this chunk**


```{r}
#| class-source: "highlight"
#| highlight-line-numbers: "4"

library(dplyr)

iris |> 
  group_by(Species) |> 
  summarize(mean(Sepal.Length))
```

For a detail example, see below.

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).

