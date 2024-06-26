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
  title: "Алгоритмы и Структуры Данных. Лекция 7",
  authors: (
    //"_scarleteagle",
    "imkochelorov",
    //"AberKadaber"
  ),
  date: "03.04.2024",
)

#let make = $supset.sq$

= Хэш-таблицы

*Что нам нужно от хэш-таблиц?:* 

+ Структура данных `set` --- множество уникальных элементов

  - `insert(x)` --- добавить элемент в множество, если ранее в нём его не было
  - `remove(x)` --- удалить элемент из множества, если он в нём присутствует
  - `contains(x)` --- проверить, есть ли элемент в множестве
  
+ Структура данных `map` --- отображение $k -> v$ по уникальному ключу $k$

  - `put(k, v)` --- присвоить ключ соответствующее значение
  - `remove(k)` --- удалить ключ
  - `get(k)` --- получить значение, соответствующее ключу
\
Пусть ключ (значение, в случае `set`) `x` $in$ `[0, u-1]`\  \

*Различные подходы к написанию:*\ #v(0.2cm)

*1.* `u` --- маленькое\ #v(0.2cm)
Например, хотим хранить ключи до 5. Создадим массив из 5 элементов:\ #v(0.2cm)
  #align(center)[`a = [null] * 5`]
  #columns(3)[
    `put(k, v):
  a[k] = v`
  #colbreak()
`get(k):
  return a[k]`
  #colbreak()
`remove(k):
  a[k] = null`
]
  Если известно, что все ключи не превосходят, например, миллион, то это очень хорошая реализация, каждая операция в которой работает за честную $O(1)$\
  Но, к сожалению, в жизни всё часто устроено иначе: не всегда $u$ маленькая, а иногда хочется хранить элементы сложнее чисел, например, строки, которые уже непонятно как индексировать
\ \
*2.* `u` --- большое\ #v(0.2cm)
Предположим, что мы не можем позволить себе создать массив на $u$ элементов. Например, `u` = $10^18$\
  Всё ещё хочется хранить все наши элементы в массиве, но необходимо _пожать_ наши числа, чтобы мы могли индексироваться по не очень большому массиву и хранить их\ #v(0.15cm)
  Создадим массив на $m$ элементов\ Придумаем функцию `h(x): [0, u-1]` $->$ `[0, m-1]` --- _называется хэш-функцией_\
  Первое что приходит в голову для функции `h(x) = x % m`
  #v(0.2cm)
  #columns(4)[
    #colbreak()
```py m #some const
a = [null] * m```
  #colbreak()
    `h(x):
  return x % m`
]
  #columns(3)[
    `put(k, v):
  a[h(k)] = v`
  #colbreak()
`get(k):
  return a[h(k)]`
  #colbreak()
`remove(k):
  a[h(k)] = null`
]
  #v(0.2cm)
  К сожалению, у этой реализации есть проблемы:\ #v(0.2cm)
  *Пример:*\
  #columns(2)[
  ```py m = 5 
a = [null] * 5
h(x):
  return x % 5
put(12, 8) #a[2] = 8
put(17, 5) #перезаписываем a[2], затирая старое значение
get(12) #получим 5, хотя должны были получить 8
```
#colbreak()
#v(0.0cm)
#align(center)[*Коллизия*:\
`x` $eq.not$ `y` $ quad "и" quad$ `h(x) = h(y)`] #v(0.2cm)
Довольно мерзкая ситуация, с которой нужно как-то бороться. Но по принципу Дирихле следует, что полностью побороться с коллизиями не получится и необходимо как-то научиться жить с этим
]
*3.* `u` --- большое, но теперь уживаемся с коллизиями (или почему хэш-_таблица_ называется таблицей)\ #v(0.2cm)
*Пример:*
  #table(columns: (2.2fr, 10fr),
  inset: 0pt,
  stroke: none,
  //align: horizon,
  align(left)[
```py m = 5
a = [null] * m

put(12, 8)
#a[2] = [(12, 8)]
put(17, 5)
#a[2] = [(12, 8),
#       (17, 5)]
get(12) #8
```],
[
Массив `a` после инициализации состоит из `m` `null` значений\
После добавления по ключу `12` значения `8`, `a[2] = 8` \
Перед добавлением значения по ключу `17`, видим, что в `a[2]` уже лежит значение `5`\
Исправим алгоритм и вместо хранения одного элемента в ячейке `a[2]`, будем хранить в ней список - _цепочку_ ключ-значение `[(12, 8), (17, 5)]`\
Выполняя `get(12)` получим не одно значение, а _цепочку_ вида ключ-значение, пробежавшись по которому найдём искомое по ключу значение
] 
)
  #v(0.2cm)
  #align(center)[Реализация:]
  #columns(3)[
    `put(k, v):
  h = h(k)
  for i in range(len(a[h])):
    if (a[i][0] == k):
      a[i][1] = y
  a.add((x, y))`\ #v(0.1cm)
  #colbreak()
`get(k):
  for (x, y) in a[h(k)]:
    if (x == k):
      return y
  return null`\ #v(0.1cm)
  #colbreak()
