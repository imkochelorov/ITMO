#import "template.typ": *

#set page(margin: 0.55in)
#set par(leading: 0.55em, first-line-indent: 0em, justify: false)
#set text(font: "New Computer Modern")
#set heading(numbering: "1.1.")
#show raw: set text(font: "New Computer Modern Mono")
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
  title: "Дискретная математика\nII семестр",
  authors: (
    "_scarleteagle",
    "ikochelorov"
  ),
  date: "зима/весна 2024",
  subtitle: "Лектор: Станкевич Андрей Сергеевич"
)

#let def = strong("Определение:")
#let proof=par(strong("Доказательство:"))
#let th=strong("Теорема:")
#let lm=strong("Лемма:")
#let defnot = strong("Обозначение:")
#let qed=$space qed$
#let note=strong("Замечание:")
#let emptyset=$diameter$
#let dp(first, second)=$angle.l #first, #second angle.r$
#let ex(..number)= {
  if number.pos().len() == 0 {
    strong("Пример:")
  }
  else {
    strong("Пример " + str(number.pos().at(0)) + ":")
  }
}
#let cor(..number)= {
  if number.pos().len() == 0 {
    strong("Следствие:")
  }
  else {
    strong("Следствие " + str(number.pos().at(0)) + ":")
  }
}
#let ev = $upright(E)$
#let sd = $upright(D)$

#outline(title: "Оглавление", indent: auto)

#pagebreak()

#quote("Надеюсь, сессия прошла нормально", attribution: "Станкевич Андрей Сергеевич", block: true)

= Дискретная теория вероятностей

== Введение

Случайности и вероятности давно интересовали людей, _в основном в азартных играх_. Первые теоремы дискретной теории вероятностей появились задолго до появления первого конечного автомата. Но философы всех времён задаются вопросом --- "существует ли случайность?"

Философская мысль делится на 2 направления --- считающих, что случайности существуют, и #strike[остальных] детерминистов, считающих, что у нас просто недостаточно входных данных

*Это всё мы с вами изучать не будем*

== Аксиоматическая теория вероятностей
by _Андрей Николаевич Колмогоров_
\ \
_Бытовое восприятие случайностей мешает в понимании формальной модели_
\ \
#def множество элементарных исходов
\ $Omega$ --- множество всех возможных элементарных исходов случайного эксперимента, который может закончиться ровно одним из них\
$Omega$ может быть не более чем счётным, счётным, или не счётным. Но мы будем рассматривать дискретное множество элементарных исходов \
$|Omega|$ --- конечно или счётно
\ \
#def элементарный исход\ Элемент $omega in Omega$
\ \
#def дискретная плотность вероятности\ $p: Omega -> RR: p(omega >= 0), limits(sum)_(omega in Omega) p(omega) = 1$\
_Если $Omega$ несчётна, то требуется другая теория_
\ \
#def дискретное вероятностное пространство \ Пара из множества элементарных исходов и дискретной плотности вероятностей $(Omega, p)$
\ \
*Примеры:*
1. Честная монета: \ $Omega = {0, 1}, space p(0) = p(1) = 1/2$

2. Нечестная монета (распределение Бернулли):\ $Omega={0, 1}, space p(1) = p, space p(0)=1-p$

3. Честная игральная кость _(1d6)_: \ $Omega = {1, 2, 3, 4, 5, 6}, space p(i) = 1/6$
  1. "Честная" игральная кость (1d20): \ $Omega={1, dots, 20}, space p(20) = 1$

4. Колода карт:\ $Omega = {dp(r, s) | r = 1 dots 13, s = 1 dots 4 }, space p(dp(r, s))$
\
#def случайное событие \
Подмножество элементарных исходов $A subset Omega, quad P(A) = limits(sum)_(a in A)p(a)$\
Дискретное множество элементарных исходов является случайным событием
\ \
*Примеры:*
1. Пустое событие $P(emptyset)=0$

2. Достоверное событие (полное (?)) $P(Omega)=1$

3. _Для честной монеты_ $P({0}) = 1/2, quad P({1}) = 1/2$

4. _Для честной 1d6_ $P({1, 3, 5})=1/6 + 1/6 + 1/6 = 1/2, quad P({5, 6})=1/3, quad P({1,2,3})=1/2$
\ 
== Независимость событий
#def независимое случайное событие\
$A$ и $B$ независимы, если $P(A sect B)=P(A) dot P(B)$
\ \
*Примеры:*\
_Для честной игральной кости_ \ $"Even"={2,4,6}$,$quad "Big"={5,6}$,$ quad"Small"={1,2,3}$
- $P("Even" sect "Big")=P({6})=1/6 quad$
  $space space space P("Even") dot P("Big")=1/2 dot 1/3 = 1/6$
  
