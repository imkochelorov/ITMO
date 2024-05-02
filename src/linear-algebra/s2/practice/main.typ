#import "../../../template.typ": *

#show par: set block(spacing: 0.55em)
#set page(margin: 0.45in, height: auto)
#set par(leading: 0.75em, first-line-indent: 0em, justify: false)
#set text(font: "New Computer Modern")
#set heading(numbering: "1.1.")
#show raw: set text(font: "New Computer Modern Mono")
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
// #show linebreak: v(0.2cm)

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
Обозначение $epsilon_(i j k): i - "строка", space  j - "столбец" space k - "слой"$\ #v(0.4cm)
$(3, space 0) <--> epsilon_(i j k)$\ #v(0.4cm)
$(2, space 1) <--> epsilon_(i j)^k$\ #v(0.4cm)
$(1, space 2) <--> epsilon_(i)^(j k)$\ #v(0.4cm)
$(0, space 3) <--> epsilon^(i j k)$\
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

$ A = display(mat(augment: #(hline: 2, vline: 2),
1, 2,  3, 4;
-4, -3,  -2, -1;
-4, -3,  -2, -1;
5, 6,  7, 8)) = ||a^(i j)_(k l)|| $
#align(center)[_i --- локальная строка, j --- локальный столбец, k --- глобальная строка, l --- глобальный стобец_] // я понял по 3 дефиса
\
Будем считать что это тензор четвертого ранга, валентности (2, 2)\ #v(0.4cm)
$a_(h l)^(h j) = b_(l)^(j)$\  #v(0.4cm)
$b_l^j = sum_h a^(h j) _ (h l) = a ^(1 j)_(1 l)+ a^(2 j)_(2 l)$ \ #v(0.4cm)
$b_1^1 = a^(1 1)_(1 1) + a^(2 1) _ (2 1) = 6$\ #v(0.4cm)
$b_1^2 = a^(1 2)_(1 1) + a^(2 2) _ (2 1) = 10$\ #v(0.4cm)
$dots$ \ #v(0.4cm)
$B = display(mat(
6, 10;
8, 12))$
\ \
*Тензорное произведение:*
\ #v(0.4cm)
$A - "ПЛФ валентности" (1, 0) <--> a=(1, -1, 0)$\ #v(0.4cm)
$B - "ПЛФ валентности" (2, 0) <--> b = display(mat(
1, 2, 3;
4, 5, 6;
7, 8, 9)) 
$
\ #v(0.4cm)
// я хз как буквы над буквами писать
$limits(a)^alpha times.circle limits(b)^beta = limits(c)^gamma$\ \
$(alpha_i) times.circle (beta_(j k)) = gamma_(i j k)$ \ \
$gamma_231 = alpha_2 dot beta_31$\ \
$C = display(mat(augment: #(vline: (3, 6)),
1, 4, 7, 2, 5, 8, 3, 6, 9;
0, 0, -7, -2, -5, -8, -1, 0, 0;
0, -1, 0, 1, 0, 0, 0, 0, 0)) 
$ \ \
*Другой пример:*
\ #v(0.4cm)
$A(2, 0) <--> a = display(mat(
1, -1;
-1, 1)) $\ #v(0.4cm)
$A(1, 1) <--> b = display(mat(
1, 1;
1, 2)) $\ #v(0.4cm)
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
\ #v(0.4cm)
Индекс сферху = форма = горизонтальные координаты\ #v(0.4cm)
Индекс снизу = вектор = вертикальные координаты\ #v(0.4cm)
$a^1 = (1, 0, 0)$\
$a_2 = (0, 1, 0)^T = display(vec(0, 1, 0))$\ \
$a_3 = (0, 0, 1)^T = display(vec(0, 0, 1))$\ #v(0.4cm)
$b = a^1 times.circle a_2 times.circle a_3$\ #v(0.4cm)
$beta_(i k) ^ j = (psi^j) times.circle (zeta_i) times.circle (eta_k)$
\ #v(0.4cm) $b = display(mat(augment: #(vline: (3, 6)),
0, 0, 0, 0, 0, 0, 0, 1, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0)) 
$\ \ // имба // полезно
== Транспонирование тензора:
#v(0.4cm)
_Двумерное сечение --- двумерная матрица, в которой зафиксированы все индексы, кроме 2 конкретных_\ #v(0.4cm)
Транспонирование тензора --- операция, результатом которой 
\ #v(0.4cm)
$A_(i k l) ^ (T (k l)) = A_(i l k)$\ #v(0.4cm)
$A$ --- валентность (3, 0) $<--> a = display(mat(augment: #(vline: (3, 6)),
#text(fill: red)[1], #text(fill: purple)[3], #text(fill: eastern)[2], #text(fill: red)[7], #text(fill: purple)[8], #text(fill: eastern)[9], #text(fill: red)[4], #text(fill: purple)[6], #text(fill: eastern)[5] ; // 00%
9, 7, 8, 3, 1, 2, 6, 4, 5;
4, 2, 3, 8, 6, 7, 1, 9, 5)) $\ #v(0.4cm)
$b_(i j k) = a_(i k l)$\ #v(0.4cm)
$make i = 1 => b_(j k) = a_(1 j k) = display(mat(
#text(fill: red)[1], #text(fill: red)[7], #text(fill: red)[4] ;
#text(fill: purple)[3], #text(fill: purple)[8], #text(fill: purple)[6] ;
#text(fill: eastern)[2], #text(fill: eastern)[9], #text(fill: eastern)[5])) 
=> a_(1 k j) = display(mat(
#text(fill: red)[1], #text(fill: purple)[3], #text(fill: eastern)[2] ;
#text(fill: red)[7], #text(fill: purple)[8], #text(fill: eastern)[9] ;
#text(fill: red)[4], #text(fill: purple)[6], #text(fill: eastern)[5])) $\ #v(0.4cm)
$make i = 2 => b_(j k) = dots$\ #v(0.4cm)

$B_(i j k) = A_(i k j) = display(mat(augment: #(vline: (3, 6)),
#text(fill: red)[1], #text(fill: red)[7], #text(fill: red)[4], #text(fill: purple)[3], #text(fill: purple)[8], #text(fill: purple)[6], #text(fill: eastern)[2], #text(fill: eastern)[9], #text(fill: eastern)[5] ;
9, 3, 6, 7, 1, 4, 8, 2, 5;
4, 8, 1, 2, 6, 9, 3, 7, 5))$\ \
== Проверка тензора на симметричность и антисимметричность
 #v(0.4cm)
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

=== Симметризация
 #v(0.4cm)
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
#v(0.4cm)
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
\ #v(0.4cm)
$X$ --- ЛП (пространство контрвекторов)\ #v(0.4cm)
${e_i}$ --- базис $X$\ #v(0.4cm) 
$x in X, space x_e = sum xi^i e_i$\ #v(0.4cm)
${tilde(e)_i}$ --- новый базис $X$\ #v(0.4cm)
Базис $e$ связан с базисом $tilde(e)$ матрицей перехода $T$:\
$ tilde(E) = T_(e -> tilde(e)) E $#align(center)[$E$ --- матрица базиса $e, space tilde(E)$ --- матрица базиса $tilde(e)$] \
$tilde(e)_i = display(sum_(k=1)^n tau_i^k e_k)$\ #v(0.4cm)
$x_(tilde(e)) = S_(tilde(e) -> e) x_e, quad S_(tilde(e)-> e) = T_(e->tilde(e))^(-1)$\
\
$X^*$:\ #v(0.4cm)
${f^j}, space {tilde(f)^j}$ --- базисы, cопряжённые ${e_i}$ и ${tilde(e)_i}$ соответственно\ #v(0.4cm)
$y_f = sum g_j f^j$\ #v(0.4cm)
$tilde(f)^j = f^j S$\ #v(0.4cm)
$y_tilde(f) = y_f T$
\ \
$T = norm(tau_j^i)$ _(верхний индекс отвечает за строку, нижний за столбец)_\ #v(0.4cm)
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
\ #ex\ #v(0.4cm)
Тензор валентности (2, 1), задан стандартный базис ${e}: e_1 = (1,0, 0) space e_2 = (0, 1, 0), space e_3 = (0, 0, 1)$\ #v(0.4cm)
$tilde(e)_1 = e_1$\ #v(0.4cm)
$tilde(e)_2 = e_3$\ #v(0.4cm)
$tilde(e)_3 = e_2$\ #v(0.4cm)
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
#pagebreak()
= Линейные операторы
#align(center)[_Преподаватель: Попков Роман Андреевич_]\
*Пример:*

+ $x |-> x + a, quad x, a in E^3$

+ $f(x) |-> f(x+1) - f(x), quad  f in RR[x]$
+ $display(vec(x_1, x_2) |-> vec(2 x_2, x_1 + 3)\, quad x_i in F)$
+ $x |-> (x, a)dot a  quad x, a in E_3$
Проверим, являются ли эти операторы линейными:
// ваня ты комп зарядил?
// +

#columns(2)[
1. $phi(lambda x + mu y) = lambda phi(x) + mu phi(y)$\
  $(x+y) |-> (x+y)+a$\
  $x |-> x+a$\
  $y |-> y + a$\
  Если $a = 0$, то $phi = cal(I)$ (тождественный)\
  Если $a != 0$, то $phi$ не линейный оператор.
#colbreak()
2. $f(x) |-> f(x)$ --- $cal(I)$\
  $f(x) |-> f(x+1)$\
  $(f+g)(x) |-> (f+g)(x+1) = f(x+1) + g(x+1)$\
  Сумма линейных операторов --- линейный оператор
]

#columns(2)[
// #set enum(start: 3)
3. Нет, линейности по второй координате не будет
#colbreak()
// #set enum(start: 4)
4. Да, скалярное произведение линейно
]
#v(0.4cm)
== Матрицы линейного оператора
#v(0.4cm)

#align(center)[$phi(x) = [phi]dot x$] #v(0.4cm)

*Пример:*
$E^3: (i, j, k)$\ 

+ $display(x |->^phi a times x)$ 

+ $B:$ поворот на $(2pi)/3$ вокруг прямой $x=y=z$
Матрица линейного оператора хранит образы базисных векторов.\ \

#table(columns: (20fr, 11fr),
  inset: 0pt,
  stroke: none,
  align: top,
[
$[phi] :$\
$a = a_1 i + a_2 j + a_3 k$\
$phi(i) = a times i = (a_1 i + a_2 j + a_3 k) times i = 0 i-a_2 k + a_3 j$\
$phi(j) = a times j = (a_1 i + a_2 j + a_3 k) times j = a_1 k + 0 j - a_3 i$\
$phi(k) = a times k = (a_1 i + a_2 j + a_3 k) times k = -a_1 j + a_2 i + 0 k$\ \
],
[
$[phi] = display(mat(
  0, -a_3, a_2;
  -a_2, 0, -a_1;
  a_3, a_1, 0
))$
\ \
$[B] = display(mat(
  0, 0, 1;
  1, 0, 0;
  0, 1, 0
))$
])

//$alpha(x, x) = 0$\
//$0 = alpha(x + y, x + y) = alpha(x, x) + alpha(y, y)$\
//$alpha(x, y) = -alpha(y, x)$
//блять куда
//я не увидел нихрена там, потому что он загораживал. и он тут же стёр

*Характеристика поля:*\ #v(0.4cm)
$underbracket(1 + 1 + dots + 1, p) = 0, space p - min /* min? */ > 0 <=> "char" KK = p$\ #v(0.4cm)
$exists.not p <=> "char" KK = 0$\ #v(0.4cm)
$CC, RR, QQ: "char" = 0$\ #v(0.4cm)
$ZZ_p, space p$ --- простое: $"char" = p$
\ \
*Пример:* _пространство квадратных матриц размера 2_ #v(0.4cm) 
$M_2 (F) quad E_11, E_12, E_21, E_22 $ -- базис\ #v(0.4cm) 
$phi: X |-> display(mat(a, b; c, d) dot X)$\ #v(0.4cm)
$[phi]=display(mat(a, 0, b,0 ;0, a, 0, b ;c, 0, d, 0;0, c, 0, d))$\ #v(0.4cm)
$phi(E_11) = display(mat(a, b; c, d) times mat(1, 0; 0, 0) = mat(a, 0; c, 0)) = a dot E_11 + c dot E_21 = a E_11 + 0 E_12 + c E_21 + 0 E_22$\
\ 
*Пример:* _пространство многочленов не выше третьей степени_\ #v(0.4cm) 
#table(columns: (5fr, 10fr),
  inset: 0pt,
  stroke: none,
  align: left,
[
$RR[x]_3 quad (1, x, x^2, x^3)$\ #v(0.4cm)
$cal(A): f |-> display(1/x) display(limits(integral))_0^x f(t) dif t$\ \
$cal(A)(1) = display(1/x) display(limits(integral))_0^x 1 dif t = 1$\ \
$cal(A)(x) = display(1/x) display(limits(integral))_0^x x dif t = x/2$\ \
$cal(A)(x^2) = display(1/x) display(limits(integral))_0^x x^2 dif t = x^2/3$\ \
$cal(A)(x^3) = display(1/x) display(limits(integral))_0^x x^3 dif t = x^3/4$\ \
],
[
$[cal(A)]=display(mat(1,0,0,0;0,1/2,0,0;0,0,1/3,0;0,0,0,1/4))$\ #v(0.4cm) 
$limits(lim)_(n->+infinity) cal(A)^n = cal(P)_(<1>)^(<x,x^2,x^3>)$ --- проектор на 1 паралленльно $x, x^2, x^3$\ #v(0.4cm) 
$limits(lim)_(n->+infinity) cal(A)^n = display(mat(augment: #(hline: 1, vline: 1),1,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0))$
])
== Переход в новый базис
#v(0.4cm)
$e = (e_1,e_2,e_3,e_4)$\ #v(0.4cm)
$[phi]_e = display(mat(0,1,2,3;5,4,0,-1;3,2,0,3;6,1,-1,7))$\ #v(0.4cm)
$tilde(e) = \(limits(e_2)_(tilde(e_1)),limits(e_1)_tilde(e_2),limits(e_3)_tilde(e_3),limits(e_4)_tilde(e_4)\)$\ #v(0.4cm)
$[phi]_(tilde(e)) = (e arrow.squiggly.long tilde(e))^(-1) dot [phi]_e dot (e arrow.squiggly.long tilde(e))$\ #v(0.4cm)
$(e arrow.squiggly.long tilde(e)) = display(mat(0, 1, 0, 0; 1, 0, 0, 0; 0, 0, 1, 0; 0,0,0,1)) = (e arrow.squiggly.long tilde(e))^(-1)$, обратная матрица такая же, потому что _потому_\  #v(0.5cm) // squiggly arrow //struggling arrow // there is only struggle
$[phi]_tilde(e) = display(mat(0, 1, 0, 0; 1, 0, 0, 0; 0, 0, 1, 0; 0,0,0,1)) times display(mat(0,1,2,3;5,4,0,-1;3,2,0,3;6,1,-1,7)) times display(mat(0, 1, 0, 0; 1, 0, 0, 0; 0, 0, 1, 0; 0,0,0,1)) = display(mat(4,5,0,-1;1,0,2,3;2,3,0,3;1,6,-1,7))$

// #image("image.png", width: 100%)
// Мое погоняло ебись оно все конем
\ #v(0.2cm)
*_Домашняя работа:_*\
Найти матрицу $phi_tilde(e),$ если 
$tilde(e) = (e_1, e_1 + e_2, e_1 + e_2 + e_3, e_1 + e_2 + e_3 + e_4)$
#quote("Не нужно гадать. Нужно взять и умножить", attribution: "Попков Роман Андреевич")

*_Решение:_*\ #v(0.4cm)
$e = (e_1,e_2,e_3,e_4)$\ #v(0.4cm)
$[phi]_e = display(mat(0,1,2,3;5,4,0,-1;3,2,0,3;6,1,-1,7))$\ #v(0.4cm)
$tilde(e) = (e_1, e_1 + e_2, e_1 + e_2 + e_3, e_1 + e_2 + e_3 + e_4)$\ #v(0.4cm)
#align(center)[$[phi]_(tilde(e)) = (e arrow.squiggly.long tilde(e))^(-1) dot [phi]_e dot (e arrow.squiggly.long tilde(e))$] #v(0.4cm)
#columns(2)[
#align(center)[$(e arrow.squiggly.long tilde(e)) = display(mat(1, 1, 1, 1; 0, 1, 1, 1; 0, 0, 1, 1; 0,0,0,1))$]
#colbreak()
#align(center)[$(e arrow.squiggly.long tilde(e))^(-1) = display(mat(1, -1, 0, 0; 0, 1, -1, 0; 0, 0, 1, -1; 0,0,0,1))$
]]
#v(0.4cm)
#align(center)[$[phi]_(tilde(e)) = display(mat(1, -1, 0, 0; 0, 1, -1, 0; 0, 0, 1, -1; 0,0,0,1)) dot display(mat(0,1,2,3;5,4,0,-1;3,2,0,3;6,1,-1,7)) dot display(mat(1, 1, 1, 1; 0, 1, 1, 1; 0, 0, 1, 1; 0,0,0,1)) = display(mat(-5,-8,-6,-2;2,4,4,0;-3,-2,-1,-5;6,7,6,13))$]
\ \
== Базис и ядро линейного оператора
#v(0.4cm)
#columns(2)[
#align(center)[$"Ker"phi = {x in X | phi(x) = 0}$]
#colbreak()
#align(center)[$"Im"phi = {y in Y | y = phi(x)}$]
]#v(0.4cm)
*Пример:*\ #v(0.4cm)
$[phi] = display(mat(1,0,2,3;2,1,1,-1;3,2,0,-7;6,3,3,-5))$\ \
*Задание:* \
Найти базисы $"Ker"phi$ и $"Im"phi$\ #v(0.4cm)
//$x in "Ker"phi <=> phi(x) = 0 quad [phi] dot x = 0$\ \

