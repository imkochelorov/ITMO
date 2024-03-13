#import "../template.typ": *

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
  title: "Алгоритмы и Структуры Данных. Лекция 5",
  authors: (
    "_scarleteagle",
    //"imkochelorov", // F // ноутбук его подвел
    "AberKadaber"
  ),
  date: "13.03.2024",
)

#let make = $supset.sq$

= Декартово дерево
#quote("Мы уже рассмотрели два хороших варианта деревьев, а декартово дерево будет работать на рандом", attribution:"Михаил Первеев", block: true) 

Будем хранить:\
- `key` --- ключ (BST)\
- `priority` (По ним выполняются свойства кучи)
Вершина выглядит как `(key, priority)`

Команды:
- `insert(t, x)`
- `find(x)`
- `remove(t, x)`
- `split(t, x)`
- `merge(l, r)`

По английски это дерево называется Treap = Tree + Heap или Cartesian Tree\
По русски иногда называется:
+ Пиво = Пирамида + Дерево
+ Курево = Куча + Дерево
+ Дуча = Дерево + Куча
+ Дерамида = Дерево + Пирамида

#columns(2)[
#align(center)[#image("1.png", width: 70%) _Декартово дерево_]
#colbreak()
#align(center)[#image("2.png", width: 55%) _Декартово дерево в\ декартовой системе координат_]
]
Как балансировать?\
//как значек пусть нарисовать вроде make // make
$k_1, k_2, dots, k_n$ --- ключи\
$p_1, p_2, dots p_n$ --- случайные целые числа (попарно различные)\ \
Для начала т.к. по приоритетам выполняются свойства кучи элемент с максимальным приоритетом в корень\
Теперь разделим оставшиеся вершины на те у которых ключ меньше и те у кого ключ больше чем у корня и запустимся рекурсивно от каждого из двух получившихся множеств\
Заметим что такое построение практически такое же как сортировка QuickSort, поэтому асимптотика времени работы будет $O(n log(n))$. Также мы знаем что матожидание глубины рекурсии QuickSort $O(log(n))$, а в терминах дерева это означает что матожидание глубины дерева равна $O(log(n))$ \ \
Теперь научимся делать операции `split` и `merge`
#columns(2)[
  ```
def split(t: Node, x: int): # на L <= x, R > x
  if t is None:
    return (None, None)
  if t.key <= x:
    l, r = split(t.r, x)
    t.r = l
    return t, r
  else:
    l, r = split(t.l, x)
    t.l = r
    return (t, l)
```
#colbreak()
#align(center)[#image("3.png", width: 100%)]
]

#quote("Раньше мы проталковали в детей, теперь мы их режем на куски. Ютуб не блокируй пожалуйста", attribution:"Михаил Первеев", block: true) 

#columns(2)[
```
def merge(l: Node, r: Node) -> Node:
  if l is None:
    return r
  if r is None:
    return l
  if l.priority > r.priority:
    l.r = merge(l.r, r)
    return l
  else:
    r.l = merge(l, r.l)
    return r
```

#colbreak()
#align(center)[
#image("4.png")
]
]

#quote("Тут в чате пишут что сейчас сделаем смешную нарезку детей...", attribution:"Михаил Первеев", block: true) 

Работает за $O(log(n))$ в среднем (в средем здесь $!=$ амортизировано, а = матожидание)

\
```
def insert(t: Node, x: int):
  l, r = split(t, x)
  t = merge(merge(l, x), r)
```
Круто, работает за $O(log(n))$, но при этом константа достаточно большая, как минимум 3, а на самом деле больше

\
```
def remove(t: Node, x: int):
  m, r = split(t, x)
  l, m = split(m, x - 1)
  t = merge(l, r)
```
Круто, это тоже работает за $O(log(n))$, но опять же с большой константой

== Декартово дерево по неявному ключу

Пусть есть некоторый массив и мы хотим научиться делать на нем операции типа циклически сдвинуть\
Для этого представим его в виде декартового дерева:
+ #strike(`key`+" = индекс элемента в массиве" + `(i)`)\ `size` = размер поддерева
+ `priority`
+ `value` = значение элемента ($a_i$)

`split(x)` разделит нам дерево на два: первый с индексами от 0 $dots$ $x$, второй с индексами $x+1 space dots space n$\
После этого делаем `merge()` и все ломается\
Чтобы этого не происходило сделаем фукнцию update и вместо ключа будем хранить размер поддерева
// допиши в фукнции update везде // ?? что ты имеешь в виду//ну он сказал что перед return в merge и split надо добавить // т.к. мы update только тут вводим, лучше просто словами написать
// кста, у меня дискра через 30 минут
// ???
// мне дзшку сдать надо :( если что-то надо, допишу, только в комментариях напиши
// грустна
```
def update(t: Node)"
  t.sz = 1
  if t.l != None:
    t.sz += t.l.sz
  if t.r != None:
    t.sz += t.r.sz
```
при `merge()` произведем `update()` перед каждым `return`\ \
Теперь поменяем `split`


```
def split(t: Node, x: int):
  if t is None:
    return (None, None)
  if t.l.sz + 1 <= x:
    l, r = split(t.r, x-(t.l.sz+1))
    t.r = l
    update(t)
    return (t, r)
  else:
    l, r = split(t.l, x)
    t.l = r
    update(t)
    return (l, t)
```



#image("5.png", width: 30%)
#image("6.png", width: 30%)

Победа, теперь мы можем сделать циклический сдвиг массива, причем за $O(log(n))$\ \
```
t = None
# a_0, a_1, ... a_n
for i in range(n):
  t = merge(t, Node(a[i]))
l, r = split(t, k)
t = merge(r, l)
```
#image("7.png", width: 30%)

А еще мы умеем искать ответы на запросы на отрезке:
```
L, M = split(t, l)
M, R = split(M, r - l)
print(M.min) # здесь мы добавили поле min - минимум в поддереве
```
#image("8.png", width: 30%)

Также можно сделать и отложеные операции на отрезке\ \

Итог: мы умеем делать кучу интересных операций, даже за $O(log(n))$, но к сожалению константа достаточно большая