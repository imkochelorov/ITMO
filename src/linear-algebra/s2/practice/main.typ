#import "../../../template.typ": *

#show par: set block(spacing: 0.55em)
#set page(margin: 0.55in, height: auto)
#set par(leading: 0.75em, first-line-indent: 0em, justify: false)
#set text(font: "New Computer Modern")
#set heading(numbering: "1.1.")
#show raw: set text(font: "New Computer Modern Mono")
#show par: set block(spacing: 0.55em)
#show heading: set block(above: 1.4em, below: 1em)
#show heading.where(level: 1): set align(center)
#show heading.where(level: 1): set text(1.44em)
#set quote(block: true, attribution: "Москаленко Мария Александровна")
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
    "imkochelorov",
    "AberKadaber"
  ),
  date: "весна 2024",
  subtitle: "Практик: 
  Мария Александровна Москаленко"
)

#let make = sym.supset.sq
#let see = $angle.spheric quad$
#let proof=par(strong("Доказательство:"))
#let sum=$limits(sum)$
#let product=$limits(product)$
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
#let apply=$op(circle.small)$
#let tens=$op(times.circle)$

#let hla(body) = text(fill: red)[#body]
#let hlb(body) = text(fill: purple)[#body]
#let hlc(body) = text(fill: eastern)[#body]


#outline(title: "Оглавление", indent: auto)
#pagebreak()
//#quote("Давайте поиграем в решение задач", attribution: "Мария Александровна Москаленко", block: true)

= Тензоры

Тензор - значение ПЛФ на всех наборах базисных векторов\ \
_Зачем нам тензоры?_\
Тензоры инвариантны _(константны)_\
Фактически, тензор --- матричное представление полилинейной формы\
// Например в криволинейных координатах
\ 
*Пример тензора:*\ \
$Epsilon = display(mat(augment: #(vline: (3, 6)),
0, 0, 0, 0, 0, -1, 0, 1, 0;
0, 0, 1, 0, 0, 0, -1, 0, 0;
0, -1, 0, 1, 0, 0, 0, 0, 0)) 
$ \ \
Ранг тензора _определён строго_ -- он равен 3\
Валентность тензора _однозначно определить нельзя_:
(3, 0), (2, 1), (1, 2), (0, 3) --- возможные её значения\ \
Обозначение $epsilon_(i j k): i - "строка", space  j - "столбец" space k - "слой"$\ \
$(3, space 0) <--> epsilon_(i j k)$\ \
$(2, space 1) <--> epsilon_(i j)^k$\ \
$(1, space 2) <--> epsilon_(i)^(j k)$\ \
$(0, space 3) <--> epsilon^(i j k)$\ \
// а что это мы нащли? что такое B&
// Ну это сы взяли один тензор и умножили на как я понял
// Типа свертку сдалли
\ 
$make a = (0 space 1 space 1)^T$\ \
$b_(j k) = epsilon_(i j k) a^i$ -- внутри происходит немое суммирование Эйнштейна\ \
$b_11 = epsilon_(1 1 1)a^1 + epsilon_(2 1 1) a^2 + epsilon_(3 1 1) a^3$
\ \
$B = display(mat(
0, 1, -1;
-1, 0, 0;
1, 0, 0)) 
$
\ \
== Свёртка индексов:
\ \
$ A = display(mat(augment: #(hline: 2, vline: 2),
1, 2,  3, 4;
-4, -3,  -2, -1;
-4, -3,  -2, -1;
5, 6,  7, 8)) = ||a^(i j)_(k l)|| $
#align(center)[_i --- локальная строка, j --- локальный столбец, k --- глобальная строка, l --- глобальный стобец_] // я понял по 3 дефиса
\
Будем считать что это тензор четвертого ранга, валентности (2, 2)\ \
$a_(h l)^(h j) = b_(l)^(j)$\ \
$b_l^j = sum_h a^(h j) _ (h l) = a ^(1 j)_(1 l)+ a^(2 j)_(2 l)$ \ \
$b_1^1 = a^(1 1)_(1 1) + a^(2 1) _ (2 1) = 6$\ \
$b_1^2 = a^(1 2)_(1 1) + a^(2 2) _ (2 1) = 10$\ \
$dots$ \ \
$B = display(mat(
6, 10;
8, 12))$
\ \
*Тензорное произведение:*
\ \
$A - "ПЛФ валентности" (1, 0) <--> a=(1, -1, 0)$\ \
$B - "ПЛФ валентности" (2, 0) <--> b = display(mat(
1, 2, 3;
4, 5, 6;
7, 8, 9)) 
$
\ \
// я хз как буквы над буквами писать
$limits(a)^alpha times.circle limits(b)^beta = limits(c)^gamma$\ \
$(alpha_i) times.circle (beta_(j k)) = gamma_(i j k)$ \ \
$gamma_231 = alpha_2 dot beta_31$\ \
$C = display(mat(augment: #(vline: (3, 6)),
1, 4, 7, 2, 5, 8, 3, 6, 9;
0, 0, -7, -2, -5, -8, -1, 0, 0;
0, -1, 0, 1, 0, 0, 0, 0, 0)) 
$ \ \
*Следующий пример:*
\ \
$A(2, 0) <--> a = display(mat(
1, -1;
-1, 1)) $\ \
$A(1, 1) <--> b = display(mat(
1, 1;
1, 2)) $\ \
$c = a times.circle b $
$ (alpha_(i j)) times.circle (beta_l^k) = gamma_(i j l)^k $
#align(center)[_Нумерация сверху вниз, слева направо: \ k --- локальная строка, i --- локальный столбец, j --- глобальная строка, l --- глобальный стобец_]
\
// нахера
// кажется так лучше
// нуууу хзхз
$C = display(mat(augment: #(hline: 2, vline: 2),
1, -1, 1, -1;
1, -1, 2, -2;
dots, dots, dots, dots;
dots, dots, dots, dots)) $ \ \


