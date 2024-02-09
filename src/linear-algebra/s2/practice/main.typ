#import "../../../template.typ": *

#set page(margin: 0.55in, height: 3000pt)
#set par(leading: 0.55em, first-line-indent: 0em)
#set heading(numbering: "1.1.")
#show par: set block(spacing: 0.55em)
#show heading: set block(above: 1.4em, below: 1em)
#show heading.where(level: 1): set align(center)
#show heading.where(level: 1): set text(1.44em)
#show outline.entry.where(
  level: 1
): it => {
  v(15pt, weak: true)
  text(weight: "bold", size: 1.35em, it)
  
}

#show: project.with(
  title: "Линейная алгебра\nII семестр",
  authors: (
    "_scarleteagle",
    "imkochelorov"
  ),
  date: "зима/весна 2024",
  subtitle: "Практик: 
  Селеменчук Антон Сергеевич"
)

#let make = sym.supset.sq
#let see = $angle.spheric quad$
#let proof=par(strong("Доказательство:"))
#let sum=$limits(sum)$
#let dp(first, second)=$angle.l #first, #second angle.r$
#let def=strong("Определение:")
#let nb=par(strong("Замечание: "))
#let ex=strong("Пример: ")
#let exs=par(strong("Примеры: "))
#let dp(first, second)=$angle.l #first, #second angle.r$
#let th=strong("Теорема:")
#let proof=par(strong("Доказательство:"))
#let qed = $space qed$
#let lm=par(strong("Лемма:"))
#let apply=$space circle.small space$

#image("image.png")
// https://youtu.be/snOpRK4MNc4
// i can write literally anything in the comments and no one'll see it
// even images, if i use base64 or sth like that
// like this: blVFMHAoUk9UMTMpVVo2WWw5d28ocGxzKVRBZVlhKHJlbW92ZSlXMVltKHBhcmVudGhlc2VzKUEyckl1Rw==
// also, the other author owes me some money
// only a drink's worth, but a fact's a fact