//Я правильно понял, что мы щас сидим домашку решаем?
// кажись


//Как найти ядро --- решить однородную систему с матрицей\
//Как найти базис ядра --- найти фундаментальную систему решений

// как решать слау
*Решение:*\ #v(0.4cm)
$[phi] = display(mat(1,0,2,3;2,1,1,-1;3,2,0,-7;6,3,3,-5)) tilde display(mat(1,0,2,3;0,1,-3,-7;0,2,-6,-16;0,0,0,0)) tilde display(mat(1,0,2,3;0,1,-3,-7;0,0,0,-2))$\ #v(0.4cm)

#table(columns: (3fr, 20fr),
  inset: 0pt,
  stroke: none,
  align: top,
[
$x_4 = 0$\
$x_1 = -2 x_3$\
$x_2 = 3 x_3$
],
[
$display(vec(x_1,x_2,x_3,x_4)) = x_3 display(vec(-2,3,1,0)) => dim "Im"phi = 3$
])
// нахера это вот нижнее, мы справа просто ставим столбец нулей и т.к. любая комбинация нулей ноль можно столбц даже не писать
// я не помню как слау решать
// не уважаемо

//так стоп. в дз написан какой-то новый базис. что делать в дз то
// то же что и чуть чуть выше
//а от какой матрицы
//а где есть матрица. нету же
// мне кажется та из задания которая сразу под этим
//так это ведь уже другое задание оказывается было, которое мы щас решили
// в плане, утебя есть матрица линейного оператора, а также координаты в старом базисе, ну теперь находим матрицу перехода, обратную и пое
\ \