- $P("Even" sect "Small") = P({2}) = 1/6 quad$
  $P("Even") dot P("Small") = 1/2 dot 1/2 = 1/4$

- $P("Big" sect "Small") = P(emptyset)=0 quad$
  $space space space space space P("Big") dot P("Small") = 1/3 dot 1/2 = 1/6$
\
#def события, независимые в совокупности\
$A_1, A_2, dots, A_k$  -- независимы в совокупности, если
$forall I subset {1, 2, dots, k} quad P(limits(sect.big)_(i in I) A_i) = limits(product)_(i in I) P(A_i)$
\ \
*Примеры:*\
_Для броска двух разных честных монет_\
$Omega={00,01,10,11}, quad p(i dot j)=1/4$\
$A={01,00} , quad B={10,00}, quad C={11,00}$ не независимы в совокупности

\ \
== Прямое произведение вероятностных пространств
#def прямое произведение вероятностей пространств\
$dp(Omega_1, p_1), quad dp(Omega_2, p_2)$, прямое произведение пространств $Omega = Omega_1 times Omega_2: quad p(dp(u_1, u_2)) = p_1(omega_1) dot p_2(omega_2)$\ 
$limits(sum)_(dp(omega_1, omega_2) in Omega_1 times Omega_2) p(dp(omega_1, omega_2)) = sum p_1(omega_1) dot p_2(omega_2) = limits(sum)_omega_1(p_1(omega_1) dot limits(sum)_omega_2 p_2(omega_2)) = 1$\ //чекни формулу суммы перемножения
\

#ex()\ $A_1 subset Omega_1, space A_2 subset Omega_2 => A_1 times Omega_2 space$ и $space Omega_1 times A_2$ --- независимы\
$(A_1 times Omega_2) sect (Omega_1 times A_2) = A_1 times A_2$

== Условная вероятность
_имеет смысл, если $P(B) eq.not emptyset$_\  \

#columns(2)[
$P(A|B) = P(A sect B)/P(B), quad P(B)!=0$\ \
если $A$ и $B$ независимы, то \ $P(A|B)=(P(A) dot P(B))/P(B)=P(A)$\ \
$p_B (omega)=p(omega)/P(B), quad P_B (A)=P(A sect B)/P(B))$ #image("image.png", width: 50%)]

// Введение в теорию вероятностей. Вероятности не существует.
// Введение в теорию формальных языков

#th (_Формула полной вероятности_)\
$Omega = limits(underbrace(A_1 union A_2 union dots union A_k))_("полная система событий"), quad A_i sect A_j = emptyset$ при $i!= j$\ \
$B quad quad P(B|A_i)$\
$P(B) = limits(sum)_(i=1)^n P(B|A_i) P(A_i)$\
$limits(sum)_(i=1)^k P(B|A_i) P(A_i)=limits(sum)_(i=1)^k (P(B sect A_i))/P(A_i) dot P(A_i) = limits(sum)_(i=1)^k P(B sect A_i)=P(B)$
\ \
*Задача:*\
Две урны, в одной 3 черных и 2 белых, в другой 4 черных и 1 белый шар. С какой вероятностью можно вынуть черный шар? \
$A_1 quad A_2 quad 1/2$\
$P(B|A_1) = 3/5 quad P(B|A_2) = 4/5 quad P(B) = 3/5 dot 1/2 + 4/5 dot 1/2 = 7/10$
\ \
*Задача:*\
$P(B|A_i) quad P(A_i) quad $ найти $P(A_i|B) =$ ?\
Достоверность = 1 - $P(B|A_2)$ = $99%$\
Надёжность = $P(B|A_1)$ = $95%$\
$A_1$ --- болен ($1/100$)\ \
$A_2$ --- здоров ($99/100$)\
\
$P(A_1|B)=(0,95 dot 0,01)/(0,95 dot 0,01 + 0,01 dot 0,99)$
\ \
$P(B|A_i) = P(A_i sect B)/P(A_i)$
\ \
#def формула Байеса\ \
$P(A_i|B) = P(A_i sect B) / P(B) = (P(B|A_i) P(A_i))/(limits(sum)_(j = 1)^k P(B|A_j)P(A_j))$\
\ \
#def Байесовский спам-фильтр\
$A_1$ --- спам\
$A_2$ --- не спам\
$B$ --- критерий\
$P(B|A_1)$ --- вероятность выполнения критерия, если письмо спам _(можно посчитать)_\ 
$P(B|A_2)$ --- вероятность выполнения критерия, если письмо не спам _(можно посчитать)_\ \
Сам фильтр: $P(A_1|B)$ --- вероятность спама при выполнении критерия _(можно вычислить, используя значения выше)_

