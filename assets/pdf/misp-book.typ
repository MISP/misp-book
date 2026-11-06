// MISP's PDF-only book layout. No network or Typst package imports.
#let ink = rgb("#183447")
#let accent = rgb("#007b96")
#let muted = rgb("#526879")
#let border = rgb("#d8e3e9")
#let surface = rgb("#f3f7f9")
#let part-count = counter("misp-part")

#let content-to-string(value) = {
  if value.has("text") { value.text }
  else if value.has("children") { value.children.map(content-to-string).join("") }
  else if value.has("body") { content-to-string(value.body) }
  else { "" }
}
#let two-digits(n) = if n < 10 { "0" + str(n) } else { str(n) }

// Interfaces used by Quarto's pinned Typst book filter.
#let part(title) = {
  part-count.step()
  heading(level: 1, numbering: none, supplement: [Part], title)
}
#let chapter(title, image: none, l: none) = {
  heading(level: 1, title)
  if l != none { label(l) }
}
#let appendices(title, doc, hide-parent: false) = {
  counter(heading).update(0)
  state("appendix-state", none).update(title)
  set heading(numbering: "A.1")
  doc
}

#let part-description(title) = {
  let descriptions = (
    "Getting Started": "Deployment, first use and navigation.",
    "Using MISP": "Day-to-day investigation, analysis and collaboration.",
    "Data Model & Context": "Structured observations, classification and knowledge.",
    "Sharing & Synchronisation": "Communities, trust and controlled exchange.",
    "Automation & Integration": "APIs, clients and connected workflows.",
    "Administration": "Access, operations and reliable service management.",
    "Reference & FAQ": "Practical answers and further guidance.",
  )
  descriptions.at(title, default: "")
}