$RR[x]_n, quad n > 2$\

+ $cal(A): f(x) |-> f(x+1)$\ #v(0.2cm)
  $"Ker" cal(A) = {0}, quad "Im"(cal(A))= RR[x]_n$
  
+ $cal(B): f(x) |-> f(-x)$\ #v(0.2cm)
  $"Ker" cal(B) = {0}, quad "Im"(cal(B))= RR[x]_n$
+ $cal(C): f(x) |-> x f''(x)$\ #v(0.2cm)
  $"Ker" cal(C) = RR[x]_1, quad "Im"(cal(C))= x dot RR[x]_(n-2)$
+ $cal(D): f(x) |-> f(0) x$\ #v(0.2cm)
  $"Ker" cal(D) = x RR[x]_(n-1), quad "Im"(cal(D)) = {a x | a in RR}$
#v(0.4cm)
== Сопряженный оператор (Сопряженное отображение)
#v(0.4cm)
// тема которую мы не дотехали
// упс упс упс, ну да и хрен с ним
// почему ctrl+D не работает
// alt f4 попробуй
#table(columns: (5fr, 5fr, 10fr),
  inset: 0pt,
  stroke: none,
  align: left,
[

$phi: V -> V$\ #v(0.4cm)
$phi^*: V^* -> V^*$\ #v(0.4cm)
$(underbracket(phi^* underbracket(omega, in V^*), in V^*), x\):= (omega, phi x)$\ #v(0.4cm)
$[phi]_e = A$\ #v(0.4cm)
$[phi^*]_(e^*) = space ?$
],
[
$e_1, dots, e_n$ --- базис $V$\ #v(0.4cm)
$e_1^*, dots, e_n^*$ --- базис $V^*$\ #v(0.4cm)
$(e_1^*, e_j) = delta_(i j)$\ #v(0.4cm)
$e_i^* (x) = x_i$\ #v(0.4cm)
$e_i (x^*)= x_i^*$
],
[
$A = (a_(i j))$\ #v(0.4cm)
$a_(i j)$ --- $i$-я координата $j$-ого базисного вектора\ #v(0.4cm)
$a_(i j) = (e_i^*, phi(e_j)) = (phi^* e_i^*, e_j)$ ---\  #v(0.4cm)$j$-я координата $i$-ого базисного ковектора при действии сопряжённого оператора\ #v(0.4cm)
$[phi^*]_(e^*) = A^T$
])
\
*_Домашная работа:_* #v(0.4cm)