*Следующий пример:*
\ \
Индекс сферху = форма = горизонтальные координаты\ \
Индекс снизу = вектор = вертикальные координаты\ \
$a^1 = (1, 0, 0)$\
$a_2 = (0, 1, 0)^T = display(vec(0, 1, 0))$\ \
$a_3 = (0, 0, 1)^T = display(vec(0, 0, 1))$\ \
$b = a^1 times.circle a_2 times.circle a_3$\ \
$beta_(i k) ^ j = (psi^j) times.circle (zeta_i) times.circle (eta_k)$
\ \ $b = display(mat(augment: #(vline: (3, 6)),
0, 0, 0, 0, 0, 0, 0, 1, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0)) 
$\ \ // имба // полезно

== Транспонирование тензора:
\ \
_Двумерное сечение --- двумерная матрица, в которой зафиксированы все индексы, кроме 2 конкретных_\ \
Транспонирование тензора --- операция, результатом которой 
\ \
$A_(i k l) ^ (T (k l)) = A_(i l k)$\ \
$A$ --- валентность (3, 0) $<--> a = display(mat(augment: #(vline: (3, 6)),
#text(fill: red)[1], #text(fill: purple)[3], #text(fill: eastern)[2], #text(fill: red)[7], #text(fill: purple)[8], #text(fill: eastern)[9], #text(fill: red)[4], #text(fill: purple)[6], #text(fill: eastern)[5] ; // 00%
9, 7, 8, 3, 1, 2, 6, 4, 5;
4, 2, 3, 8, 6, 7, 1, 9, 5)) $\ \
$b_(i j k) = a_(i k l)$\ \
$make i = 1 => b_(j k) = a_(1 j k) = display(mat(
#text(fill: red)[1], #text(fill: red)[7], #text(fill: red)[4] ;
#text(fill: purple)[3], #text(fill: purple)[8], #text(fill: purple)[6] ;
#text(fill: eastern)[2], #text(fill: eastern)[9], #text(fill: eastern)[5])) 
=> a_(1 k j) = display(mat(
#text(fill: red)[1], #text(fill: purple)[3], #text(fill: eastern)[2] ;
#text(fill: red)[7], #text(fill: purple)[8], #text(fill: eastern)[9] ;
#text(fill: red)[4], #text(fill: purple)[6], #text(fill: eastern)[5])) $\ \ \
$make i = 2 => b_(j k) = dots$\ \ \

$B_(i j k) = A_(i k j) = display(mat(augment: #(vline: (3, 6)),
#text(fill: red)[1], #text(fill: red)[7], #text(fill: red)[4], #text(fill: purple)[3], #text(fill: purple)[8], #text(fill: purple)[6], #text(fill: eastern)[2], #text(fill: eastern)[9], #text(fill: eastern)[5] ;
9, 3, 6, 7, 1, 4, 8, 2, 5;
4, 8, 1, 2, 6, 9, 3, 7, 5))$
\ \
== Проверка тензора на симметричность и антисимметричность
\ \
$a = display(mat(augment: #(vline: (3, 6)),
0, 0, 0, -1, 2, -1, 1, -2, 1;
1, -2, 1, 0, 0, -0, -1, 2, 1;
-1, 2, -1, 1, -2, -1, 0, 0, 0)) 
$\ \
_Является ли он симметричным или антисимметричным?_\ \
$a_223 = 2$ --- не антисимметричный по $[i j k]$\ \
$a_123 = -2, space a_213 = -1 =>$ не симметрично по $(i j k)$, по $(i j)$, не антисиметрично по $[i j]$\ \
$a_133 = 1$ не антисимметрично по $[j k]$\ \
$a_221 = -2, space a_212 = 0 =>$ не симметрично по $(j k)$\ \
$a_221 = -2, space a_122 = 2 =>$ не симметрично по $(i|j|k)$, но симметрично по $[i|j|k]$\ \

// если надо будет сократить функцию "красный текст", в принципе можно
// можно и для зеленого и синего вдруг понадобятся
// чтобы бло просто red(), greeen(), blue()

//#rect(fill: purple)
//#rect(fill: maroon)
// норм цвета, заполни просто пж
// ?
// да посмотри в таблицу, я начал дальше заполнять, просто цвета пж раскидай, Тимур
// ебать сочетаются цвета конечно
// сарказм или не? я дальтоник
// сарказм

#align(right)[_Квадратные скобки - наличие свойства антисимметричности по данному набору_]\
#align(right)[_Круглые скобки - наличие свойства симметричности по данному набору индексов_]\ \
== Симметризация и антисимметризация тензоров
\ \
=== Симметризация
\ \
$W in Omega^p_0(KK)$\ \
$U(x_1, dots, x_p) = 1/p! sum_sigma W(x_sigma(1), dots, x_sigma(p)), quad U in Sigma^p (KK), quad U = "Sym"(W)$\ \
$A = display(mat(
1, 2, 3;
2, 3, 4;
1, 1, 1))$\ \
$B = "Sym"(A) quad$
$b_ (i, j) = a_ (i j) ^ (s) = 1/2! (a_(i j) + a_ ( j i))$ \ \
$b_11 = 1/2(1 + 1) = 1 quad b_13 = 1/2(3 + 1) = 2$//что делаешь
\ \
$b_12 = 1/2(2 + 2) = 2 quad b_23 = 1/2(4+1) = 5/2$\ \ 
$B = display(mat(
1, 2, 2;
2, 3, 5/2;
2, 5/2, 1)) = "Sym"A$\ \

=== Антисимметризация
\ $V(x_1, dots x_p) = 1/p! sum_sigma (-1)^([sigma])W(x_(sigma(1)), dots, x_sigma(p))\, V in Lambda^p (KK)$\ \ // ебать как догадаться что KK это mathbb(K) //:)
$V = "ASym"(W) = "Alt"(W)$\ \
$v_(i j) = 1/2((-1)^{i j} a_(i j) + (-1)^{j i} a_(j i))$\ \
$v_(1 3) = 1/2(a_13 - a_31) = 1$\ \
$V = display(mat(
0, 0, 1;
0, 0, 3/2;
-1, -3/2, 0)) = "ASym"A$\ \

== Разложение на тензорное произведение одновалентных форм
\ \
$a^(i j)_k = alpha f^i times.circle f^j times.circle e_k$\ \
$(a^(i j)_k) = display(mat(augment: #(vline: (2)),
1, 1, 2, 2 ; 
1, 2, 2, 2)) &= 1 dot f^1 times.circle f^1 times.circle e_1 + 1 dot f^1 times.circle f^2 times.circle e_1 + 1 dot f^2 times.circle f^1 times.circle e_1 + 1 dot f^2 times.circle f^2 times.circle e_1 + \ & + space 2(f^1 times.circle f^1 times.circle e_2 + f^1 times.circle f^2 times.circle e_2 + f^2 times.circle f^1 times.circle e_2 + f^2 times.circle f^1 times.circle e_2) =\ \ &= (f^1 times.circle f^1 + f^1 times.circle f^2 +f^2 times.circle f^1 + f^2 times.circle f^2) times.circle(e_1 + 2e_2) = \ \ & = (f^1+f^2) times.circle (f^1 + f^2) times.circle (e_1 + 2e_2)$ // тут a^(2 2)_2 не 1 случаем?
// чуваки это я для дзшки техаю не стирайте пж
/*$-72 dot f^1 times.circle f^1 times.circle f^1 times.circle f^1 -24 dot f^1 times.circle f^2 times.circle f^1 times.circle f^1  +48 dot f^1 times.circle f^1 times.circle f^1 times.circle f^2 +16 dot f^1 times.circle f^2 times.circle f^1 times.circle f^2 +\ \ 
+108 dot f^1 times.circle f^1 times.circle f^2 times.circle f^1 +36 dot f^1 times.circle f^2 times.circle f^2 times.circle f^1  -72 dot f^1 times.circle f^1 times.circle f^2 times.circle f^2 -24 dot f^1 times.circle f^2 times.circle f^2 times.circle f^2 = \ \
4f^1 times.circle (-18 dot f^1 times.circle f^1 times.circle f^1 -6 dot  f^2 times.circle f^1 times.circle f^1  +12 dot  f^1 times.circle f^1 times.circle f^2 +4 dot  f^2 times.circle f^1 times.circle f^2 +\ \
+27 dot  f^1 times.circle f^2 times.circle f^1 +9 dot  f^2 times.circle f^2 times.circle f^1  -18 dot  f^1 times.circle f^2 times.circle f^2 -6 dot  f^2 times.circle f^2 times.circle f^2) = \ \
= 4 dot f^1 times.circle (3dot f^1 times.circle (-6 dot f^1 times.circle f^1   +4 dot  f^1 times.circle f^2 + 9 dot f^2 times.circle f^1 - 6 dot f^2 times.circle f^2 ) + \ \ + f^2 times.circle ( -6 dot f^1 times.circle f^1  +4 dot  f^1 times.circle f^2+ 9 dot f^2 times.circle f^1 - 6 dot f^2 times.circle f^2  )) = \ \
=4 dot f^1 times.circle (3dot f^1 times.circle f^2) times.circle(-6 dot f^1 times.circle f^1   +4 dot  f^1 times.circle f^2 + 9 dot f^2 times.circle f^1 - 6 dot f^2 times.circle f^2 ) = \ \
=4 dot f^1 times.circle (3dot f^1 times.circle f^2) times.circle(2 dot f^1 times.circle( -3 dot f^1   +2 dot   f^2) - 3 dot f^2 times.circle (-3 dot f^1 + 2 dot f^2 )) = \ \
= 4 dot f^1 times.circle (3dot f^1 times.circle f^2) times.circle(2 dot f^1 - 3 dot f^2) times.circle( -3 dot f^1   +2 dot   f^2)$
\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \
$-18 dot e_1 times.circle e_1 times.circle e_1 -36 dot e_2 times.circle e_1 times.circle e_1 -18 dot e_3 times.circle e_1 times.circle e_1 - \ \
-12 dot e_1 times.circle e_2 times.circle e_1 -24 dot e_2 times.circle e_2 times.circle e_1 -12 dot e_3 times.circle e_2 times.circle e_1 + \ \ 
+12 dot e_1 times.circle e_1 times.circle e_2 +24 dot e_2 times.circle e_1 times.circle e_2 +12 dot e_3 times.circle e_1 times.circle e_2 + \ \
+8 dot e_1 times.circle e_2 times.circle e_2 +16 dot e_2 times.circle e_2 times.circle e_2 +8 dot e_3 times.circle e_2 times.circle e_2 - \ \
-6 dot e_1 times.circle e_1 times.circle e_3 -12 dot e_2 times.circle e_1 times.circle e_3 -6 dot e_3 times.circle e_1 times.circle e_3 - \ \
-4 dot e_1 times.circle e_2 times.circle e_3 -8 dot e_2 times.circle e_2 times.circle e_3 -4 dot e_3 times.circle e_2 times.circle e_3 = \ \ =
(e_1 times.circle e_1 + 2 dot e_2 times.circle e_1 + e_3 times.circle e_1 ) times.circle (-18dot e_1 + 12 dot e_2 - 6 dot e_3) + \ \ +
(e_1 times.circle e_2 + 2 dot e_2 times.circle e_2 + e_3 times.circle e_2 ) times.circle (-12dot e_1 + 8 dot e_2 - 4 dot e_3) = \ \ =
3 dot (e_1 + 2dot e_2 + e_3) times.circle e_1 times.circle(-6dot e_1 + 4 dot e_2 - 2 dot e_3) + \ \ + 2 dot (e_1 + 2dot e_2 + e_3) times.circle e_2 times.circle(-6dot e_1 + 4 dot e_2 - 2 dot e_3) = \ \ =
(e_1 + 2dot e_2 + e_3) times.circle (3dot e_1 + 2 dot e_2) times.circle (-6dot e_1 + 4 dot e_2 - 2 dot e_3)$
\ \ \ \
Заметим что тензор антисимметричен по всем четырем индексам:\ \
$A(f^(i_1), f^(i_2), f^(i_3), f^(i_4)) = cases(0\, "какие нибудь" i "совпади", 1452 dot (-1)^([i])\, "иначе (т.к. в этом случае" i - "перестановака можно подсчитать ее четность)")$
\ \
Отсюда можно сделать вывод что $A = "const" dot f^1 and f^2 and f^3 and f^4$, а т.к. ненулевые значения равны 1452 при четных перестановках $i$, const = 1452*/

#pagebreak()

//#quote("Всякое в жизни бывает")

== Смена базиса ПЛФ
Хочется понимать, что будет при смене базиса

$X$ --- ЛП (пространство контрвекторов)\
${e_i}$ --- базис $X$\
$x in X, space x_e = sum xi^i e_i$\
${tilde(e)_i}$ --- новый базис $X$\
Базис $e$ связан с базисом $tilde(e)$ матрицей перехода $T$:\
$ tilde(E) = T_(e -> tilde(e)) E $#align(center)[$E$ --- матрица базиса $e, space tilde(E)$ --- матрица базиса $tilde(e)$] \
$tilde(e)_i = display(sum_(k=1)^n tau_i^k e_k)$\ #v(0.4cm)
$x_(tilde(e)) = S_(tilde(e) -> e) x_e, quad S_(tilde(e)-> e) = T_(e->tilde(e))^(-1)$\
\
$X^*$:\
${f^j}, space {tilde(f)^j}$ --- базисы, cопряжённые ${e_i}$ и ${tilde(e)_i}$ соответственно\ #v(0.4cm)
$y_f = sum g_j f^j$\ #v(0.4cm)
$tilde(f)^j = f^j S$\ #v(0.4cm)
$y_tilde(f) = y_f T$
\ \
$T = norm(tau_j^i)$ _(верхний индекс отвечает за строку, нижний за столбец)_\
$S = norm(sigma_j^i)$\ #v(0.4cm)
$tau_i^k dot sigma_k^j = delta_i^j<=> T S = I$ - единичная матрица\ #v(0.4cm)
$display(omega_(i_1 dots i_p)^(j_1 dots j_q))$: $quad {e}, space{f}$ --- $p$ _раз контрвариантен и $q$ раз ковариантен ($p$ векторов из $X$, $q$ векторов из $X^\*$)_\ #v(0.4cm)
$tilde(omega)_(i'_1 dots i'_p)^(j'_1 dots j'_q)$: $quad {tilde(e)}, space {tilde(f)}$\ #v(0.4cm)

$display(tilde(omega)_(i'_1 dots i'_p)^(j'_1 dots j'_q) = omega_(i_1 dots i_p)^(j_1 dots j_q) dot underbrace(sigma_(i'_1)^(i_1) dot dots dot sigma_(i'_p)^(i_p), p "раз") dot underbrace(tau_(j_1)^(j'_1) dot dots dot tau_(j_q)^(j'_q), q "раз"))$\ #v(0.4cm)
_$p$ раз контрвариантен $=> p$ раз преобразовывается по контрвариантному закону (домножение на $sigma$)_\
_$q$ раз ковариантен $=>$ q раз преобразовывается по ковариантному закону (домножение на $tau$)_\
// кста я тут понял что один момнт я не понял
// 293 строка, почему там когда тильду выражаем не через тильду, домножаем на переход из тильды в нетильду а не наоборот
// ну да, x умножаем на обратную
// Вань, ты про cetz читал? //может быть, но скорее нет // я тебе скидывал, package для рисования 
// ааааааа, не читал
\ #ex\
Тензор валентности (2, 1), задан стандартный базис ${e}: e_1 = (1,0, 0) space e_2 = (0, 1, 0), space e_3 = (0, 0, 1)$\
$tilde(e)_1 = e_1$\
$tilde(e)_2 = e_3$\
$tilde(e)_3 = e_2$\ \
$A_e = display(mat(augment: #(vline: (3, 6)),
  1, 2, 3, 4, 5, 8, 7, 8, 9;
  1, 3, 2, 1, 5, 9, 8, 7, 6;
  9, 8, 7, 6, 5, 4, 3, 2, 1
))$\ \
$T = display(mat(
  1, 0, 0;
  0, 0, 1;
  0, 1, 0
)) = S$\ \
$tilde(a)_(j'k')^(i') = a^i_(j k) dot sigma_(j')^j dot sigma_(k')^k dot tau_i^(i') limits(=)_("свертка индексов по" i) sigma_(j')^j dot sigma_(k')^k dot (a_(j k)^1 dot tau_1^(j') + a_(j k) ^ 2 dot tau_(2)^(j') + a_(j k)^3 dot tau_3^(i'))\ \

limits(=)_("свертка индексов по" j)sigma_(k')^k (sigma_j'^1 (a_(1k)^1 tau_1^(i') + a_(1k)^2 tau_2^(i') + a_(1 k)^3 tau_3^(i')) + sigma_(j')^2(a_(2k)^1 tau_1^(i') + a_(2k)^2 tau_2^(i') + a_(2 k)^3 tau_3^(i')) + sigma_(j')^3(a_(3k)^1 tau_1^(j') + a_(3k)^2 tau_2^(j') + a_(3 k)^3 tau_3^(j'))\ \ limits(=)_("свертка индексов по" k) italic(text("предлагается оставить непосчитанным"))$\ \
_Вместо расписывания свёртки, можно использовать #math.cancel("голову") матричные произведения_

= Определитель матрицы
По честному, определитель матрицы не умеет считать никто. Не существует _нормального_ алгоритма, позволяющего посчитать определитель матрицы произвольного порядка 
\ \
(запись матрицы внутри | $$ | подразумевает определитель матрицы)\ 
== Метод приведения матрицы к треугольному виду
#ex
$ D = display(mat(delim: "|",
a_1, x, x, dots, x;
x, a_2, x, dots, x;
x, x, a_3, dots, x;
dots.v, dots.v, dots.v, dots.down, dots.v;
x, x, x, dots, a_n
))//_(#pad(top: -50pt, $-(1)\ -(1)\  space space space space dots.v \ -(1)$)) 
limits(=)^((1)) 
display(mat(delim: "|",
a_1, x, x, dots, x;
x-a_1, a_2 - x, 0, dots, 0;
x-a_1, 0, a_3 - x, dots, 0;
dots.v, dots.v, dots.v, dots.down, dots.v;
x-a_1, 0,0, dots, a_n-x
)) limits(=)^((2)) product_(i=1)^n (a_i-x) display(mat(delim: "|",
a_1/(a_1-x), x/(a_2-x), x/(a_3-x), dots, x/(a_n-x);
-1, 1, 0, dots, 0;
-1, 0, 1, dots, 0;
dots.v, dots.v, dots.v, dots.down, dots.v;
-1, 0,0, dots, 1
)) limits(=)^((3)) $
$ limits(=)^((3))product_(i=1)^n (a_i - x) display(mat(delim: "|",
A, x/(a_2-x), x/(a_3-x), dots, x/(a_n-x);
0, 1, 0, dots, 0;
0, 0, 1, dots, 0;
dots.v, dots.v, dots.v, dots.down, dots.v;
0, 0,0, dots, 1
)) limits(=)^((4))product_(i=1)^n (a_i - x)(1 + x/(a_1-x) + x/(a_2-x) + dots + x/(a_n-x))limits(=)^((5)) $$ limits(=)^((5))-x product_(i=1)^n (a_i - x)(1/x + 1/(a_1-x) + 1/(a_2-x) + dots + 1/(a_n-x)) $

В (1) равенстве  мы вычли из всех строчек первую.\ #v(0.2cm)
В (2) равенстве поделили каждый столбец на $(a_i-x)$.\ #v(0.2cm)
В (3) равенстве мы прибавили к первому столбцу все остальные столбцы\ #v(0.2cm)
В (4) равенстве мы сказали что определитель равен произведению элементов на главной диагонали (т.к. есть треугольник из нулей), а также расписали $A$\ #v(0.2cm)
//что значит расписали A
В (5) равенстве вынесли $x$ за скобку

== Метод выделения множителей
#ex
$ D = display(mat(delim: "|",
1,2,3,dots,n;
1,x+1,3,dots,n;
1,2,x+1,dots,n;
dots.v,dots.v,dots.v,dots.down,dots.v;
1,2,3,dots,x+1
))=P_(n-1) (x)
$\
$D = P_(n-1) (x)=(x-1) P_(n-2) (x) = (x-1) (x-2) P_(n-3) (x) = dots = (x-1)(x-2)dots(x-n+1) P_0 (x)$\ #v(0.4cm)
$x=1: P_(n-1) (1) = 0$\
$x=2: P_(n-2) (2) = 0$\ #v(0.4cm)
$P_0 (x)=1$ (_приведённый многочлен_) т.к. наибольшая степень достигается только при перемножении $n-1$ скобки стоящей на главной диагонали. У всех них коэффициент 1, поэтому и итоговый коэффициент будет 1 \ $=> $ _(для этой конкретной матрицы)_ $D = (x-1)(x-2)dots(x-n+1)$

== Метод разложения на линейные множители
#ex\
$ D = display(mat(delim: "|",
0,x,y,z;
x,0,z,y;
y,z,0,x;
z,y,x,0
)) limits(=)^((1)) display(mat(delim: "|",
x-y-z,x,y,z;
x-y-z,0,z,y;
y+z-x,z,0,x;
z+y-x,y,x,0
)) $
$ (x - y - z), quad (x+z-y), quad (x + y + z) quad (x+y-z) $
$ D = alpha(x-y-z)(x+z-y)(x+y+z)(x+y-z), quad alpha = plus.minus 1 $
#align(center)[_При $z^4$ должен быть +, поэтому $alpha =+1$_]
\
В (1) равенстве прибавим к первом столбцу второй и вычтем 3-ий и 4-ый\
Аналогично можем:
+ Прибавить 3-ий, вычесть 2-ой и 4-ый

+ Прибавить 4-ый, вычесть 2-ой и 3-ий

+ Прибавить 2-ой, 3-ий и 4-ый
При каждом из действий из первого столбца будет выделяться скобка, причем все они взаимнопросты, а т.к. суммарная степень многочлена 4, больше скобок не будет

#quote("Вроде определитель всего лишь 4x4, а уже душно")

== Метод рекуррентных соотношений
#ex\
$ D_n =display(mat(delim: "|",
a_1, x, dots, x, x;
x, a_2, dots, x, x;
dots.v, dots.v, dots.down, dots.v, dots.v;
x, x, dots, a_(n-1), x;
x, x, dots,x, a_n
)) =^((1)) display(mat(delim: "|",
a_1, x, dots, x, x;
x, a_2, dots, x, x;
dots.v, dots.v, dots.down, dots.v, dots.v;
x, x, dots, a_(n-1), x;
x, x, dots,x, x
)) + display(mat(delim: "|", 
a_1, x, dots, x, 0;
x, a_2, dots, x, 0;
dots.v, dots.v, dots.down, dots.v, dots.v;
x, x, dots, a_(n-1), 0;
x, x, dots,x, a_n-x
)) = x product_(i=1)^(n-1)(a_i-x) + (a_n-x)D_(n-1)=\
=x product_(i=1)^(n-1)(a_i-x) + x product_(i=1)^(n-2) (a_i-x)(a_n-x) + (a_n-x)(a_(n-1)-x)D_(n-2) $
$ D_1 = x + (a_1 - x) $

В (1) равенстве мы разложили последний столбец по следующему правилу:
$ display(vec(x, x, dots.v, a_n + x - x) = vec(x, x, dots.v, x) + vec(0, 0, dots.v, a_n - x)) $
//распишите, что мы ещё здесь делали...
// тыгыдын на x
#ex\
$ D_n =display(mat(delim: "|",
7, 5, 0, dots, 0;
2, 7, 5, dots, 0;
0,2,7,dots,0;
dots.v, dots.v, dots.v, dots.down, dots.v;
0, 0, 0, dots, 7
)) display(=)^((1)) 7 dot display(mat(delim: "|",
7, 5, 0, dots, 0;
2, 7, 5, dots, 0;
0,2,7,dots,0;
dots.v, dots.v, dots.v, dots.down, dots.v;
0, 0, 0, dots, 7
)) - 5 dot display(mat(delim: "|",
2, 5, dots, 0;
0,7, dots,0;
dots.v, dots.v, dots.down, dots.v;
0, 0, dots, 7
)) =^((2)) 7 D_(n-1) - 5dot 2 dot D_(n-2)      $  $ D_n = 7 dot D_(n-1) - 10D_(n - 2) limits(<->)^((3)) x^2 - 7x + 10 = 0 - "характеристическое уравнение" $ $ D_n = C_1(x_1)^n + C_2(x_2)^n, quad C_1 = (D_2 - x_2D_1)/(x_1(x_1 - x_2)), quad C_2 = -(D_2 - x_1D_1)/(x_2(x_1 - x_2)) $ 
В равенстве (1) найдем определитель при помощи разложения по первой строке\
В равенстве (2) найдем вторую матрицу при помощи разложения по первому столбцу\
//#quote("Метод подбора интегрирующего множителя - либо подобрал либо нет)")
\
/*
$ x^2 - 7x + 10 = 0\
D_n = c_1 (x_1)^n + c_2 (x_2)^n\
c_1 = (D_2 - x_2 D_1)/(x_1 (x_1-x_2))\
c_2 = -(D_2 - x_1 D_1)/(x_2 (x_1-x_2))$
*/