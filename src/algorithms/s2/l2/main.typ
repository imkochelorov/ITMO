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
  title: "Алгоритмы и Структуры Данных. Лекция 2",
  authors: (
    "_scarleteagle",
    "imkochelorov"
  ),
  date: "14.02.2024",
)

= Дерево отрезков. Отложенные операции

*Операции:*
- ```py get(l, r) #min(a_l, a_l+1, ..., a_r+1)```
- ```py add(l, r, x) #O(log n)
  #a_l += x
  #a_l+1 += 1
  #...
  #a_r-1 += x```
Как выполнить операцию над отрезком за $O(log n)$, если отрезок в худшем случае имеет длину $O(n)$

#align(center)[#image("1.png", width: 50%) _дерево отрезков_]\
*Ленивые/отложенные операции (Lazy operations)*\
Вместо того, чтобы рекурсивно изменять детей, будем хранить, что в вершине результат правильный, а в детях нужно добавить #text("N", fill: blue). Когда будет запрос на ребёнка, проталкиваем изменения в обоих детей
#align(center)[#image("2.png", width: 50%) _дерево отрезков после вызова _```py add(1, 6, 3)```]\
\
#align(center)[#image("3.png", width: 50%) _дерево отрезков после вызова _```py add(2, 5, -1)```]\
*Инвариант дерева:*
+ На выходе значение корректное
+ ```py pr[v]``` хранит, сколько прибавить ко всем детям (не считая текущую вершину)
// pr = promise
```py
def add(v, l, r, ql, qr, x):
  if (qr <= l or r <= ql):
    return
  if (ql <= l and r <= qr):
    tree[v] += x
    pr[v] += x
    return
  m = (l + r) // 2
  push(v)
  add(2 * v + 1, l, m, ql, qr, x)
  add(2 * v + 2, m, r, ql, qr, x)
  tree[v] = min(tree[2 * v + 1], tree[2 * v + 2])

def push(v):
  if (pr[v] == 0):
    return
  tree[2 * v + 1] += pr[v]
  tree[2 * v + 2] += pr[v]
  pr[2 * v + 1] += pr[v]
  pr[2 * v + 2] += pr[v]
  pr[v] = 0

MAX_INT = 1e12
def get(v, l, r, ql, qr):
  if ql >= r or qr <= l:
    return MAX_INT
  if ql <= l and r <= qr:
    return tree[x]
  push(v)
  m = (l + r) // 2
  return min(get(v * 2 + 1, l, m, ql, qr), get(v * 2 + 1, m, r, ql, qr))
```

\
_Наше дерево легко превратить в дерево на сумму:_
\ ```py
def add(v, l, r, ql, qr, x):
  if (qr <= l or r <= ql):
    return
  if (ql <= l and r <= qr):
    tree[v] += x * (r - l)
    pr[v] += x
    return
  m = (l + r) // 2
  push(v)
  add(2 * v + 1, l, m, ql, qr, x)
  add(2 * v + 2, m, r, ql, qr, x)
  tree[v] = sum(tree[2 * v + 1], tree[2 * v + 2])

def push(v):
  if (add[v] == 0):
    return
  tree[2 * v + 1] += pr[v] * (m - l)
  tree[2 * v + 2] += pr[v] * (r - m)
  pr[2 * v + 1] += pr[v]
  pr[2 * v + 2] += pr[v]
  pr[v] = 0

def get(v, l, r, ql, qr):
  if ql >= r or qr <= l:
    return 0
  if ql <= l and r <= qr:
    return tree[x]
  push(v)
  m = (l + r) // 2
  return sum(get(v * 2 + 1, l, m, ql, qr), get(v * 2 + 1, m, r, ql, qr))
```
\ \
Суть отложенных операций в том, чтобы выполнять их не когда они пришли, а когда возникла необходимость
#quote("Зачем готовиться к экзамену по матану с сентября, если можно начать готовиться за 2 дня до него", attribution: "Первеев Михаил Валерьевич", block: true)
Попробуем сделать более тяжёлую операцию. Например, прибавление арифметической прогрессии
```py
add(l, r, x, d)
  #a_l += x
  #a_l+1 += x+d
  #a_l+2 += x+2d
  #...
  #a_r-1 += x+d*(...)
```
Сумма арифметических прогрессий --- арифметическая прогрессия\ \
$x_1 + x_2, d_1 + d_2 <=> cases(x_1 quad d_1, x_2 quad d_2)$\

#align(center)[ #image("4.png", width: 30%) _отрезок добавления арифметической прогрессии_] \
Дерево отрезков на сумму с добавлением арифметической прогрессии возможно. На минимум --- нет.
\ \
*Задача:*\ Даны прямоугольники и точки. Найти сколькими прямоугольниками покрывается точка\

#align(center)[#image("5.png", width: 40%) _пример прямоугольников и точек_]\
Точки: $(x, y)$\
Прямоугольники: $(x_1, y_1), (x_2, y_2)$\
$0 <= x_i, y_i <= c$\
*Сканирующая прямая:*\
#align(center)[#image("6.png", width: 40%) _для каждой координаты линии по y вычисляем сколькими прямоугольниками она покрывается_]\
*События:* границы прямоугольника, точки.\
Если дано n прямоугольников, m точек, то событий --- 2n+m.\
Сортируем события по x-координате, затем в порядке "начало, точка, конец"\ \
Проходим по событиям
- Если встречаем левую границу, то на отрезке $[y_1, y_2]$ добавляем 1.\
- Если встречаем левую границу, то на отрезке $[y_1, y_2]$ вычитаем 1.\
- Если встречаем точку, то выводим значение на $y$.

#align(center)[#image("7.png", width: 40%) _пример линий на каждое событие_]\
*Время работы*:\
- Сортировка: $O((n + m) log (n + m))$
- Обработка событий: $O((n + m) log C)$
*Память*: $O(C)$\
_Сжатие координат:_ отсортируем y-координаты и перенумеруем. $C -> O(n + m)$