Выразить $"Ker"(phi^*)$ и $"Im"(phi^*)$ через $"Ker"(phi)$ и $"Im"(phi)$

//1. Найти $"Ker"(phi^*)$\

//2. Найти $"Im"(phi^*)$\
\
*_Решение:_*
#align(center)[$[phi]_e = A, quad [phi^*]_(e^*) = A^T quad quad quad quad quad [phi]_e = A quad [phi^*]_(e^*) = A^T$] #v(0.4cm)
1. $"Ker"(phi^*)$
$"Ker"(phi) space = {x in X #h(0.32cm)| phi(x) = 0 <=> [phi] dot x = 0}$\ #v(0.4cm)
$"Ker"(phi^*) = {f in X^* | phi^*(f) = 0 <=> f dot [phi]^* = 0}$\ #v(0.4cm)

$phi(x) #h(0.25cm)= 0 <=> A dot x #h(0.35cm)= 0 <=> forall i in [1, n]: sum_(j = 1)^m A_(i j) dot x_j = 0$\ #v(0.4cm)
$phi^*(f) = 0 <=> f dot A^T = 0 <=> forall j in [1, n] : sum_(i = 1)^m f_i dot A^T_(i j) = 0  <=> forall j in [1, n] : sum_(i = 1)^m A_(j i) dot f_i = 0$
#line(angle: 0deg, length: 14.5cm)
#align(left)[$"Ker"(phi^*) = {f in X^* | nu_f = xi_x, space x in "Ker"(phi)}$]

#v(0.4cm)

2. $"Im"(phi^*)$
$"Im"(phi) space = {y in Y #h(0.32cm)| y = phi(x) <=> [phi] dot x = y}$\ #v(0.4cm)
$"Im"(phi^*) = {g in Y^* | g = phi^*(f) <=> f dot [phi]^* = g}$\ #v(0.4cm)

$phi(x) #h(0.25cm)= y <=> A dot x #h(0.35cm)= y <=> forall i in [1, n]:sum_(j = 1)^m A_(i j) dot x_j = y_i$\ #v(0.4cm)
$phi^*(g) = 0 <=> f dot A^T = f <=> forall j in [1, n]: sum_(i = 1)^m g_i dot A^T_(i j) = y_j <=> forall j in [1, n]: sum_(i = 1)^m A_(j i) dot g_i = y_j$

#line(angle: 0deg, length: 14.5cm)
#align(left)[$"Im"(phi^*) = {f in X^* | nu_f = xi_x, space x in "Im"(phi)}$]

#v(0.4cm)

\ 
*Задание:*\ #v(0.4cm)
$phi in "End"V quad V = "Ker"phi plus.circle "Im"phi quad quad <=> quad quad "Ker"phi^2 = "Ker"phi$\ #v(0.4cm)
То есть, доказать, что пространство раскладывается в прямую сумму ядра и образа тогда и только тогда, когда $"Ker"(phi) = "Ker"(phi^2)$ \ #v(0.4cm)
Мы знаем что для любого оператора $"Ker"(phi^2) >= 
"Ker"(phi)$\ 
Теперь пусть $"Ker"(phi^2) <= "Ker"(phi)$\ 
Рассмотрим некоторый $x in "Ker"(phi) sect "Im"(phi) => phi(x) = 0$\ #v(0.4cm)
$x = phi(y) => phi(x) = phi^2(y) = 0 => y in "Ker"(phi^2) => y in "Ker"(phi) => phi(y) = 0 = x => x = 0 => \ "Ker"(phi) sect "Im"(phi)={0} $ \ #v(0.4cm)
В обратную сторону: пусть $"Ker"(phi) sect 
"Im"(phi) = {0}$\
Найдем ядро квадрата: $phi(phi(x)) = 0 => phi(x) in "Ker"(phi) $ дописать 
\ \
*_Домашняя работа:_*\
+ Доказать, что ранг проектора равен его следу\
+ Доказать, что След(AB) = След(BA)
#v(0.4cm)
/*_*Решение:*_ #v(0.4cm)
1. _"Ранг проектора равен его следу"_

$ X = L_1 plus.circle L_2 $
#table(columns: (2.5fr, 10fr),
  inset: 0pt,
  stroke: none,
  //align: horizon,
  align(left)[
Базис $L_1 = display(vec(e_1, dots, e_k))$\ #v(0.6cm)
Базис $L_2 = display(vec(e_(k+1), dots, e_n))$
], [
$P_L_1$
])*/
#pagebreak()

= Повторение теории
$phi in "End"(x) <=> phi: X -> X$#v(0.2cm)
Собственный вектор:\
$x$ --- собственный вектор оператора $phi$, если $phi x = lambda x, lambda in K, lambda$ --- собственное значение\
$sigma_phi = {lambda_1, lambda_2, dots, lambda_k}$ --- спектр линейного оператора $phi$ --- множество всех собственных значений.
\ \
== Решение задач

#set math.mat(delim: "[")
#set math.vec(delim: "[")
+ $tau: RR_2^2 -> RR_2^2, quad tau A = A^T$\ #v(0.2cm)
  Хотим найти собственные значения и собственные вектора:\
  Введем базис в пространстве $RR_2^2$ #v(0.4cm)
  $M_1 = mat(1, 0;0, 0), quad M_2 = mat(0, 1;0, 0), quad M_3 = display(mat(0, 0;1, 0)), quad M_4 = display(mat(0, 0;0, 1))$\ #v(0.4cm)
  $tau M_1 = M_1 quad tau M_2 = M_3 quad tau M_3 = M_2 quad tau M_4 = M_4$\ #v(0.2cm)
  В пространсве матриц работать неудобно, поэтому построим изоморфизм из  $RR_2^2 " в " RR^4$:\ #v(0.4cm)
  $display(mat(a, b;c, d)) /*~*/ <-> (a, b, c, d)^T$\ #v(0.4cm)
  $A_tau = display(mat(1, 0, 0, 0;0, 0, 1, 0;0, 1, 0, 0;0, 0, 0, 1))$\ \
  $cal(X)_tau (lambda) = display(mat(1-lambda, 0, 0, 0;0, -lambda, 1, 0;0, 1, -lambda, 0;0, 0, 0, 1-lambda)) = (1-lambda)^2 (lambda^2-1  ) = -(1-lambda)^3 (1+lambda)$#v(0.2cm)
  $sigma_tau = {-1^((1)), 1^((3))}$#v(0.4cm)
  Найдем собственные вектора:\ #v(0.4cm)
  $phi x = lambda x <=> A x = lambda x <=> (A-lambda E)x = 0$\
  - $lambda_1 = -1$\ #v(0.4cm)
    $(A - lambda_1 E) = mat(2, 0, 0, 0; 0, 1, 1, 0; 0, 1, 1, 0; 0, 0, 0, 2) tilde display(mat(2, 0, 0, 0; 0, 1, 1, 0; 0, 0, 0, 2; 0, 0, 0, 0))$\ #v(0.4cm)
    $make x_3$ --- параметр, возьмем $x_3 = 1$:#v(0.4cm)
    $x_4 = 0, x_2 = -1, x_1 = 0 => v_1 = display(mat(0; -1; 1; 0)) tilde display(mat(0, -1;1, 0))$
  - $lambda_2 = 1^((3))$#v(0.2cm)
    #table(columns: (7fr, 10fr),
  inset: 0pt,
  stroke: none,
  align: horizon,
  align(left)[
    $(A - lambda_2 E) = display(mat(0, 0, 0, 0; 0, -1, 1, 0; 0, 1, -1, 0; 0, 0, 0, 0)) tilde display(mat(0, 1, -1, 0; 0, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, 0))$
    ],[
    $make x_1, x_3, x_4$ --- параметры#v(0.2cm)
    $make x_1 = 1, x_3 = x_4 = 0 => x_2 = 0$\
    $make x_3 = 1, x_1 = x_4 = 0 => x_2 = 1$\
    $make x_4 = 1, x_1 = x_3 = 0 => x_2 = 0$\
    ])\
    $display(mat(delim: "(", 1, 0, 0, 0))^T = display(mat(1, 0; 0, 0)) = v_2$#v(0.6cm)
    $display(mat(delim: "(", 0, 1, 0, 1))^T = display(mat(0, 1; 0, 1)) = v_3$#v(0.6cm)
    $display(mat(delim: "(", 0, 0, 0, 1))^T = display(mat(0, 0; 0, 1)) = v_4$#v(0.4cm)
    Собственный базис: ${v_1, v_2, v_3, v_4}$\ \
    $tau$ --- оператор скалярного типа $=> A_tau$ может быть диаганализована\ \
    #table(columns: (2fr, 10fr),
  inset: 0pt,
  stroke: none,
  align: horizon,
  align(left)[$tilde(A)_tau = display(mat(augment: #(vline: (1), hline: (1)), -1, 0, 0, 0; 0,1, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1))$],[ --- значения на диагоналях такие, т.к. это собственные значения. Порядок мог быть \ #h(0.4cm)каким угодно, но нельзя -1 ставить в любое место между 1,    т.к. значения должны \ #h(0.4cm) записываться по порядку ])\ #v(0.4cm)
    $tilde(A)'_tau = display(mat(1,0,0,0;0,1,0,0;0,0,1,0;0,0,0,-1))$ --- тоже вариант, но в базисе: ${v_2, v_3, v_4, v_1}$
\ 
2. #table(columns: (1.6fr, 10fr),
  inset: 0pt,
  stroke: none,
  align: horizon,
  align(left)[
  $A = display(mat(0, 1, 0; 0, 0, 1; 1, 0, 0))$],[
    ${x, y, z}$\
    $phi x = z, quad phi y = x, quad phi z = y $
  ])#v(0.4cm)
  $chi_phi (lambda) = det (A - lambda E) = display(mat(delim: "|", -lambda, 1, 0; 0, -lambda, 1; 1, 0, -lambda)) = lambda^3 - 1$ \ \
  $make KK = RR => lambda^3 = 1 => lambda = 1 => sigma_A = {1}$ (тут первая кратность и ее можно не писать)\ #v(0.4cm)
  $lambda = 1 => (A - lambda E) = display(mat(-1, 1, 0; 0, -1, 1; 1, 0, -1)) tilde display(mat(-1, 1, 0; 0, -1, 1; 0, 0, 0)) => v = display(vec(1,1,1))$#v(0.2cm)
  $tilde(A) = display(mat(augment: #(vline: (1), hline: (1)) ,1, 0, 0; 0; 0)) =>$
  в $RR$ диагонализовать нельзя
  \ \
  $make KK = CC$\
  $lambda^3 = 1 => lambda = cos (2 pi k)/3 + i sin (2 pi k)/3$\ #v(0.2cm)
  $k = 0 quad lambda_1 = 1$\ #v(0.3cm)
  $k = 1 quad lambda_2 = -1/2 + i 1/2 = e^((2 pi)/3) i$\ #v(0.3cm)
  $k = 2 quad lambda_3 = -1/2 - i 1/2 = e^((-2pi)/3 i)$\ #v(0.4cm)
  $tilde(A) = display(mat(1,0,0;0,e^((2pi)/3 i),0;0,0,e^(-(2pi)/3 i)))$#v(0.4cm)
  Над $CC$ матрица диагонализуема всегда, а над $RR$ --- не всегда.\
  

+ $cal(P)_2$ --- пространство однородных полиномов от двух переменных #v(0.2cm)
  $phi(p)(x, y) = x (diff p) / (diff y) + y (diff p) / (diff x)$ #v(0.2cm)
  Найти матрицу $A phi, $ собственные значения и собственные функции #v(0.2cm)
    $make {x^2, x y, y^2} $ --- базис $cal(P)_2(x, y)$\ #v(0.2cm)
  $phi(x^2) = 2 x y$\ #v(0.2cm)
  $phi(x y) = x^2 + y^2$\ #v(0.2cm)
  $phi(y^2) = 2 x y$ #v(0.4cm)
  $A_phi = display(mat(0,1,0;2,0,2;0,1,0))$ #v(0.4cm)
  $chi_phi (lambda) = abs(A - lambda E) = display(mat(-lambda,1,0;2,-lambda,2;0,1,-lambda)) = - lambda^3 + 4lambda  = -lambda (lambda - 2) (lambda + 2)$ #v(0.4cm)
  $sigma_phi = {-2, 0, 2}$ #v(0.4cm)
  $lambda = -2 => display(mat(2,1,0;2,2,2;0,1,2)) tilde display(mat(2,1,0;0,1,2;0,0,0)) => x_3 = 1 => x_2 = -2, x_1 = 1 => v_1 = vec(1, -2, 1) => p(x, y) = x^2 - 2 x y + y^2$ #v(0.6cm)
  $lambda = 0 => display(mat(0,1,0;2,0,2;0,1,0)) tilde display(mat(2,0,2;0,1,0;0,0,0)) => $
  $x_3=1 => x_2 = 0, x_1 = -1 => $
  $v_2 = vec(-1, 0, 1) => p_2 (x, y) = y^2 - x^2$ #v(0.6cm)
  $lambda = 2 => display(mat(-2,1,0;2,-2,2;0,1,-2)) tilde display(mat(-2,1,0;0,1,-2;0,0,0)) => x_3 = 1 => x_2 = 2, x_1 = 1 => v_3 = vec(1,2,1) => p_3  (x, y) = x^2 + 2x y + y^2$ #v(0.6cm)
  $tilde(A)_phi = display(mat(-2,0,0;0,0,0;0,0,2))$\ #v(0.4cm)
  
  Проверим, что $v_3$ --- собственный вектор\ #v(0.4cm)
  $A v_3 = display(mat(0,1,0;2,0,2;0,1,0)) display(vec(1,2,1)) = display(vec(2,4,2)) = 2 display(vec(1,2,1)) = lambda_3 v_3$\ #v(0.4cm)
  $tilde(A)_phi = S A T, quad S = T^(-1), space T = display(mat(1, -1, 1; -2, 0, 2; 1, 1, 1))$
+ $X = L_1 plus.dot L_2 plus.dot L_3 => forall x in X quad x =^! x_1  = x_1 + x_2 + x_3, quad x_j in L_j$\ #v(0.4cm)
  $phi in "End"(RR^3), A = display(mat(4,0,0;0,5,-1;0,-1,5)), tau_phi = {4^((2)), 6}$ #v(0.6cm)
  $v_1 = display(vec(0,1,1)), v_2 = display(vec(1,0,0)), v_3 = display(vec(0,-1,1))$\ #v(0.4cm)
  ${xi_i}_(i=1)^3$ и ${eta^j}_(j=1)^3$ --- сопряжённые базисы $=> forall x quad x = eta^1 (x) xi_1 + eta^2 (x) xi_2 + eta^3 (x) xi_3$\ #v(0.2cm)
  $x_j = eta^j (x) xi_j => cal(P)_L_1 (*) = xi_1 eta^1 (*)$ #v(0.4cm)
  $T = display(mat(0,1,0;1,0,-1;1,0,1)), quad S = T^(-1) = display(1/2 mat(0,1,1;1,0,0;0,-1,1))$\ #v(0.4cm)
  $phi = 4 cal(P)_(lambda = 4) + 6 cal(P)_(lambda = 6)$\ #v(0.2cm)
  $cal(P)_(lambda = 1) = cal(P)_v_1 + cal(P)_v_2$\ #v(0.2cm)
  $cal(P)_v_1 e_1 = (u^1, e_1) v_1 = display([1/2 mat(delim: "(", 0,1,1) vec(delim: "(", 1,0,0)]) dot display(vec(0,1,1)) = display(vec(0,0,0))$\ #v(0.6cm)
  $cal(P)_v_1 e_2 = (u^1, e_2) v_1 = display([1/2 mat(delim: "(", 0,1,1) vec(delim: "(", 0,1,0)]) dot display(vec(0,1,1)) = display(1/2vec(0,1,1))$#v(0.6cm)
  $cal(P)_v_1 e_3 = (u^1, e_3) v_1 = display([1/2 mat(delim: "(", 0,1,1) vec(delim: "(", 0,0,1)]) dot display(vec(0,1,1)) = display(1/2vec(0,1,1))$\ #v(0.4cm)
  $cal(P)_v_1 = display(1/2 mat(0,0,0;0,1,1;0,1,1))$\ #v(0.4cm)
  $cal(P)_v_2 e_j = (u^2, e_j) v_2 => cal(P)_v_2 = display(mat(1,0,0;0,0,0;0,0,0))$ #v(0.4cm)
  $cal(P)_(lambda=4) = cal(P)_v_1 + cal(P)_v_2 = display(1/2 mat(2,0,0;0,1,1;0,1,1))$\
  $cal(P)_(lambda=6) = display(1/2 mat(0,0,0;0,1,-1;0,-1, 1))$\
  $display(sum_(j=1)^3) cal(P)_L_j = cal(I), quad phi = limits(sum, inline: #false)^i lambda_j cal(P)_lambda_j $\
  $display(4 dot 1/2 dot mat(2,0,0;0,1,1;0,1,1) + 6 dot 1/2 mat(0,0,0;0,1,-1;0,-1,1) = mat(4,0,0;0,5,-1;0,-1,5)=A)$
