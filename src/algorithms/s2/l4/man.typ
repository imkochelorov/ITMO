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
#set raw(tab-size: 4)
#set raw(lang: "py")

#show: project.with(
  title: "Алгоритмы и Структуры Данных. Лекция 4",
  authors: (
    "_scarleteagle",
    "imkochelorov"
  ),
  date: "6.03.2024",
)

= Splay-дерево
Splay-дерево --- обычное дерево поиска, которое является сбалансированным, благодаря операции `splay`\
\
Операции Splay-дерева:
- `find(x)`
- `insert(x)`
- `remove(x)`
- `splay(x) # перестроить дерево так, чтобы x стал корнем`
#align(center)[#image("1.png", width: 45%) дерево поиска]
\
Зададим 3 преобразования дерева, поднимающие необходимый нам элемент наверх

== Преобразование дерева _зиг_

$p$ --- корень, нужно поднять $x$ --- сына $p$\
#v(0.2cm)
Повернём $(x, p)$\
#align(center)[#image("2.png", width: 80%) операция _зиг_]

== Преобразование дерева _зиг-зиг_

$x$ --- сын $p$, сына $g$, ориентация $(p, space g)$ и $(x, space p)$ совпадает.\
Поднимем $x$ на место $g$.\
#v(0.2cm)
Повернём $(p, space g)$, повернём $(x, space p)$\

#align(center)[#image("3.png", width: 100%) операция _зиг-зиг_]

== Преобразование дерева _зиг-заг_

$x$ --- сын $p$, сына $g$, ориентация $(p, space g)$ и $(x, space p)$ не совпадает.\
Поднимем $x$ на место $g$.\
#v(0.2cm)
Повернём $(x,space p)$, повернём $(x,space g)$\
#align(center)[#image("4.png", width: 100%) операция _зиг-зaг_]

== `splay(x)`

Находим $x$ в дереве, идём снизу вверх, поднимаем $x$ наверх, делая _зиг_, _зиг-зиг_ или _зиг-заг_\

#align(center)[#image("5.png", width: 15%) $T(mono("splay"))=O(H)$]

== `find(x)`
В конце `find(x)` сделаем `splay(x)`.\
$T(mono("find"))=T(mono("splay"))$\
Если мы не нашли $x$, сделаем `splay` от последней вершины, до которой дошли.

== `insert(x)`

В конце `insert(x)` делаем `splay(x)`.\
$T(mono("insert"))=T(mono("splay"))$
#v(0.2cm)
Введём ещё две операции// потому что почему бы и нет
- `merge(T1, T2)` --- $forall x in T_1, y in T_2: x < y$
- `split(x)` $--> (T_1, T_2): forall y in T_1: y <= x, forall y in T_2: y > x$

== `merge(T1, T2)`
```
def merge(T1, T2):
  x = findMax(T1)
  splay(x)
  root1.right = T2
```

== `split(x)`

```
def split(x):
  find(x)
  T2 = root.right
  T1 = root
  root.r = None
  return (T1, T2)
```

== `remove(x)`
```
def remove(x):
  find(x)
  merge(root.left, root.right)
```