#let misp-book(title: [], subtitle: [], author: "", date: "", lang: "en", contents-depth: 1, body) = {
  set document(title: title, author: author)
  set text(font: "Source Sans 3", size: 10.5pt, fill: ink, lang: lang)
  set par(justify: false, leading: 0.58em, spacing: 0.75em, first-line-indent: 0pt)
  set page(paper: "a4", margin: (left: 23mm, right: 23mm, top: 22mm, bottom: 22mm), numbering: "1",
    header: context {
      let starts = query(heading.where(level: 1)).any(h => h.location().page() == here().page())
      let before = query(selector(heading.where(level: 1)).before(here()))
      if not starts and before.len() > 0 {
        set text(size: 8pt, fill: muted)
        block(width: 100%, inset: (bottom: 5pt), stroke: (bottom: 0.4pt + border))[
          #grid(columns: (auto, 1fr), column-gutter: 12pt, [MISP USER GUIDE], align(right, before.last().body))
        ]
      }
    },
    footer: context {
      set text(size: 8pt, fill: muted)
      block(width: 100%, inset: (top: 5pt), stroke: (top: 0.4pt + border))[
        #grid(columns: (1fr, auto), [MISP Intelligence Sharing Platform], text(fill: accent, counter(page).display("1")))
      ]
    },
  )

  set heading(numbering: "1.1", supplement: [Chapter])
  show link: set text(fill: accent)
  show ref: set text(fill: accent)
  show raw: set text(font: "Source Code Pro", size: 8.5pt / 0.8)
  show raw.where(block: true): set block(fill: surface, inset: 10pt, radius: 3pt, breakable: true)
  set list(indent: 12pt, body-indent: 6pt, spacing: 4pt)
  set enum(indent: 12pt, body-indent: 6pt, spacing: 4pt)
  set terms(spacing: 8pt)
  set figure(gap: 7pt)
  show figure: set align(center)
  show figure.caption: set text(size: 8.5pt, fill: muted)
  show figure.caption: set par(justify: false, leading: 0.4em)
  set figure(numbering: n => {
    let pattern = if state("appendix-state", none).get() != none { "A.1" } else { "1.1" }
    numbering(pattern, counter(heading).get().first(), n)
  })
  set table(inset: (x: 7pt, y: 6pt), stroke: (bottom: 0.35pt + border),
    fill: (x, y) => if y == 0 { ink } else if calc.even(y) { surface } else { white })
  // Format long JSON examples between fields, preserving quoted values when copied.
  show table: it => {
    show raw.where(block: false): code => {
      if code.text.len() > 32 and code.text.starts-with("{") {
        set text(font: "Source Code Pro", size: 8.5pt)
        let quoted = false
        let escaped = false
        for char in code.text.clusters() {
          text(char)
          if escaped { escaped = false }
          else if char == "\\" and quoted { escaped = true }
          else if char == "\"" { quoted = not quoted }
          if char == "," and not quoted { linebreak() }
        }
      } else { code }
    }
    it
  }
  show table: set text(size: 9pt)
  show table: set par(leading: 0.4em, spacing: 4pt)
  show table.cell.where(y: 0): set text(fill: white, weight: "semibold")
  show heading.where(level: 2): set text(size: 17pt, weight: "semibold", fill: ink)
  show heading.where(level: 3): set text(size: 12.5pt, weight: "semibold", fill: ink)
  show heading.where(level: 4): set text(size: 11pt, weight: "semibold", fill: muted)
  show heading.where(level: 2): set block(above: 20pt, below: 9pt)
  show heading.where(level: 3): set block(above: 14pt, below: 6pt)
  show heading.where(level: 1): it => context {
    pagebreak(weak: true)
    if it.supplement == [Part] {
      block(above: 28mm, below: 18mm, width: 100%)[
        #text(size: 9pt, tracking: 1.5pt, fill: accent, weight: "semibold")[PART #part-count.display(two-digits)]
        #v(14pt)
        #text(size: 38pt, weight: "bold", it.body)
        #v(16pt)
        #rect(width: 25mm, height: 3pt, fill: accent, stroke: none)
        #v(14pt)
        #text(size: 15pt, fill: muted, part-description(content-to-string(it.body)))
      ]
      pagebreak(weak: true)
    } else {
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      block(width: 100%, above: 6mm, below: 16pt)[
        #if it.numbering != none {
          let appendix = state("appendix-state", none).get() != none
          text(size: 9pt, tracking: 1pt, weight: "semibold", fill: accent)[
            #(if appendix { "APPENDIX" } else { "CHAPTER" }) #counter(heading).display(if appendix { "A" } else { two-digits })
          ]
          v(7pt)
        }
        #text(size: 27pt, weight: "bold", it.body)
        #v(10pt)
        #rect(width: 18mm, height: 2pt, fill: accent, stroke: none)
      ]
    }
  }

  // A cover with selectable text, using the existing project logo.
  {
    set page(margin: 0pt, header: none, footer: none, numbering: none, fill: white)
    place(top, rect(width: 100%, height: 180mm, fill: ink, stroke: none))
    place(top + left, dx: 24mm, dy: 20mm,
      block(fill: white, radius: 5pt, inset: 8pt, image("../misp-2-verti.png", width: 32mm, alt: "MISP logo")))
    place(top + left, dx: 24mm, dy: 83mm, block(width: 160mm)[
      #text(size: 10pt, tracking: 2pt, weight: "semibold", fill: rgb("#70d4e6"))[USER DOCUMENTATION]
      #v(12pt)
      #text(size: 42pt, weight: "bold", fill: white, title)
      #v(14pt)
      #rect(width: 30mm, height: 3pt, fill: rgb("#24bed3"), stroke: none)
    ])
    place(top + left, dx: 24mm, dy: 199mm, block(width: 160mm)[
      #text(size: 18pt, weight: "semibold", subtitle)
      #v(12pt)
      #text(size: 11pt, fill: muted, author)
      #v(8pt)
      #text(size: 10pt, fill: muted)[Updated #date]
      #v(22pt)
      #text(size: 9pt, fill: accent, link("https://www.misp-project.org")[www.misp-project.org])
    ])
    // Absolute cover content needs a page-height anchor.
    box(height: 100%, width: 0pt)
    pagebreak()
  }
  counter(page).update(1)
  {
    show outline.entry: it => {
      let is-part = it.element.supplement == [Part]
      if is-part { v(15pt) }
      set text(size: if is-part { 11pt } else { 10pt }, weight: if is-part { "semibold" } else { "regular" }, fill: if is-part { accent } else { ink })
      block(below: 12pt, link(it.element.location())[
        #it.element.body #h(1fr) #it.page()
      ])
    }
    outline(title: [Contents], depth: contents-depth, indent: 0pt)
  }
  pagebreak(weak: true)
  body
}
