 #import "template.typ": *

#set page(margin: 0.4in)
#set par(leading: 0.55em, first-line-indent: 0em)
#set text(font: "New Computer Modern")
#show par: set block(spacing: 0.55em)
#show heading: set block(above: 1.4em, below: 1em)
#show heading.where(level: 1): set align(center)
#show heading.where(level: 1): set text(1.44em)
#set page(height: auto)
#set page(numbering: none)

#show: project.with(
  title: "Алгоритмы и Структуры Данных. Лекция 3",
  authors: (
    "_scarleteagle",
    "imkochelorov"
  ),
  date: "21.02.2024",
)

#set raw(tab-size: 4)
#set raw(lang: "py")

= Двоичное дерево поиска (BST)

*Введение:*\
Реализуем структуру данных set
- `insert(x)` --- добавить в множество элемент, если ранее его в нём не было
- `find(x)` --- проверить, есть ли число в множестве
- `remove(x)` --- удалить элемент из множества, если он в нём присутствует

*Инвариант дерева:*\

#columns(2)[
#align(center)[#image("1.png", width: 40%)
$forall y in L quad y < x$\
$forall y in R quad y > x$ \ ]
#colbreak()
#align(center)[#image("2.png", width: 70%) _Пример двоичного дерева поиска_]]

*Реализация операций:*
#columns(2)[
#align(center)[#image("4.png", width: 70%) _работа `insert(7)` на дереве из примера_]
#colbreak()
#align(center)[#image("3.png", width: 100%) _3 случая работы `remove(x)`_]]

Визуализация работы `find(x)` представляется очевидной

```
class Node:
  def __init__(self, key: int):
    self.key = key
    self.l = None
    self.r = None
```
`find(x)`: очевидно\
`insert(x)`: достаточно визуального описания\
`remove(x)`:
- Если `x` лист, то удаляем `x`
- Если у `x` один сын, то заменяем `x` на сына
- Если у `x` два сына, то идем до конца в правого сына (самая большая вершина в поддереве), перекинем его вместо `x` и удалим его на исходном месте одним из 2 предыдущих способов

Асимптотика операций: $O(h)$, где $h$ --- высота дерева.\
Что грустно, так как в худшем случае мы получим дерево вида "бамбук" с высотой равной числу всех элементов

// "если у нас 2 сына, то все плохо"
// "какая следующая буква после y? пусть будет t."

== Сбалансированное двоичное дерево. AVL-дерево

_by_ Адельсон-Вельский & Ландис (1962)\ #v(0.2cm)
Сбалансированное двоичное дерево --- $h = O(log n)$\ #v(0.2cm)

*Инвариант:* $forall v quad abs(h(v.l) - h(v.r)) <= 1$ 
#v(0.2cm)
#columns(2)[
Пусть $f(h)$ --- $min$ возможное кол-во вершин с высотой $h$\ #v(0.2cm)
$f(0) = 0$\ #v(0.2cm)
$f(1) = 1$\ #v(0.2cm)
$f(h) = f(h - 1) + f(h - 2) + 1$\ #v(0.2cm)
$f(h) >= F_h tilde phi^h$\ #v(0.2cm)
$f(h) = Omega(phi^h)$ \ #v(0.2cm)
$h = O(log n)$
#colbreak()
#align(center)[#image("5.png", width: 40%) _$h(v)$ считается с учётом вершины начала и вершины конца поддерева_]
]

_Поворот ребра_:\

#columns(2)[
```
def rotateRight(v, p):
  A = v.l
  B = v.r
  C = p.r
  par = p.p
  p.l = B
  B.p = p
  v.r = p
  p.p = v
  v.p = par
  if par.l = p:
    par.l = v
  else:
    par.r = v
```
$h(v) = max(h(v.l), h(v.r)) + 1$
#colbreak()
#align(center)[#image("6.png", width: 100%) _Визуализация поворота вершины_]
]


\
Поворотов вершин достаточно, чтобы сохранять инвариант AVL-дерева. Для реализации этого будем смотреть, у какой вершины сломался инвариант \ 
После вставки или удаления вершины, пройдёмся снизу-вверх, проверяя инвариант вершин. Пусть $p$ --- первая вершина, в которой сломался инваривант:\
#align(center)[#image("7.png", width: 30%) $h(v) - h(A) = 2$]
_Рассмотрим случаи добавления в дерево:_\
#columns(3)[
*1)* $h(u) = h(D) = h-2$\
Повернём $(p, v)$\
#align(center)[#image("8.png", width: 90%)]
#colbreak()
*2)* $h(u) = h-2, space h(D) = h-3$\
Повернём $(u, v)$\
Повернём $(p, u)$
#align(center)[#image("9.png", width: 90%)]
#colbreak()
*3)* $h(u) = h-3, space h(D) = h-2$\
Повернём $(p, v)$

]