== Доказательство асимптотики `splay(x)`
*Утверждение*: $tilde(T)(mono("splay"))=O(log n)$\
#v(0.2cm)
*Доказательство*: воспользуемся методом потенциалов\
#v(0.2cm)
$tilde(T)("op")=T("op") + Delta phi$\
#v(0.2cm)
$s(v)$ --- размер поддерева $v$\
#v(0.2cm)
$r(v)$ --- ранг вершины $v$\
#v(0.2cm)
$r(v) eq.def log_2 (s(v))$\
#v(0.2cm)
$phi = limits(sum)_v r(v)$\
#v(0.2cm)
*Лемма:* #rect($tilde(T) (mono("splay(x)")) <= 3 (r("root") - r(x)) + 1$)
#v(0.2cm)
+ $tilde(T)(italic("зиг"))=1+(r'(x)+r'(p)-r(x)-r(p))$, где $r'$ --- новый ранг, $r$ --- старый ранг\
  #v(0.2cm)
  $r'(p)<r(p)$\
  #v(0.2cm)
  $tilde(T)(italic("зиг"))=1+(r'(x)+r'(p)-r(x)-r(p))<=1+r'(x)-r(x)<=1+3 (r'(x)-r(x))$\
  #v(0.2cm)
  *_Итог:_* 
  $tilde(T)(italic("зиг")) <= 1 + 3 dot (r'(x) - r(x))$\
  
+ $tilde(T)(italic("зиг-зиг"))=2+(r'(x)+r'(p)+r'(g)-r(x)-r(p)-r(g))$\
  #v(0.2cm)
  $r'(x)=r(g)$\
  #v(0.2cm)
  $r(x)<=r(p)$\
  #v(0.2cm)
  $r'(p)<=r'(x)$
  #v(0.2cm)
  $tilde(T)(italic("зиг-зиг"))=2+(r'(x)+r'(p)+r'(g)-r(x)-r(p)-r(g))=2+(r'(p)+r'(g)-r(x)-r(p))<=$\
  #v(0.2cm)
  $<=2+r'(p)+r'(g)-2r(x)<=2+r'(x)+r'(g)-2r(x)$\
  #v(0.2cm)
  *Утверждение:* $2+r'(x)+r'(g)-2r(x) <= 3 (r'(x)-r(x))$\ 
  #v(0.2cm)
  *Доказательство:*\ 
  #v(0.2cm)
  $r'(x)+r'(g)-2r(x)-3r'(x)+3r(x)<=-2$\
  #v(0.2cm)
  $-2r'(x)+r'(g)+r(x) <= -2$\
  #v(0.2cm)
  _Рассмотрим:_ $(r(x)-r'(x))+(r'(g)-r'(x))$.\
  #v(0.2cm)
  $log_2 s(x)/(s'(x)) + log_2 (s'(g))/(s'(x))$\
  #v(0.2cm)
  _Заметим:_ $s'(g)+s(x) <= s'(x)$\
  #v(0.2cm)
  $underbrace((s'(g))/(s'(x)), a) + underbrace((s(x))/(s'(x)), b) <= 1$\
  #v(0.2cm)
  $a + b <= 1$\
  #v(0.2cm)
  $log_2 a + log_2 b = log_2 (a b)$\
  #v(0.2cm)
  *_Итог:_* $tilde(T)(italic("зиг-зиг")) <= 3 (r'(x) - r(x))$\
  #v(0.2cm)

+ $tilde(T)(italic("зиг-заг")) <=  3 dot (r'(x) - r(x))$ --- домашняя работа #emoji.face.happy\
*Итого:*\
#v(0.2cm)
$tilde(T)(italic("зиг")) <= 1 + 3 dot (r'(x) - r(x))$\
#v(0.2cm)
$tilde(T)(italic("зиг-зиг")) <= 3 dot (r'(x) - r(x))$\
#v(0.2cm)
$tilde(T)(italic("зиг-заг")) <=  3 dot (r'(x) - r(x))$\
\
`splay(x)`: $r(x) --> r'(x) --> r''(x) --> dots$\
#v(0.2cm)
$3 dot (r'(x) - r(x)) + 3 dot (r''(x) - r'(x)) + 3 dot (r'''(x) - r''(x)) + dots$ --- _телескопическая сумма_\
#v(0.2cm)
$3 dot (cancel(r'(x)) - r(x)) + 3 dot (cancel(r''(x)) - cancel(r'(x))) + 3 dot (r'''(x) - cancel(r''(x))) + dots$\
#v(0.2cm)
$3 dot r (root) - 3 dot r(x) + 1$

== Заключение
Splay-дерево не является каким-то _странным_ деревом. Мы не накладывали никакого дополнительного инварианта или ограничения на двоичное дерево поиска, как делали для AVL-дерева. Мы даже не рассматривали как выглядит Splay-дерево, потому что оно никак не отличается от обыкновенного дерева поиска, кроме операции `splay(x)` и может быть хоть бамбуком