`remove(k):
  for i in range(len(a[h])):
    if (a[i][0] == k):
      a.remove(i)`\
]
  Однако такая реализация будет плохо работать с серией значений `0, m, 2 * m, 3 * m, ...`\
  Теперь ассимптотика стала $O(n)$, что ничем не лучше обыкновенного массива\
  #v(0.4cm)
  Добавим случайность в работу программы\ #v(0.1cm)
  `h(x)` --- случайная функция`: [0, u-1]` $->$ `[0, m-1]`. Существует $m^u$ таких 
  функций\ #v(0.1cm)
  Предположим, мы выбрали одну из них. Посчитаем теперь время математическое ожидание времени работы `get()`. Оно будет равно математическому ожиданию количества элементов во входных данных с одинаковым хэшом:\  #v(0.3cm)
  #align(center)[$E(T($`get()`$)) = E($количества элементов `x: h(x) = h(k)`$)$]#v(0.3cm)
  _Важный момент:_ случайность берётся только из выбора хэш-функции. Мы не считыаем, что входные данные случайны\ #v(0.3cm)
  Посчитаем вероятность того, что неравные элементы имеют одинаковый хэш (вероятность коллизий): #v(0.3cm)
  #align(center)[$ p($`h(x) = h(k)`$) = 1/m $]#v(0.3cm)
  По линейности математического ожидания посчитаем:#v(0.3cm)
  #align(center)[$E(T($`get()`$)) = E($количества элементов `x: h(x) = h(k)`$) = n dot p($`h(x) = h(k)`$) = n/m $] #v(0.3cm)
  Теперь, если мы будем выбирать случайную хэш-функцию в начале работы программы, то вне зависимости от входных данных математическое ожиидание времени работы `get()` будет равно $n/m$. \ То есть, все $n$ входных значений в среднем разбиваются поровну между $m$ нашими ячейками\ #v(0.3cm)
  #align(center)[$m tilde n: quad E(T($`get()`$)) = O(1)$] #v(0.3cm)
  Отличная структура данных, которая хорошо работает, однако есть один нюанс. Всё это время мы опирались на то, что можем выбрать сдучайную хэш-функцию. Но на самом деле не очень понятно, как мы можем это сделать. Даже непонятно, как сохранить информацию об этой функции, когда она уже будет создана. Так как возможных функций $m^k$, число бит, необходимое, чтобы сохранить информацию об одной конкретной слишком велико: #v(0.3cm)
  #align(center)[_необходимое число бит_ $= log_2(m^u) = u dot log_2(m)$] #v(0.3cm)
  Сохранить информацию о нашей функции уже проблема, не говоря о том, чтобы как-то её выбрать#v(0.3cm)
  Попробуем выбирать функцию не всех возможных существующих, а из  множества поменьше. \ Нам необходимо иметь возможность случайно её выбирать и хранить, но оставляя вероятность коллизии хэшей двух различных элементов неизменной #v(0.3cm)
  Наша хэш-функция будет выглядеть так (часто называется _Универсальное множество хэш-функций_): #v(0.3cm)
  #align(center)[`h(x) = ((a * x + b) % p) % m`\ #v(0.1cm) `a, b, p` --- параметры, выбираемые случайно\ #v(0.1cm)`0` < `a` $<$ `p` $quad$ `0` $<=$ `b` < `p` $quad$ `p` -- большое простое число (большее $m$)] #v(0.3cm)
  Теперь нашу функцию легко генерировать, рандомя 3 числа и также легко хранить. Осталось проверить, что она продолжает удовлетворять нашему свойству о вероятности коллизий:  #v(0.3cm)
  #align(center)[`x` $eq.not$ `y` $quad p($`h(x) = h(y)`$)$]#v(0.3cm) $p($`h(x) = h(y)`$) space <=> space$`((a * x + b) % p) % m = ((a * y + b) % p) % m`$quad =>$\ #v(0.1cm)  `((a * x + b) % p - (a * y + b) % p)` $dots.v$ `m`$quad =>$#v(0.1cm) `(a * x + b - a * y - b) % p` $dots.v$ `m`$quad =>$\ #v(0.1cm) `(a * (x - y)) % p` $dots.v$ `m`$quad =>$\ #v(0.1cm) `(a * (x - y)) % p = t * m`, $quad 0 <= $ `t` $<= floor(p/m)$\ #v(0.1cm) `a = t * m * (x - y)`$attach(, tr:-1)$ `(mod p)` --- относительно `a` это уравнение имеет ровно 1 решение, если `a` $eq.not$ `0`\ #v(0.1cm) $forall $ `t` $in [0, floor(p/m)] space exists!$ `a`, для которого равенство верно$quad =>$ \ #v(0.3cm) Для каждого `t` равенство верно с вероятностью $1/p$\ Существует порядка $p/m$ значений `t`\ #v(0.3cm)
  #align(center)[ $p/m dot 1/p = 1/m$]#v(0.3cm)
  #align(center)[$ p($`h(x) = h(y)`$) = 1/m, quad$для$quad$`x` $eq.not$ `y`]#v(0.3cm)
  Теперь мы умеем выбирать случайную хэш-функцию, которая удовлетворяет необходимым свойствам.\
  Вне зависимости от дальнейших входных данных, наша таблица будет работать хорошо.\
  Более того, даже если вдруг вышло, что злоумышленник угадал нашу хэш-функцию и пытается этим пользоваться, мы можем это обнаружить.\ #v(0.1cm) Для этого в процессе работы хэш-таблицы будем поддерживать размер цепочек внутри ячеек. Если он станет сильно больше $n/m$, значит всё пошло совсем плохо, и мы можем сгенерировать новую\ хэш-функцию и перестроить таблицу\ #v(0.3cm)
  *Преимущества* данного подхода:\
  
  - Максимально простая реализация

  *Недостатки* данного подхода:\

  - Всё плохо с точки зрения кэш-памяти: все наши цепочки случайно разбросаны в реальной памяти
