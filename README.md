# Line-highlight Extension For Quarto

Quarto Extension to implement source code line highlighting and output line highlighting for HTML documents (`format: html`) similar as how [`code-line-numbers`](https://quarto.org/docs/presentations/revealjs/index.html#line-highlighting) works for RevealJs output.

## Installing

```bash
quarto add shafayetShafee/line-highlight
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

Once installed, using this filter is easy. Simply add the following in your document yaml,

```
---
title: "Code Line Number(s) Highlight in html"
format: html
filters:
  - line-highlight
---
```


### Highlighting Source Line Numbers

#### Example 01

Suppose we want to highlight the second line of the following code chunk, to do that, we simply use, `source-line-numbers: "2"`.

~~~
```{r}
#| source-line-numbers: "2"

iris |> 
  head(5)
```
~~~


#### Example 02 (with source code line number)

Also, having the source code line numbered in such case would be helpful. We can do that by using source class `numberLines` (i.e. `#| class-source: "numberLines"`).

Here we have highlighted line number 2 and 6 to 7 and have also added line numbers at the left side using `numberLines` source-class.

~~~
```{r}
#| message: false
#| class-source: "numberLines"
#| source-line-numbers: "2,6-7"

# library call
library(dplyr)

# code
iris |> 
  group_by(Species) |> 
  summarize(mean(Sepal.Length))
```
~~~

## Highlighting Output Line Numbers

Highlighting output line numbers a bit tricky. To enable output line number highlighting, we need to use both output class `highlight` and `numberLines` along with `output-line-numbers`.


#### Example 01

So to highlight second line of output, we use `output-line-numbers: "2"` and `class-output: "highlight numberLines"` (Sorry couldn't make it any more easier :D :p).

~~~
```{r}
#| source-line-numbers: "1,3"
#| class-output: "highlight numberLines"
#| output-line-numbers: "2"

mtcars |> 
  summarize(
    avg_mpg = mean(mpg)
  )
```
~~~


For a complete compilable `qmd` file with these example and to see how it looks like see below. 

## Rendered Output

Here is the source code for a minimal example: [example.qmd](example.qmd) and the rendered HTML document [example.html](https://shafayetshafee.github.io/line-highllight/example.html)

