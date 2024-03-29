#import "template.typ": *

#set page(margin: 0.4in)
#set par(leading: 0.55em, first-line-indent: 0em, justify: true)
#set text(font: "New Computer Modern")
#show par: set block(spacing: 0.55em)
#show heading: set block(above: 1.4em, below: 1em)
#show heading.where(level: 1): set align(center)
#show heading.where(level: 1): set text(1.44em)
#set page(height: auto)

#show: project.with(
  title: "Алгоритмы и Структуры Данных. Лекция 1",
  authors: (
    "_scarleteagle",
    "imkochelorov"
  ),
  date: "07.02.2024",
)

//по файлику на лекцию??
// как и было
//может не?...
// да пойдет
//поч алгосы такие особенные
// потому что лекции не связаны, куча файлов, довольно большое полотно
#set quote(block: true)

#quote("На следующей лекции будем пропихивать в детей", attribution: "Первеев Михаил Валерьевич", block: true)
= Дерево отрезков (Segment tree)
== Вступление
Пусть имеется массив 
```py a = [1 -2 5 8 7 3 6]```\
Имеются запросы вида
- l, r $->$ ```py return a[l] + a[l + 1] + ... + a[r] # преф. суммы за O(1)``` --- часто называют RSQ (Range Summ Query)
- p, x $->$ ```py a[p] = x # можем изменять наши преф. суммы за O(p), но потеряем всю скорость```
- l, r $->$ ```py return min(a[e], a[e+1], ..., a[r])``` --- часто называют RMQ (Range Minimum Query)
\
*Пример:*\
Неоходимые операции
+ ```py min(l, r)``` --- RMQ
+ ```py change(p, x)``` --- RSQ
Массив имет вид:

```py a = [2, -1, 5, 3, 0, 6, 6, -3]```\  \ Построим дерево, хранящее минимумы на отрезках:
#align(center)[#image("1.png", width: 50%) _визуальное представление дерева отрезков_]\

Обозначим, какой уровень дерева минимумы какой части массива хранит (полуинтервалами):
#align(center)[#image("2.png", width: 50%) _синим цветом выделены обозначениями_]\

Пронумеруем вершины:
#align(center)[#image("3.png", width: 50%) _красным цветом выделены нумерация_]\

Такая нумерация удобна, так как элемент с номером $v$ имеет сыновей с номерами $v dot 2 + 1$ и $v dot 2 + 2$, а также родителя с номером $floor((v-1)/2)$

#align(center)[#image("4.png", width: 50%)]\

$n + n/2 + n / 4 + n / 8 + dots + 1 < 2n$, весь массив занимает $O(n)$ памяти
\ \
== Реализация
*Рекурсивное построение дерева из массива:*\
```py 
a # исходный массив
t # дерево отрезков

def build(v, l, r): # первый запуск от корня до конца массива, строит дерево отрезков за O(n)
  if r - l == 1: # находимся в листе
    t[v] = a[l]
    return
  m = (l + r) // 2
  # запускаемся по детям
  build(v * 2 + 1, l, m) 
  build(v * 2 + 1, m, r)
  t[v] = min(t[v * 2 + 1], t[v * 2 + 2])
```

Построение дерева отрезков корректно и в случае, когда размер массива не равен степени 
#align(center)[#image("5.png", width: 50%)]\
Но необходимо быть аккуратным с нумерацией вершин, так как в худшем случае последний элемент дерева будет иметь номер $2^(k + 2)-2$, что всё ещё меньше $4 n$

\ \
*Операции изменения массива:*
```py
def change(v, l, r, p, x): # первый запуск при l = 0 и r = n, работает за O(logn)
  if r - l == 1:
    t[v] = x
    return
  m = (l + r) // 2
  if p < m:
    change(v * 2 + 1, l, m, p, x)
  else:
    change(v * 2 + 2, m, r, p, x)
  t[v] = min(t[2 * v + 1], t[2 * v + 2])
```

_Пример запроса:_\
```py change(2, -5)```
#align(center)[#image("6.png", width: 50%) _красным выделены изменённые запросом вершины_]
\ \
*Операция нахождения минимума на отрезке (RMQ):*
/*
```py
# решение от автора конспекта
def rmq(v, l, r, a, b):
  m = (l + r) // 2
  if a == l and b == r:
    return t[v]
  if b <= m:
    return rmq(v * 2 + 1, l, m, a, b)
  elif a >= m:
    return rmq(v * 2 + 2, m, r, a, b)
  else:
    return min(rmq(v * 2 + 1, l, m, a, m), rmq(v * 2 + 2, m, r, m, b)
```*/
```py
MAX_INT = 1e12
def get(v, l, r, ql, qr):
  if ql >= r or qr <= l:
    return MAX_INT
  if ql <= l and r <= qr:
    return t[x]
  m = (l + r) // 2
  return min(get(v * 2 + 1, l, m, ql, qr), get(v * 2 + 1, m, r, ql, qr))
```
//Рекуррента второго решения: $T(n) = 2T(n/2)+O(1)$
#quote("Что такое плюс бесконечность в коде сами разбирайтесь, у меня доска, мне пофиг", attribution: "Первеев Михаил Валерьевич", block: true)

//#quote("Почему оно работает? Да вроде понятно же", attribution: "Отчисленный по парадигмам", block: true)

*Для оценки времени работы докажем несколько фактов:*
1. $forall [q l, space q r)$ можно разбить на $<= 2 dot log_2 n$ вершин в дереве отрезков
_Доказательство:_\ #strike[очевидно]\ \
2. Функция get делает $<= 4 dot log_2 n$ рекурсивных вызовов
_Доказательство:_\
1) База: корень --- 1, вызов 1 < 4\
2) Переход: $n->n+1$: т.к. у отрезка 2 конца, "худших случаев" может быть не более 2, поэтому $<= 4$ рек. вызовов $=> space <= 4$ рек. вызовов
\ \
Созданная нами структура легко изменяема для выполнения запросов с любыми другими функциями, имеющими нейтральный элемент, свойства ассоциативности и "_аддитивности_"

//#quote("База - это корень, а корень это база", attribution: "Миша A4")
//#quote("Плохо, когда у вас 2 сына", attribution: "Ми Хаил")

// первеев пропихивает в детей смотреть онлайн бесплатно без смс и регистрации
// (название waiting room следующей лекции)
// качетсов конспектов, если бы мы вместо написания шуток, actually писали бы конспект

== Напоследок
*Задача:*\ 
Дан массив. Необходимо уметь менять элемент и находить самый левый элемент, не превосходящий $x$
*Решение:*\
Построим ДО на минимум. Смотрим минимум слева от половины. Если он больше $x$, то ответ в левой половине, иначе пойдем направо.