#pagebreak()

== Случайная величина

#def случайная величина\
$angle.l Omega, space p angle.r$ --- вероятностное пространство\
$xi: Omega -> RR$ --- _случайная величина (численная характеристика вероятностного эксперимента_
\ \
*Примеры:* \
Игральная кость\
$Omega = {1, space 2, space 3, space 4, space 5, space 6}$\
$xi(omega) = omega$\
$eta$ --- выигрыш Васи \ \
#ex(1)
\ _Вася получает 1 монету, если игральная кость падает нечётным числом и теряет 1 монету в ином случае:_ \
#table(columns: (15pt, auto, auto, auto, auto, auto, auto), sym.omega, "1", "2", "3", "4", "5", "6", sym.eta, "1", "-1", "1", "-1", "1", "-1")\
#ex(2)\
_Вася получает число монет, равное 2 в степени числа бросков кости, которые потребовались, чтобы выпало определённое число_   \
#table(columns: (15pt, auto, auto, auto, auto, auto), sym.omega, "1", "01", "001", "0001", sym.dots, sym.eta, "2", "4", "8", "16", sym.dots)
\ \
*Операции над случайными величинами:*\
Произведение с числом:\
$xi = c dot eta quad c in RR$\
Сумма случайных величин:\
$xi = eta + zeta$\
Произведение случайных величин:\
$xi = eta dot zeta$\
Возведение в степень случайной величины:\
$xi = eta^zeta$\
_Можно даже рассмотреть синус случайной величины_:\
$xi = sin zeta$
\ \
#def дискретная плотность распределения\
$xi$ --- случайная величина\
$f_xi : RR -> RR$ --- _дискретная плотность распределения_\
$f_xi (a) = P(xi=a) = P({omega | xi(omega) = a})$ 
\ \
#def функция распределения\
$xi$ --- случайная величина\
$F_xi: RR -> RR$ --- _функция распределения_\ $F_xi (a) = P(xi <= a)$
\ \
#ex()\
Подбросим 10 монет\
$Omega = BB^10$\
$xi(omega)$ --- число единиц\ \
$P(xi=a) = binom(10, a)/2^10$
\ \
$f(a) = F(a)-F(a - delta)$\
$F(a) = limits(sum)_(b<=a) f(b)$

== Математическое ожидание
#def математическое ожидание\
$xi : Omega -> RR$ --- случайная величина\
$ev xi = limits(sum)_(omega in Omega) xi(omega) dot p(omega)$ --- _математическое ожидание_
\ \
#ex()\ 
Игральная кость\
$Omega = {1, space 2, space 3, space 4, space 5, space 6}$\
$xi(omega)= omega$\
$ev xi = 1 dot 1/6 + 2 dot 1/6 + 3 dot 1/6 + 4 dot 1/6 + 4 dot 1/6 + 5 dot 1/6 + 6 dot 1/6 = 3.5$\ \
Легко заметить, что 3.5 никогда не выпадает на игральной кости\
Математическое ожидание не означает наиболее вероятные исход
\ \
#ex(1)\
_Вася получает 1 монету, если игральная кость падает нечётным числом и теряет 1 монету в ином случае:_ \
#table(columns: (15pt, auto, auto, auto, auto, auto, auto), sym.omega, "1", "2", "3", "4", "5", "6", sym.eta, "1", "-1", "1", "-1", "1", "-1")
$E xi = 0$\
Математическое ожидание равно 0, но при этом, после 1 игры, Вася либо получит монету, либо потеряет
\
\
#ex(2) \
_Вася получает число монет, равное 2 в степени числа бросков кости, которые потребовались, чтобы выпало определённое число_   \
#table(columns: (15pt, auto, auto, auto, auto, auto), sym.omega, "1", "01", "001", "0001", sym.dots, sym.eta, "2", "4", "8", "16", sym.dots)
$ev_xi = +infinity$\
Математическое ожидание может равняться $+infinity$\ \

$ev c = c$\
Математическое ожидание константы равняется константе
\
\
*Линейность математического ожидания:*\
#th\
$xi = c dot eta quad ev xi = c dot ev eta$\
$xi = eta + zeta quad ev xi = ev eta + ev zeta$\ \
$ev (eta + xi) = limits(sum)_(omega in Omega)(eta + zeta)(omega)= limits(sum)_(omega in Omega)(eta(omega) + zeta(omega)) =ev eta + ev zeta$
\
\
*Примечание:*\
Если $|Omega| = +infinity$, то $exists ev xi space <=> exists ev (|xi|)$
\
\
#ex()\
$xi$ --- выпало на верхней грани игральной кости D6\
$eta$ --- выпало на нижней грани\
$ev xi = 3.5, ev eta = 3.5$\
$ev (xi+eta) = 7$\
_Вне зависимости от расположения значений на игральной кости относительно друг друга_
\ \
#ex()\
$Omega = S_n$ --- перестановки $n$ элементов\
$abs(Omega) = n!$\
$xi(sigma) = abs({i | sigma_i = i})$ --- количество неподвижных точек\
$n = 3 quad xi(angle.l 1, 3, 2 angle.r) = 1$\
$ev xi = 1$\
Мы можем посчитать математическое ожидание, не зная распределение

\
$xi_i = cases(1\, quad sigma_i = i, 0\, quad "иначе")$\
$xi_1 (1 space 3 space 2)=1$\
$xi_2 (1 space 3 space 2)=0$\
$xi_3 (1 space 3 space 2)=0$\ \
$xi = limits(sum)_(i=1)^n xi_i$\
$P(xi_i = 1) = 1/n$\
$ev xi_i = 1 dot P(xi_i = 1) + 0 dot P(xi_i=0) = 1/n$\
$ev xi = limits(sum)_(i=1)^n 1/n = 1$
\ \
#th\
$ev xi = limits(sum)_a a dot P(xi = a)$\
$limits(sum)_(omega in Omega) xi(omega) p(omega) = limits(sum)_a limits(sum)_(omega: xi(omega)=a) xi(omega) p(omega) = limits(sum)_a a limits(sum)_(omega: xi(omega) = a) p(omega) = limits(sum)_a a dot P(xi = a)$

\ \
#def независимые случайные величины\
$xi$ и $eta$ --- _независимы_, если\
$forall a,b in RR quad [xi <= a] " и " [eta <= b]$ --- _независимые случайные события_\
$P(xi <= a and eta <= b) = P(eta <= a) dot P(eta <= b)$\ \
*Замечание*:\
$xi" и" eta $ --- независимые, если \ $forall a, b in RR quad [xi = a] " и " [eta = b]$ --- независимые\
_Работает за исключением патологических случаев, которые мы не будем рассматривать_
\ \
#ex(1)\
$P(xi = 1) = 1/2$ --- вероятность того, что Вася выиграл 1 монету \ \
$P(eta=2)=1/6$ --- вероятность выпадения на игральной кости 2\ \
$P(xi=1 and eta=2)=0$
\ \
#ex(2)\
#table(columns: (auto, auto, auto), $attach("", bl: eta, tr: xi)$, "-1", "1", "0", $1/3$, $1/3$, "1", $1/6$, $1/6$)
\
#th\
$xi$ и $eta$ независимы $=> ev(xi dot eta) = ev(xi) dot ev(eta)$\ \
$ev(xi dot eta) = limits(sum)_a a dot P(xi dot eta = a) = limits(sum)_a limits(sum)_b limits(sum)_(c:b dot c=a) b c dot P(xi=b and eta =c)=limits(sum)_a limits(sum)_b limits(sum)_(c:b dot c=a) b c P(xi = b) P(eta = c)=$$=limits(sum)_b b limits(sum)_c c P(xi=b)P(eta=c)=ev xi dot ev eta$
== Дисперсия
_Вступление:_ \
Давайте посчитаем математическое ожидание отклонения этой случайной величины от ее математического ожидания. Внезапно обнаружим, что оно равняется 0\ $ev(xi - ev xi) = ev xi - ev ev xi = ev xi - ev xi = 0$  #emoji.face.down\ \
#def дисперсия\
$sd xi = ev (xi - ev xi)^2 $ --- _дисперсия_ \ 
$ev(xi - ev xi)^2 =  ev(xi^2 - 2 xi ev xi + (ev xi)^2) = ev xi^2 - 2 ev xi ev xi + (ev xi)^2 = ev xi^2 - (ev xi)^2$\
_На английском:_ $"Var" xi$\ \


$sd c xi = c^2 sd xi$\
$sd (xi + eta) = ev(xi+eta)^2 - (ev(xi+eta))^2 = ev xi^2 + 2 ev xi eta + ev eta^2 - (ev xi)^2 + 2 ev xi ev eta - (ev xi)^2 = sd xi + sd eta + 2(ev xi eta - ev xi ev eta)$\ \
#def ковариация\
$ev xi eta - ev xi ev eta = "Cov"(xi, space eta)$ --- _ковариация_


/*
= TODO: Теория формальных языков
/* TODO */
*\/\/ TODO* // TODO
- TODO
+ TODO
```py
# TODO
```
```cpp
// TODO
```
*#underline("T.O.D.O.")
*/
