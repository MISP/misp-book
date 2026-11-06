// PDF book presentation; keep Quarto's cross-reference/counter definitions.
#import "assets/pdf/misp-book.typ": misp-book, part, chapter, appendices

#show: misp-book.with(
$if(title)$
  title: [$title$],
$endif$
$if(subtitle)$
  subtitle: [$subtitle$],
$endif$
$if(by-author)$
  author: "$for(by-author)$$it.name.literal$$sep$, $endfor$",
$endif$
$if(date)$
  date: "$date$",
$endif$
$if(lang)$
  lang: "$lang$",
$endif$
  contents-depth: $toc-depth$,
)

// Preserve the structure Quarto's referenced-callout renderer expects.
#let callout(body: [], title: "Callout", background_color: rgb("#dddddd"), icon: none, icon_color: black, body_background_color: white) = {
  let accent = if icon_color == rgb("#0758E5") { rgb("#007b96") } else { icon_color }
  let tint = accent.lighten(94%)
  // Keep the exact title-wrapper + body-wrapper shape used by Quarto's crossrefs.
  // Labels carry the callout type; the decorative icon is omitted.
  icon = none
  block(breakable: true, fill: tint, stroke: (left: 2.5pt + accent), width: 100%, radius: 3pt,
    block(inset: 1pt, width: 100%, below: 0pt,
      block(fill: tint, width: 100%, inset: (x: 10pt, top: 8pt, bottom: 4pt))[#if icon != none [#icon ]#title]) +
    if body != [] {
      block(inset: 1pt, width: 100%, block(fill: tint, width: 100%, inset: (x: 10pt, top: 0pt, bottom: 9pt), body))
    }
  )
}

// The highlighted code renderer retains its text/tokens and can span pages.
#let Skylighting(fill: none, number: false, start: 1, sourcelines) = {
  let lines = ()
  for (i, ln) in sourcelines.enumerate() {
    if number { lines.push(text(fill: rgb("#637687"))[#(start + i) #h(6pt)]) }
    lines.push(ln)
    lines.push(EndLine())
  }
  block(width: 100%, breakable: true, fill: rgb("#f3f6f8"), stroke: (left: 1.5pt + rgb("#c6d7df")), inset: 10pt, radius: 3pt)[
    #set text(font: "Source Code Pro", size: 8.5pt)
    // Typst raw text defaults to 0.8em; keep highlighted tokens at a readable 8.5pt.
    #show raw: set text(size: 8.5pt / 0.8)
    #set par(leading: 0.4em, spacing: 0pt)
    #lines.join()
  ]
}