\ \
*4.* _Хэш-таблица с открытой адресацией_\  #v(0.2cm)
В прошлой реализации мы придумали цепочки для того, чтобы уживаться с коллизиями. Побробуем обойтись без них и с хорошим процентом кэш-хитов\ #v(0.1cm)
  *Пример:*
    #table(columns: (2.2fr, 10fr),
  inset: 0pt,
  stroke: none,
  //align: horizon,
  align(left)[
```py m = 5
a = [null] * m

put(12, 8)
#a[2] = (12, 8)
put(17, 5)
#a[2] = (12, 8)
#a[3] = (17, 5)
get(12) #8
```],
[
Массив `a` после инициализации состоит из `m` `null` значений\
После добавления по ключу `12` значения `8`, `a[2] = 8` \
Перед добавлением значения по ключу `17`, видим, что в `a[2]` уже лежит значение `5`\
Изменим предыдущий алгоритм и вместо составления _цепочки_ ключ-значение в одной ячейке нашего массива, положим элемент в первую свободную ячейку справа
])
  #v(0.2cm)
  #align(center)[Реализация:]
  #columns(2)[
    #align(center)[
    ```py put(k, v):
  i = h(k)
  while (a[i] != null):
    i = (i + 1) % m
  a[i] = (k, v)```]\ #v(0.1cm)
  #colbreak()
    #align(center)[
```py get(k):
  i = h(k)
  while (a[i] != null):
    if (a[i].first == k):
      return a[i].second
    i = (i + 1) % m
  return null```]
] #v(0.2cm)
  Функция `get()` работает, так как в ней мы проходим тот же самый путь, который проходили при добавлении конкретного элемента (если добавляли его), или чуть дальше, до первого `null` значения. Но если мы добавляли элемент, то `get()` его обязательно найдёт\  #v(0.1cm)
  Однако `remove()`  реализуется не так легко, как кажется. Если создать его похожим на `get()`, то наша таблица сломается после удаления `12` в указанном примере, так как на попытку найти `17`, наша таблица скажет, что такого ключа не сущесвтует, когда он есть\ #v(0.3cm)
  *Помашем руками:*\ #v(0.1cm)
  Скажем, что мы знаем, сколько будет добавлений в таблицу и создадим её в 2 раза большую\
  Предположим, что элементы по нашей хэш-таблице расположены равномерно: после заполнения #v(0.3cm)
  #align(center)[`p(a[i] == null) =` $1/2$]#v(0.1cm)
  Если это так, то с вероятностью $1/2$ `while` совершит одну итерацию, с вероятнотью $1/4$ две итерации и тд. #v(0.3cm)
  #align(center)[$E(T($`while`$)) = limits(sum)_(i = 1)^(infinity) i/2^i = 2$]#v(0.3cm)
  Однако наше предположение, на самом деле редко выполняется на практике, что ломает нашу оценку\
  Но не смотря на это, таблица работает достаточно быстро\ #v(0.3cm)
  Хотя даже для решения этой проблемы существует модификация: будем переходить вправо не на 1\
  #columns(3)[
    #align(center)[
    ```py put(k, v):
  i = h(k)
  while (a[i] != null):
    i = (i + f(i)) % m
  a[i] = (k, v)```]\ #v(0.1cm)
  #colbreak()
    #align(center)[
```py get(k):
  i = h(k)
  while (a[i] != null):
    if (a[i].first == k):
      return a[i].second
    i = (i + f(i)) % m
  return null```]
  #colbreak()
  #align(center)[
    ```py 
    f(x):
      return a * x + b```
  ]
] #v(0.3cm)
  Однако и здесь не без проблем. Всю эту реализацию мы придумали, чтобы табличка хорошо укладывалась в кэш, но данная модификация с _прыжками_ по массиву вместо последовательного прохода усложняет хранение таблички в кэше\
  Если нам не нужно часто удалять, то это вполне хороший подход к созданию хэш-таблицы, который легко реализовывать. Но если от таблицы также нужны удаления, то, конечно, подход с цепочками является предпочтительным
