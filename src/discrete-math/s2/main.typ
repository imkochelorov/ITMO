#import "template.typ": *
#import "@preview/finite:0.3.0"
#let automaton=finite.automaton

#set page(margin: 0.55in, height: auto,numbering: "1/1")
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
    "imkochelorov",
    "AberKadaber"
  ),
  date: "зима/весна 2024",
  subtitle: "Лектор: Станкевич Андрей Сергеевич"
)

#let make = sym.supset.sq
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
#table(columns: (0.15fr, 10fr),
  inset: 0pt,
  stroke: none,
  //align: horizon,
  [#line(angle: 90deg, length: 5.6em)],[Случайности и вероятности давно интересовали людей, _в основном в азартных играх_. Первые теоремы дискретной теории вероятностей появились задолго до появления первого конечного автомата. Но философы всех времён задаются вопросом --- "существует ли случайность?"
Философская мысль делится на 2 направления --- считающих, что случайности существуют, и #strike[остальных] детерминистов, считающих, что случайностей не существует, просто у нас недостаточно данных о мире])

*Это всё мы с вами изучать не будем*

== Аксиоматическая теория вероятностей
by _Андрей Николаевич Колмогоров_
\ \
#align(center)[_Бытовое восприятие случайностей мешает в понимании формальной модели_]
\
#def #underline[множество элементарных исходов]
\ #v(0.1cm) $Omega$ --- множество всех возможных элементарных исходов случайного эксперимента, который может закончиться ровно одним из них\
$Omega$ может быть не более чем счётным, счётным, или не счётным. Но мы будем рассматривать дискретное множество элементарных исходов \
$|Omega|$ --- конечно или счётно
\ \
#def #underline[элементарный исход]\ #v(0.1cm) Элемент $omega in Omega$
\ \
#def #underline[дискретная плотность вероятности]\ #v(0.1cm) $p: Omega -> RR: p(omega >= 0), limits(sum)_(omega in Omega) p(omega) = 1$\ #v(0.1cm)
_Если $Omega$ несчётна, то требуется другая теория_
\ \
#def #underline[дискретное вероятностное пространство] \ #v(0.1cm) Пара из множества элементарных исходов и дискретной плотности вероятностей $(Omega, p)$
\ \
*Примеры* дискретных вероятностных пространств*:*
1. _Честная монета:_ \ #v(0.1cm) $Omega = {0, 1}, space p(0) = p(1) = 1/2$

2. _Нечестная монета (распределение Бернулли):_\ #v(0.1cm) $Omega={0, 1}, space p(1) = p, space p(0)=1-p$

3. _Честная игральная кость _(1d6)_:_ \ #v(0.1cm) $Omega = {1, 2, 3, 4, 5, 6}, space p(i) = 1/6$ #v(0.2cm)
  - _"Честная" игральная кость (1d20):_ \ #v(0.1cm) $Omega={1, dots, 20}, space p(20) = 1$

4. _Колода карт:_\ #v(0.1cm)$Omega = {dp(r, s) | r = {♠,  ♥,  ♦,  ♣}, s = {2, 3, 4, 5, 6, 7, 8, 9, 10, J, Q, K, A}}, space p(dp(i, j)) = 1/52$  
\
#def #underline[случайное событие] \ #v(0.1cm)
Подмножество элементарных исходов $A subset Omega, quad P(A) = limits(sum)_(a in A)p(a)$
\
#table(columns: (0.15fr, 10fr),
  inset: 0pt,
  stroke: none,
  //align: horizon,
  [#line(angle: 90deg, length: 3.3em)],
  [Бытовое понимание случайного события отличается от его формального определения. Большинству людей бытовое мышление говорит, что случайное событие --- это, собственно, событие, которое либо произойдёт, либо не произойдёт. Но формально, случайное событие --- это набор элементарных исходов ])
\
*Примеры* случайных событий*:*
1. _Пустое событие:_ \ #v(0.1cm) $P(emptyset)=0$

2. _Достоверное событие:_\ #v(0.1cm) $P(Omega)=1$

3. _Случайные события над честной монетой:_\ #v(0.1cm) $P({0}) = 1/2, quad P({1}) = 1/2$

4. _Случайные события над честной костью 1d6:_ \ #v(0.1cm)$P({1, 3, 5})=1/6 + 1/6 + 1/6 = 1/2, quad P({5, 6})=1/3, quad P({1,2,3})=1/2$
\
== Независимость событий
#table(columns: (0.15fr, 10fr),
  inset: 0pt,
  stroke: none,
  //align: horizon,
  [#line(angle: 90deg, length: 5.6em)],
  [Мы узнали формальное определение случайного события. Теперь давайте формализуем независимость нескольких событий. Бытовая логика нам говорит, что независимые события --- это такая пара событий, в которой вероятность наступление одного никак не влияет на наступление другого.\ Но формально определение звучит так: случайные события являются независимыми, если вероятность наступления их пересечения равна вероятности их наступления по отдельности])
  
#def #underline[независимые случайные события]\ #v(0.1cm)
$A$ и $B$ независимы друг от друга, если $P(A sect B)=P(A) dot P(B)$
\ \
*Примеры* независимости событий*:* _(честная игральная кость d6)_ \  #v(0.2cm) 
#align(center)[$"Even"={2,4,6}$,$quad "Big"={5,6}$,$ quad"Small"={1,2,3}$]
- $P("Even" sect "Big")=P({6})=1/6 quad$
  $space space space P("Even") dot P("Big")=1/2 dot 1/3 = 1/6 space quad =>$  $P("Even") " и " P("Big")$ --- независимы
  
- $P("Even" sect "Small") = P({2}) = 1/6 quad$
  $P("Even") dot P("Small") = 1/2 dot 1/2 = 1/4$

- $P("Big" sect "Small") = P(emptyset)=0 quad$
  $space space space space space P("Big") dot P("Small") = 1/3 dot 1/2 = 1/6$
\
#def #underline[события, независимые в совокупности]\ #v(0.1cm)
$A_1, A_2, dots, A_k$  -- независимы в совокупности, если
$ forall I subset {1, 2, dots, k} quad P(limits(sect.big)_(i in I) A_i) = limits(product)_(i in I) P(A_i) $

*Пример:* _(бросок двух разных честных монет_)\ #v(0.1cm)
$Omega={00,01,10,11}, quad p(i dot j)=1/4$\ #v(0.2cm)
$A={01,00} , quad B={10,00}, quad C={11,00}$ --- не независимы в совокупности
\ \
== Прямое произведение вероятностных пространств
#def #underline[прямое произведение вероятностей пространств]\ #v(0.1cm)
$dp(Omega_1, p_1), quad dp(Omega_2, p_2)$, прямое произведение пространств $Omega = Omega_1 times Omega_2: quad p(dp(u_1, u_2)) = p_1(omega_1) dot p_2(omega_2)$\ 
$limits(sum)_(dp(omega_1, omega_2) in Omega_1 times Omega_2) p(dp(omega_1, omega_2)) = sum p_1(omega_1) dot p_2(omega_2) = limits(sum)_omega_1(p_1(omega_1) dot limits(sum)_omega_2 p_2(omega_2)) = 1$\ //чекни формулу суммы перемножения
\

#ex()\ $A_1 subset Omega_1, space A_2 subset Omega_2 => A_1 times Omega_2 space$ и $space Omega_1 times A_2$ --- независимы\
$(A_1 times Omega_2) sect (Omega_1 times A_2) = A_1 times A_2$

== Условная вероятность
_имеет смысл, если $P(B) eq.not emptyset$_\  \

#columns(2)[$P(A|B) = P(A sect B)/P(B), quad P(B)!=0$\ \
если $A$ и $B$ независимы, то \ $P(A|B)=(P(A) dot P(B))/P(B)=P(A)$\ \
$p_B (omega)=p(omega)/P(B), quad P_B (A)=P(A sect B)/P(B))$ #colbreak() #image("1.png", width: 50%)]

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
$xi: Omega -> RR$ --- _случайная величина (численная характеристика вероятностного эксперимента)_
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
$ev (eta + zeta) = limits(sum)_(omega in Omega)(eta + zeta)(omega)= limits(sum)_(omega in Omega)(eta(omega) + zeta(omega)) =ev eta + ev zeta$
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
$sd (xi + eta) = ev(xi+eta)^2 - (ev(xi+eta))^2 = ev xi^2 + 2 ev xi eta + ev eta^2 - (ev xi)^2 - 2 ev xi ev eta - (ev xi)^2 = sd xi + sd eta + 2(ev xi eta - ev xi ev eta)$\ \
#def ковариация\
$ev xi eta - ev xi ev eta = "Cov"(xi, space eta)$ --- _ковариация_

#pagebreak()

$Omega, space p$ --- вероятностное пространство\ #v(0.2cm)
$xi: Omega -> RR$ ---  случайная величина _(численная характеристика вероятностного эксперимента)_\ #v(0.2cm)
$E xi = limits(sum)_(omega in Omega) xi (omega) dot p(omega) = limits(sum)_a a dot p(xi = a)$ --- мат ожидание\ #v(0.2cm)
$E(xi + eta) = E xi + E eta $ --- мат ожидание суммы равно сумме мат ожиданий\ #v(0.2cm)
$F_xi (a) = P(xi <= a)$ --- функция распределения случайной величины\ #v(0.2cm)
$f_xi (a) = P(xi = a)$ --- плотность случайной величины\ #v(0.2cm)
$xi " и " eta$ --- независимые для $forall alpha space  beta$, если $[xi = alpha] " и " [eta = beta]$\ #v(0.2cm)
$xi " и " eta$ --- независимые $=> E(xi, eta) = E xi dot E eta$\ #v(0.2cm)
\
$D xi = E(xi - E xi)^2 = E xi^2 - (E xi)^2$ --- дисперсия\ #v(0.2cm)
$xi "и " eta$ независимые $=> D(xi + eta) = D xi + D eta$\ #v(0.2cm)
$D(xi + eta) = D xi + D eta + 2(E xi eta - E xi dot E eta)$\ #v(0.2cm)
$"Cov"(xi, space eta)= E xi eta - E xi dot E eta$ --- ковариация\ #v(0.2cm)
$xi " и " eta $ независимые $=> "Cov"(xi, space eta) = 0$\ #v(0.2cm)
$"Cov"(xi, xi) = E(xi dot xi) - E xi dot E xi = D xi$ \ #v(0.2cm)
$"Cov"(xi, -xi) = - E xi^2 + (E xi)^2 = - D xi$ --- ковариация может быть отрицательной#v(0.1cm)
\ \
#th\ #v(0.2cm)
$"Cov"(xi, eta)^2 <= D xi dot D eta$
\ \
#def корреляция\ #v(0.2cm)
$"Corr"(xi, eta) = ("Cov"(xi, eta))/sqrt(D xi dot D eta)$ --- _корреляция_\ #v(0.2cm)
$-1 <= "Corr"(xi, eta) <= 1$\
\
$D xi = 0 <=> E(xi - E xi)^2 = 0 <=> p(omega) > 0 => xi(omega) = E xi$\
Корреляции с константой не бывает, иначе в формуле деление на ноль\

\ \
#th\ #v(0.2cm)
$"Corr"(xi, eta) &= 1 quad <=> quad  xi = c dot eta, space &c > 0 \ &= -1 &c < 0 $
\ \
Корреляция не означает причинно-следственной связи
\ \
== Хвостовые неравенства

#image("2.png", width: 50%)

*Задача:*\
Средняя зарплата 10 опрошенных человек --- 50  тысяч. Сколько максимум человек может иметь зарплату больше или равную 250 тысяч рублей?\
Максимум 2 человека, в случае, если 8 остальных имеют нулевую зарплату
\
\
*Неравенство Маркова* _"очень богатых не может быть очень много"_\ #v(0.2cm)
$xi > 0 quad E xi$\ #v(0.2cm)
$P(xi >= c dot E xi) <= 1/c$ #v(0.2cm)
*Доказательство:*\ #v(0.2cm)
$P(xi >= c dot E xi) = limits(sum)_(omega : xi >= c dot E xi) p(omega)$\ #v(0.2cm)
$E xi = limits(sum)_omega p(omega) dot xi (omega) =$\ #v(0.2cm)
$= limits(sum)_(omega: xi(omega) >= c dot E xi) p(omega) dot xi(omega) + limits(sum)_(omega: xi(omega) < c dot E xi) p(omega) dot xi(omega) >=$ \  #v(0.2cm)
$>= limits(sum)_(omega : xi(omega) >= c dot E xi) p(omega) dot c dot E xi$\ #v(0.2cm)
$E xi >= c dot E xi dot P (xi >= c dot E xi)$\ #v(0.2cm)
$P(xi >= c dot E xi) <= 1/c$
 
#columns(2)[
#image("3.png") #colbreak() #image("4.png")]\

$D xi = E(xi - E xi)^2$\ #v(0.2cm)
$eta = (xi - e xi)^2$\ #v(0.2cm)
$P(eta >= c ^ 2 E eta) <= 1/c^2$\ #v(0.2cm)
$P((xi - E xi)^2 >= c^2 D xi) <= 1/c^2$\ #v(0.2cm)
$P(|xi - E xi|) >= c dot sqrt(D xi)) <= 1/c^2$\ \


#def среднеквадратическое отклонение\ #v(0.2cm)
$sigma = sqrt(D xi)$\
\
#th неравенство Чебышева\ #v(0.2cm)
$P(|xi - E xi| >= c dot sigma) <= 1/c^2$\
\ \
$P(eta >= alpha) quad alpha^2 = c^2 E eta quad c^2 = alpha^2 / (D xi)$\ #v(0.2cm)
$P(|eta - E eta| <= alpha) <= (D xi) / alpha^2$\ \
\
$xi quad n$ раз $1/n limits(sum)^n_(i = 1) xi_i = eta$\ #v(0.2cm)
$xi_i$ --- о. р. незав. сл. величины\ #v(0.2cm)
$E eta = E xi$\ #v(0.2cm)
$D eta = 1/n^2 dot n D xi = 1/n D xi$\
\
нет. м. о. $mu$\ #v(0.2cm)
$P(|xi - mu| >= alpha) <= (D xi)/alpha^2 = epsilon$\ #v(0.2cm)
$P(|eta - mu| >= alpha) <= (D eta)/ alpha^2 = epsilon/n$\
\
Для какого $alpha$\
$P(|xi - mu| >= alpha) <= epsilon$\
\
$(D xi) / alpha^2 <= epsilon$\ #v(0.2cm)
$alpha^2 >= 1/epsilon dot D xi$\ #v(0.2cm)
$alpha >= sqrt(1/epsilon dot D xi) = N_0$\ #v(0.2cm)
$alpha >= sqrt(1/epsilon D dot eta) = 1/sqrt(n) dot N_0$
\ \

#def распределение Бернулли\
$0, 1 quad p(1) = p, space p(0) = q, quad xi_i $\ #v(0.2cm)
$xi = limits(sum)_(i = 1)^n xi_i quad E xi = n p$\ #v(0.2cm)
$P(|xi - n p| >= |1/2 n - n p|)$

#image("5.png", width: 40%)

$P_"err" <= P(|xi - n p| >= |1/2 n - n p|)$
\ \ \

$P(n p - xi >= n p - 1/2 n)$\
$P(xi <= (1/2 n - n p) + n p)$\
$P(xi <= n p ((1/(2p) - 1) + 1)) quad 1/(2p) - 1 = delta$\
$P(xi <= n p (1 - delta))$\
$P(xi >= n p (1 + delta))$ --- симметричная ситуация
\ \
#th граница Чернова\
\
$P(xi <= n p (1 - delta)) &\
& quad <= e^(-delta^2/2 n p)  \
P(xi >= n p (1 + delta)) &$

\ \
$e^(-1/(54) n) <= epsilon$\
\
$-1/54 n <= ln epsilon $\
\
$n >= 54 ln 1/epsilon$\ \ \

$xi quad t quad eta = e^(t xi)$\ \
$P(eta >= e^(t alpha)) <= (E eta) / e^(t alpha)$\ \
$E eta = E e^(t xi) - E e^(t limits(sum)_(i = 1)^n xi_i) = E limits(product)_(i = 1)^n e^(t  xi_i) = limits(product)_(i = 1)^n E e^(t xi_i) = limits(product)_(i = 1) ^ n (p dot e^t + 1 - p)$

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

#pagebreak()

#quote("Сегодня будет не так весело, как на вчерашней лекции парадигм", attribution: "Станкевич Андрей Сергеевич", block: true)
_Что такое информация?_\
#v(0.4cm)
== Энтропия
_информация = -неопределённость_
\ \
#def энтропия случайнго источника\ #v(0.2cm)
_Количество информации, приходящейся на одно сообщение источника_\ #v(0.2cm)
$Omega = {1, 2, dots, n}$ --- _вероятностное пространство (случайный источник)_\ #v(0.2cm)
Вероятности $p_1, p_2, dots, p_n$
\ #v(0.2cm)
$H(p_1, p_2, dots, p_n)$ --- _энтропия случайного источника_\
\ \
*Свойства:*\ 
+ $H$ непрерывна

+ $H(1/n, 1/n, dots 1/n)$ возрастает при росте $n$

+ Закон аддитивности\ #v(0.2cm)
  $Omega = {(i, j), space i = 1dots n, space j = 1 dots m_i }$\ #v(0.2cm)
  $p_i = P(w."first" = i)$\ #v(0.2cm)
  $limits(sum)_(i = 1)^n p_i = 1$\ #v(0.2cm)
  $q_(i j) = p(w."second" = j | w."first" = i)$\ #v(0.2cm)
  $limits(sum)_(j = 1)^m_i q_(i j) = 1$\ #v(0.2cm)
  $p((i, j)) = p(w."first = i") dot p(w."second" = j | w."first" = i) = p_i dot q_(i j)$\ #v(0.2cm)
  $H(p_1q_(1 1), p_1 q_(1 2), dots, p_1 q_(1 m_1), p_2 q_(2 1), dot, p_n q_(n m)) = H(p_1, p_2, dots, p_n) + limits(sum)_(i = 1)^n p_i dot H(q_(i 1), q_(i 2), dots, q_(i m_i))$
\ \
$h(n) = H(1/n, 1/n, dots 1/n) quad h: NN -> RR$\ #v(0.2cm)
$h(n) arrow.tr$ \ #v(0.2cm)
$p_i = 1/n, space q_(i j) = 1/m$ \ #v(0.2cm)
$h(m dot n) = h(n)$\ #v(0.2cm)
Такая функция единственна --- логарифм. Докажем это\ #v(0.4cm)
$h(n) = space ?$\ #v(0.4cm)
$i quad h(n^i) = i dot h(n)$\ #v(0.4cm)
$display(2^k <= n^i <= 2^(k+1) quad quad k = floor(log_2 n^i) = floor(i dot log_2 n))$\ #v(0.4cm)
$display(k dot h(2) <= i dot h(n) <= (k + 1)h(2))$\ #v(0.4cm)
$display(h(2) floor(i dot log_2 n)/i <= h(n) <= h(2) (floor(i dot log_2 n) + 1)/i)$\ #v(0.4cm)
$display(forall i abs(h(n) - floor(i dot log_2 n)/i) < 1/i)$\ #v(0.4cm)
$display(floor(i dot log_2 n) = i dot log_2 n = {i dot log_2 n})$\ #v(0.4cm)
$display(abs(h(n)/h(2) - log_2 n + {i dot log_2 n}/i) < 1/i)$\ #v(0.4cm)
$display(h(n)/h(2) = log_2 n quad quad h(2) = c)$\ #v(0.4cm)
$h(n) = c dot log_2 n$\ #v(0.4cm)
Бит, если $c = 1$
\ \ \
$display(p_i = a_i/b quad quad q_(i j) = 1/a_i quad m_i = a_i)$\ #v(0.4cm)
$H(p_i q_(i j)) = H(p_i) + sum p_I H(q_(i j))$\ #v(0.4cm)
$h(b) = H(p_1 dots p_n) + sum(p_i h(a_i))$\ #v(0.4cm)
$limits(sum)_(i = 1)^n p_i dot log_2 b = H(p_1 dots p_n) + limits(sum)_(i = 1)^n p_i dot log_2 a_i$\ #v(0.4cm)
$-limits(sum)_(i = 1)^n (p_i(log_2 a_i - log_2 b)) = H(p_1 dots p_n)$\ #v(0.4cm)
$H(p_1 dots p_n) = - limits(sum)_(i = 1)^n p_i dot log p_i$

\ \ \
*Пример 1:*\ #v(0.2cm)
Возьмём TeX исходник учебника математического анализа, представимый в виде строки. Рассмотрим все символы в нём и вероятность получить конкретный символ, взяв случайный. Получим энтропию учебника математического анализа --- количество информации. Но это не лучшая оценка информации учебника математического анализа, потому что после случайной перестановки символов энтропия (количество информации) не изменится, но количество информации по математическому анализу приравняется к 0
\ \ 
*Пример 2:*\ #v(0.2cm)
Возьмём случайную строку длинной в миллион символов (число информации несколько миллионов бит). Лучший способ передать её (информацию о ней) --- передать весь миллион символов (несколько миллионов бит _возможно после небольшого сжатия_)\
Если мы захотим передать эту строку по телефонному звонку, нам придётся диктовать весь миллион символов. Но если мы просто захотим передать не фиксированную случайную строку в миллион символов, достаточно сказать "запиши случайную строку в миллион символов". В обоих случаях количество переданной информации равно, но усилия для передачи не равны
\ \ \
#def сложность по Колмогорову\ #v(0.2cm)
$S in Sigma^*$\ #v(0.2cm)
$K(S)$ --- наименьшая длина программы, выводящей $S$ на пустом входе\ #v(0.2cm)
$abs(K_"c++" (S) - K_"java" (S)) <= C_"c++, java" quad$\ #v(0.2cm) 
Можно написать на языке проргаммирования Java интерпретатор язык программирования C++\
Его размер не зависит ни от размера программы на C++, ни от $S$ --- константа\ #v(0.2cm)
$K(S) quad S$ случайнвя строка длины $n$\ #v(0.2cm)
$K(S) = Omega(n)$ "почти наверное"\ #v(0.2cm)
$S = (01)^n quad K(S) = O(log_2 n)$


#quote("С++ плохо выбирать, потому что он такой. Немного мерзкий язык. Выберем математическую модель C++", attribution: "Станкевич Андрей Сергеевич", block: true)

*Пример 1:*\ #v(0.2cm)
Колмогоровская сложность учебника по математическому анализу меньше, чем колмогоровская сложность случайной строки. _Доказательства не будет_
\ \
Кодирование Хаффмана --- оптималльный префиксный код, независимо кодирует $forall$ символ
\ \
Арифметическое кодирование ---\ #v(0.2cm)
$L quad f_i$\ #v(0.2cm)
$p/z^q quad q tilde.eq - L limits(sum)_(i = 1)^n f_i/L log_2 f_i/L = L dot H(f_1/L, dots , f_n/L)$ --- _энтропийный барьер_\ #v(0.2cm)
Арифметическое кодироание --- оптимальный алгоритм кодирования, не учитывающего взаимного расположения символов\ #v(0.2cm)
_Доказательство минимальной асимптотики алгоритма сортировки с помощью энтропийного барьера:_
\ #v(0.2cm)
$h(n!) = log_2(n!) tilde.eq log_2(n^n/e^n sqrt(2 pi n)) = n dot log_2 n - n dot log_2 e + log sqrt(2 pi n) = Sigma(n dot log n)$

#pagebreak()

//*Организационные объявления*: через 2 недели следующая вычислительная работа.
//Сейчас выставлены некоторые результаты вычислетильного теста. Восстановившиеся и переводящиеся должны обратиться к практикам, чтобы их данные были выставлены\
//Следующие 2 недели очных лекций не будет. _Следите за объявлениями_
//"Кто-нибудь", как он завуалировал "Иван Кочелоров" // )))

== Марковские цепи
#def Марковский процесс\
//Должно напомнить идею динамического программирования\
Процесс, дальшйшее происходящее которого зависит от текущего состояния и не зависит от истории
\ \
#ex()\
Не марковские процессы:\
  + Ваше обучение в ВУЗе 
  + обход графа в ширину и глубину
  
\ \

Если состояний Марковского процесса конечное число, а выбор нового состояния осуществляется случайно, 
\ \
#def Марковская цепь\
Математичский объект состоящий из:
+ Множество состояний $S = {1, 2, dots, n}$ --- _конечное множество_

+ Матрица переходов $P_(n times n) space P_(i j) = P(v_(t+1) = j | v_T = i)$ --- вероятность перейти из $i_"ого"$ состояния в $j_"ое"$ 
+ Начальное распределение вероятностей $c^((0)) = (c_1^((0)) dots c_n^((0)))$\ \
  $c^((t)) = (c_1^((t)), c_2^((t)), dots, c_n^((t))) quad limits(sum)_(i = 1)^n c_i^((0)) = 1$\ \
  $c_j^((t+1)) = limits(sum)_(j=1)^n P(v_(t+1)=j|v_t=i) = limits(sum)_(i=1)^n p_(i j)c_i^((t))$
\ \
*Основное уравнение Марковских цепей*:\
$ c^((t+1)) = c^((t))dot P = c^((t-1)) dot P dot P $\
В общем случае на $t-"ом"$ шаге: $c^((t)) = c^((0))P^t$
\ \

#ex()\
Студент решает, пойти ему в ВУЗ или нет. Рассмотрим его решения, как Марковскую цепь с 2 состояниями --- *учиться* и *играть*. Из состояния учиться он с вероятностью 0.5 остается учиться и с вероятностью 0.5 уходит играть. Из состояния играть он с вероятность 0.9 остается играть и с вероятностью 0.1 идет учиться

#align(center)[#image("6.png", width: 50%) _Марковский граф_]\
Состояние 1 - учиться, состояние 2 - играть\ \
$P = display(mat(augment: #(vline: ()),
0.5, 0.5;
0.1, 0.9;)) 
$ \ \

#table(
  columns: (9cm, auto),
  stroke: none,
[
#def Компонента сильной связности (эргодический класс)\ #v(0.1cm)
Компонента сильной связности - множество вершин, из каждой вершины которой можно попасть в любую другую вершину\ \
#def Эргодическая Марковская цепь\ #v(0.1cm)
Марковская цепь, состоящая из одного эргодического класса\ \
#def Диаграмма порядка\ #v(0.1cm)
Диаграмма порядка --- граф, получаемый при "объединении" эргодических классов в одну вершину\ \
#def Поглощающие (существенные) эргодические классы в диаграмме порядка\ #v(0.1cm)
Поглощающие эргодические классы --- классы из которых нельзя выйти \ \
#def Поглощающее состояние\ #v(0.1cm)
Если поглощающий класс состоит из одного состояния, то это состояние называется поглощающим
],[\ \ \
#align(center)[#image("7.png", width: 100%)]])\



*Эргодическая Марковская цепь*\
НОД длинн всех циклов --- $d$
+ $d > 1$ Марковская цель периодическая

+ $d = 1$ Марковская цель апериодческая
\ \
#th (о поглощении)\
_Любая цепь поглотится_ --- "рано или поздно цепь придёт в поглощающее состояние"
\ \
#th (Эргодическая теорема или теорема о забывании) \ 
Если Марковская цепь не периодическая, существует предельное распределение (эргодическое), не зависящее от начального состояния 

\ \
*Поглощающие Марковские цепи*\ #v(0.2cm)
_Жизнь Поглощающей Марковской цепи состоит из 2 этапов: до поглощения и после_
+ Все поглощающие эргодические классы состоят из 1 состояния

+ $forall$ состояния $exists$ путь до поглощающего состояния
\ \

$limits(underbrace(1 dots m))_("непогл"),space limits(underbrace(m+1 dots n))_("погл")$
+ почему обязательно произойдёт поглощение?

+ $a_j, space j = m+1 dots n$ --- вероятность поглощения в $j$

+ $g$ --- время до поглощения
\ \
#ex()\
Задача о пьянице (доказательство неизбежности поглощения)
#align(center)[#image("8.png", width: 50%)]

#table(columns: (1cm, 3cm), [#align(center)[Q]], [#align(center)[R]], [#v(0.6cm) #align(center)[O]], [$ display(mat(augment: #(vline: ()), delim: "|",
1, 0, 0, 0;
0, 1, 0, 0;
dots, dots, dots, dots;
0, 0, 0, 1)) $])


$Q_(m times n) quad R_(m times (n - m))$\ #v(0.2cm)//ты чё делаешь // пытаюсь угадать что будет крестик
$z = max$ длина кратчайшего пути до поглощаюшего состояния\ \
$c^((z)) = c^((0)) dot P^Z$\ \
$limits(sum)_(i = 1)^(m) c_i^((z)) <= S < 1$\ \
$display(c_i^((0)) = cases(c_i^((z)) \/ space S\, quad &i<= m, 0\, quad &"иначе"))$\ \
$t -> infinity$\ \
$limits(lim)_(t -> infinity)limits(sum)_(i = 1)^m c^((t))_i -> 0$
\ \ \
$c_(1 dots m) ^ ((0))$ \ \
$c ^ ((0)) Q$\ \
После t шагов $c ^ ((0)) Q^t$\ \
$display(P("поглотиться в состоянии" j) = limits(sum)_(t = 0)^infinity "поглотиться в стотоянии" j "после" t "шагов" = )$\ \ $display(limits(sum)_(t=0)^infinity limits(sum)_(i=1)^n P("поглотиться в " j "после " t | "перед этим в " i) P("через" t "шагов в" i) =)$\ \
$display(limits(sum)_(t=0)^infinity limits(sum)_(i=1)^n  r_( i j)(c^((0))Q^t)_i = limits(sum)_(i = 1)^m r_(i j) (c^((0)) dot (limits(sum)_(t = 0)^(infinity)Q^t))_i) = (c^((0)) N R)_j, quad quad a = c^((0))N R$ \ \
\ \
#lm если $display(Q^t -> 0\, "то" limits(sum)_(t=0)^infinity Q^t = (I-Q)^(-1)), quad quad I$ --- единичная матрица\ \
#proof\ 
$display(limits(sum)_(t=0)^infinity Q^t (I-Q) = I - Q + Q - Q^2 + Q^2 - Q^3 + dots = I)$
\ \
#def Фундаментальная матрица Марковской цепи\
$N = (I - Q)^(-1)$ 
\ \ 

$g$ --- время до поглощения\ \
Найдём математическое ожидание $g$\ \
$g = limits(sum)_(i=1)^m g_i, quad g_i - "число посещений вершины i"$\ \
$g_i = limits(sum)_(t = 0)^infinity g_(i t)$\ \
$display(g_(i t) = cases(1\, " если" v_t = i, 0\, " иначе"))$\ \
$E_g_(i t) = (c^((0))Q^t)_i$\ \
$E_g_i = limits(sum)_(t=0)^infinity (c^((0))Q^t)_i = c^((0)) N$\ \
$E_g = c^((0)) N limits(1)^(->)$
\ \
#ex()
#align(center)[#image("8.png", width: 50%) Пьяница с 2 вершинами между домом и баром]
\ \
$P = display(mat(augment: #(vline: ()),
0, 0.5, 0.5, 0;
0.5, 0, 0, 0.5;
0, 0, 1, 0;
0, 0, 0, 1)) => Q = display(mat(augment: #(vline: ()),
0, 0.5;
0.5, 0)) => I-Q = display(mat(augment: #(vline: ()),
1, -0.5;
-0.5, 1)) => N= (I - Q)^(-1) =display(mat(4/3, 2/3; 2/3, 4/3)) $\ \
$c^((0)) = (1 space 0 space 0 space 0)$\ \

$a = (1 space 0) display(mat(4/3, 2/3; 2/3, 4/3)) display(mat(1/2, 0; 0, 1/ 2)) = (4/3 space 2/3) display(mat(1/2, 0; 0, 1/2)) = display(mat(2/3, 1/3))$

#quote("С вероятностю две третьих мы закончим свой путь дома, с вероятностью одна третья мы закончим свой путь в баре, не так уж и плохо", attribution: "Станкевич Андрей Сергеевич", block: true)

#pagebreak()

*Лектор:* Дмитрий Юрьевич
\ \
Вопросы, которые мы хотим изучить, изучая марковские цепи:
- С какой вероятностью марковская цепь окажется в том, или ином поглощающем эргодиеском классе

- Какое среднее время жизни марковской цепи перед поглощением
\ 
$P_(i j)$ --- вероятность $i |-> j$\ \
$display(mat(augment: #(vline: ()),
Q, R;
O, I;))$\ \
$P_(i j)^n$ --- вероятность $i |-> j$\ \
$b^0 = limits(underbracket(a^0))_(m) \_\_\_\_$\ \
$a^0Q^n$\ \
$N = (I - Q)^(-1)$\ \
$a^0 N limits(1)^arrow$\ \

*Эргодическая теорема:*\
Не циклический эргодический класс $=> exists b$ --- стац. распределение $i$\ \
$forall b^0 quad b^0 P -> b$\ \
*Следствие:*\
$b = b P$
\ \

_Докажем для регулярных цепей:_
Регулярная цепь: $P_(i j) > 0$\ \
$? exists N: P^N$ --- регулярная
\ \ \
*Доказательство:*\ \
$b = b P$\
$b = (I - P) = 0$\
$b> 0, space limits(sum) b_i = 1$\ \

$b = b A$\
$b P = limits(sum)_(k = 1)^n b_k A_(k i)$\
$A_(k i) = a_i display(mat(a_1, a_2, dots, a_n;a_1, a_2, dots, a_n; a_1, ,dots; a_1, , dots))$\ \
$M_i^t$ --- max в i-том столбце $p^t$\ \
$m_i^t$ --- min в i-том столбце $p^t$

#image("image1.png") //я понятия не имею, что происходит

$M_i^t - m_i^t -> 0$\ \
$p^(t + 1) = p dot p^t: space limits(sum)_(k = 1)^n p_(i k) dot p^t_(k j)  quad &<= quad limits(sum)_(k = 1)^n p_(i k) M_j^t + p_(i d)(m_j^t - M_j^t) quad <= quad M_j^t + delta (m_j^t - M_j^t) \ &>= quad limits(sum)_(k = 1)^n p_(i k) m_j^t + p_(i D)(M_j^t - m_j^t) quad >= quad m_j^t + delta(M_j^t - m_j^t)$\ \ $d$ _--- номер строчки, в которой достигается минимум_\ $D$ --- _номер строчки, в которой достигается максимум_ \ \

$p_(i j)^(t + 1) <= M_j^t + delta(m_j^t - M_j^t)$\
$#h(0.85cm)arrow.double.b$\
$M_j^(t + 1) <= M_j^t + delta(m_j^t - M_j^t)$
#image("image2.png") дописать

#image("image11.png")

\ \
Что мы знаем про цепи?\ \
$a^0 N$ --- ср. пос. сост.\
$a^0 N R$ --- распр. в погл.

\
\
\
$c = limits(sum)_(l = 1)^3 limits(sum)_(r = 1)^3 a_(r l)^(l r)$

= Теория формальных языков

#columns(2)[
_Что такое русский язык?_\
- Алфавит
- Слова, несущие смысл
- Предложения, состоящие из слов
#colbreak()
_Что такое язык С++?_\
- Конструкции $\{ quad ; quad \)$
- Команды ``` for, if, const...```
- Названия переменных `a`
- Ключевые слова ``` int```
]
\ \
*Язык* - набор слов, каждое из которых состоит из символов и может являться частью предложения
\ \
*Формальный язык* - \ \
#def\
+ Алфавит --- конечное конечное множество символов 
  - Обозначение: $Sigma$\

+ Слово --- конечная последовательность символов алфавита\
  - Обозначение: $Sigma^k$ --- все слова длины $k$\

+ Формальный язык --- набор слов, каждое из которых состоит из конечного числа символов
  - Обозначение: $union.big_(k = 0)^(infinity) Sigma^k = Sigma^*$\
//Формализм $L subset Sigma^*$ --- набор слов

\ \
*Описание языка* --- конечная строка\
Число всех языков: $2^(Sigma^*)$ --- несчётное

== Действия над языками
- Теоретико множественные операции: $union space sect space slash space limits(L)^(\_) (U = Sigma^*)$\

  Пусть $alpha, space beta$ --- слова над $Sigma$, тогда конкатенация слов $alpha beta = gamma in Sigma^*$\
  Если $alpha in Sigma^K, space beta in Sigma^n space => gamma in Sigma^(k + n)$\ 
  $(alpha beta) gamma = alpha (beta gamma)$\
  $alpha beta != beta gamma$\
  $epsilon$ --- нейтральное слово: $epsilon alpha = alpha epsilon = alpha$

- Конкатенация языков\
  $A, B$ --- формальные языки\
  $A B = {alpha beta | alpha in A , beta in B}$\
  $gamma in A B$\ 
  $gamma = alpha beta, alpha in A , beta in B$\
  \
  $abs(A), space abs(B)$\
  $abs(A B) <= abs(A) dot abs(B)$\
  _Конкатенация различных слов может дава одинаковый результат_\
  *Пример:*\
  $A = {0, 00}$\
  $B = {0, 00}$\
  $A B = {00, 000, 0000}$\
- $A^*$ --- замыкание Клини
  $A^*= limits(union.big)_(k=0)^infinity A^k$\
  $A A A = A^3$\
  $alpha in A^*$ --- $alpha$ можно разложить на $k$ подстрок, каждая из которых принадлежит $A$ 
  \
  $Sigma = {'0', '1', '\_'}$\
  $00\_#h(0.05cm)\_1$ --- $in Sigma^5$\
  $A^0 = {epsilon}$\
  $A^0 dot A = A$

#columns(2)[
*Регулярные операции*

- $A union B$\

- $A B$\

- $A^*$
#colbreak()
$exists$ базовый набор языков. С помощью регулярных операций над ними можно получать новые языки, которые называются *регулярными*
]
\
Базовый язык --- $c_i in Sigma$\
$"Reg"_0 = {emptyset, {epsilon}, {c_1}, {c_2}, dots}$\
$"Reg"_(k+1) = "Reg"_k union {A B | A, B in "Reg"_k} union {A union B | A, B in "Reg"_k} union { A^* | A in "Reg"_k}$\
$"Reg" = limits(union.big)_(k = 0)^(infinity) "Reg"_k$\
\ \
*Пример:*\
$Sigma = {0, 1}$\
$"Reg"_0 = {emptyset, {epsilon}, {0}, {1}}$\ \
$"Reg"_1 = {emptyset, {epsilon}, {0}, {1}, {epsilon, 0}, {epsilon, 1}, {0, 1}, {0, 0}, {01}, {11}, {10}, $\  
#h(1.5cm) ${epsilon, 0, 00, 000, dots}$ --- на этом моменте (замыкание 0) язык уже становится бесконечным \ 
#h(1.5cm) ${epsilon, 1, 11, 111, dots}$
#h(1.4cm) $}, $\
$"Reg"_2 = {dots, {0, 01, 011, dots, \ 1, 11, dots}, dots}$\ \

*Регулярные выражения (академические)*\
$"Reg"_0$\
$emptyset -> emptyset$\
${epsilon} -> epsilon$\
${c_i} -> c_i$\ \

$L$\
$L = limits(A)_alpha limits(B)_beta$\
$L -> alpha beta$\
#line()
$L = limits(A)_alpha union limits(B)_beta$\
$L -> alpha | beta$\ \

$L = A^*$\
$L -> alpha^*$\
$alpha^* space space space alpha beta space alpha | beta$\
макс ср мин\ \

*Пример:*\
$(0 |^2 11^1)^*^3 in "Reg"_3$\
$0 -> {0}$\
$1 -> {1}$\
$11 -> {1}{1} = {11}$\
$0 | 11 -> {0} union {11} = {0, 11}$\
$(0 | 11)^* -> {0, 11}^*$

Программистам удобнее пользоваться расширенными регулярными выражениями\
*Например:*\
$A^k = underbrace(A A dots A, k)$\
$A^+ = A A^*$
\ \ \ 

Иерархия формальных языков _(каждая следующая ступень полностью включает в себя предыдущую)_:\
- Конечные --- самые простые для работы: их легко можно перебирать, переворачивать многое другое\
- Регулярные \
- Контекстно свободные --- пример: ПСП\
- Вычислимые\
- Перечислимые\
\
$L$ --- вычислимый язык $=> exists p: w in L -> p(w) = 1, space w in.not L -> p(w) = 0$

\ \
*Генерация ПСП*\
$epsilon$ --- ПСП\
$A$ --- ПСП $=> (A)$ --- ПСП\
$A, B$ --- ПСП $=> A B$ --- ПСП
\ \
*Проверка ПСП:*\
_Проверка баланса скобок_
- ```cpp b[0] >= 0```
- ```cpp b[2n -1] = 0``` 
\ \

*Пример построения регулярного выражения, для получения строки*\
$Sigma = {0, 1} quad$ чётное число \'1\'. #v(0.2cm)

$0000 underbracket(10001000) underbracket(10001000)$\ #v(0.2cm)
$0^*(10^*10^*)^*$

== Детерминированные конечные автоматы:
*Определение:*\
ДКА --- набор из пяти элементов: $angle.l Sigma, space Q, space s in Q, space T subset Q, space delta: Q times Sigma -> Q angle.r$\
$Sigma$ --- алфавит\
$Q$ --- множество состояний\
$s$ --- начальное состояние\
$T$ --- множество допускающих (терминальных) состояний\
$delta$ --- функция переходов
\ \
*Процесс допуска слова автоматом*\
Изначально автомат находится в состоянии $s$\
Автомат считывает символы слова по очереди\
При считывании символа $p_i$ автомат переходит в состояние $delta(q, p_i)$, где $q$ --- текущее состояние автомата\
Процесс продолжается, пока слово не кончится
\ \
Автомат *допускает* слово, если после окончания _процесса допуска_ автомат окажется в конечном состоянии
\

#pagebreak()

*Лектор:* Андрей Сергеевич Станкевич
// hello there
//hi

=== Напоминание:
#let Reg=math.op("Reg")
*Регулярные языки:*\
Регулярный язык в 0 поколении $"Reg"_0 = {space emptyset, {epsilon}, {c_i}space}$\ #v(0.2cm)
$"Reg"_i={A|A=B union C, A=B C, A=B^*, B,C in "Reg"_(i-1)}$\ #v(0.2cm)
$"Reg" = union.big_(i = 0)^infinity "Reg"_i$\
\
$limits(|)_("min") quad limits(*)_("max")$\
\
$a|b c\* quad quad a|(b(c\*))$\
\
*Конечные автоматы*
#align(center)[#image("d2.png", width: 30%) визуальное представление конечного автомата]
#v(0.2cm)
Состояния и переходы между ними

Терминальные состояния обозначаются кружком в центре ноды.\
\
Описание текущей конфигурации автомата состоит из состояния и оставшейся (нескушанной) строки\
$dp(p, alpha) tack dp(q, beta)$

$alpha=c beta$

$q=delta(p,c)$
\ \
ДКА --- набор из пяти элементов: $angle.l Sigma, space Q, space s in Q, space T subset Q, space delta: Q times Sigma -> Q angle.r$\
$Sigma$ --- алфавит\
$Q$ --- множество состояний\
$s$ --- начальное состояние\
$T$ --- множество допускающих (терминальных) состояний\
$delta$ --- функция переходов

== Недетерминированные конечные автоматы
Может существовать несколько переходов по одному символу из одной вершины

#align(center)[#image("d1.png", width: 50%) автомат, допускающий слова, заканчивающиеся на "0101"]
\
Недетерминированные вычисления: _исключительно математическая концепция_\
Имеется желаемый результат _(например допуск конечным автоматом)_, и вычисление считается успешным, если существует способ достичь результата.
\ \
*Недетерминированный вычислитель допускает, если существует последовательность недетерминированных выборов которая приводит к допуску*
\ \
*Недетерминированный вычислитель не допускает, если любая последовательность недетерминированных выборов приводит к недопуску*
\ \
*Пример недетерминированных вычислений:*

Игрок Мерлин хочет получить допуск

Игрок Артур хочет узнать правду (допускается объект или нет)
\ \
_На приведённом выше автомате:_\
010101 оба получают true\
01010  Артур получает true
// ни*я не понял, но очень интересно
\ \
*Функция переходов недетерминированного конечного автомата*\
$delta: Q times Sigma -> PP(Q)$\
$PP(A)=2^A$\
\
_На приведённом выше автомате:_\ #v(0.2cm)
$display(cases(
  delta(0,0)={0,1},
  delta(4,0)=emptyset,
  delta(1,1)={2},
))$
#v(0.2cm)
$dp(p,alpha) tack dp(q,beta) \ alpha=c beta, q in delta(p,c)$\
$A$ допускает $x$, если\
$dp(s,x) tack.long^* dp(t,epsilon)$

$t in T$

*Пример:*\
// what the fuck is this
$bold(dp(0, 010101) tack.long dp(0, 10101)  tack.long  dp(0, 0101))  tack.long dp(0, 101) tack.long dp(0, 01)  tack.long  dp(0,1)  tack.long  dp(0, epsilon)$\
#h(2cm)$#rotate(45deg)[$tack.long$]$#h(4.3cm)$bold(#rotate(30deg)[$tack.long$] dp(1, 101) tack.long dp(2, 01))$#h(0.2cm)$#rotate(30deg)[$tack.long$] dp(1, 1) tack.long dp(2, epsilon)$\
#h(2.3cm)$dp(1,10101) tack.long dp(2,0101) tack.long dp(3,101) tack.long dp(4,01) #h(0.8cm)bold(#rotate(35deg)[$tack.long$] dp(3, 1) tack.long dp(4, epsilon))$\ \
$dp(0, 010101) attach(tack.long, tr: *) dp(0, epsilon)$\
#h(1.95cm)$attach(tack.long, tr: *) dp(3, epsilon)$\
#h(1.95cm)$attach(tack.long, tr: *) dp(4, epsilon)$

Но конечный автомат простое устройство. Для проверки на его допуск можно воспользоваться следующим способом
#align(center)[#image("d4.png", width: 50%)]

Такую табличку можно получить динамикой:\ \

#columns(2)[
```py reach[i][u] #можно ли оказаться в u, сделав i переходов

#Просчёт динамики
reach[0][s]=true
for i in range(n):
  for u in Q:
    if reach[i][u]:
      for v in delta(u,x[i]):
        reach[i+1][v]=true

#Проверка на допуск
for t in T:
  if reach[n][t]:
    return True
return False
```
#colbreak()
Асимтотика проверки на допуск:\ // одна с в асимптотике
- Недетерминированный автомат $O(q^2 dot n)$\
- Детерминированный автомат $O(n)$\
]
#th $forall$ НКА $exists$ эквив. ДКА.
#v(0.2cm)
$Sigma, Q, s in Q, T subset Q, delta$
#v(0.2cm)
$Sigma, 2^Q,{s}, T'={A subset Q: A sect T != emptyset}, delta'$
#v(0.2cm)
$delta'(A,c)={v : exists u in A, v in delta(u,c)}$

#v(0.2cm)
Такой процесс называется детерминацией

Пример

#align(center)[#image("d5.png", width: 60%)]
#align(center)[#image("d6.png", width: 60%)]

$display(cases(
  0 | 1 -> 1,
  0 | 0 -> 01,
  01 | 0 -> 01,
  01 | 1 -> 02,
  02 | 1 -> 0,
  02 | 0 -> 013,
  013 | 0 -> 01,
  013 | 1 -> 1,
  024 | 0 -> 013,
  024 | 1 -> 0
))$

== $epsilon$-НКА

Разрешим автомату осуществлять переход из одного ребра в другое, не сжирая символ
#align(center)[#image("d7.png", width: 50%)]

$delta: Q times (Sigma union {epsilon}) -> PP(Q)$

$dp(p,alpha) tack dp(q,beta)$

$alpha=beta, q in delta(p,epsilon)$

$alpha=c beta, q in delta(p,c)$
\ \
Для такого автомата наш динамический алгоритм перестаёт работать :(
\ \
#th $forall $ $epsilon$-НКА $exists$ эквив НКА
+ #image("d8.png", width: 50%)
  Транзитивное замыкание\ //добавить транзитивные $epsilon$ переходы.\
  Допуск не выполняет 2 $epsilon$-перехода подряд. $O(n^3)$
+ #image("d9.png", width: 50%)
  Если $epsilon$-переход ведёт в терминальное состояние,\ сделать состояние начала перехода терминальным\
  $p | epsilon -> t in T => p in T$ $O(n^2)$
+ #image("d10.png", width: 50%)\
  Транзитивное замыкание $epsilon$+$c$ перехода в $c$ переход\
  $p | epsilon -> q, q | c -> r => p | c -> r$ $O(n^3  sigma)$
+ #image("d11.png", width: 50%)
  убрать все $epsilon$-переходы. $O(n^2)$


== Теорема Клини
Рег. выр $equiv$ ДКА.

_Регулярный язык можно задать тогда и только тогда, когда существует ДКА для допуска слов в нём_\
$"Reg" = "Aut"$
\ \ 
#proof
- $Reg subset "Aut"$\
$forall i space Reg_i subset "Aut"$\
_Для удобства, все автоматы имеют одну точку входа и одну точку выхода._\
Индукция:\
База - $Reg_0 subset "Aut"$
#image("d12.png", width: 25%)

// запиши базу
Индукционный переход:\
#image("d13.png", width: 50%)

Автомат для $A union B$: запараллелить автоматы $epsilon$-переходами

Автомат для $A B$: поставить автоматы последовательно и соединить $epsilon$-переходом

Автомат для $A^*$: зациклить вход и выход $epsilon$-переходами.
\ \
- $"Aut" subset Reg$
Построим регулярное выражение для ДКА\
$q$ состояний\
$q^3$ регулярных выражений.

$xi_(i j k) display(cases(delim: "|",i=1..q,j=1..q,k=0..q))$\

$L(xi_(i j k)) = {x | dp(i, x) tack.long^*  dp(k,epsilon), "промежуточные состояния имебт номер" <= k}$\

#columns(2)[
$k=0: display(cases( xi_(i j 0)=epsilon | c | ... &"if" i | c -> i,
  xi_(i j 0)=c|... &"if" i | c -> j))$
#v(0.2cm)
$k>0: display(cases(
  xi_(i j k)=xi_(i j k-1) | xi_(i k k-1) xi^*_(k k k-1) xi_(k j k-1)
))$
#colbreak()
#image("d14.png", width: 40%)
]

$phi=xi_(s,t_1,q) | xi_(s t_2,q) | ...$
#v(1cm)
$display(cases(
  xi_(1 1 0)=epsilon | 1,
  xi_(1 2 0)=0,
  xi_(2 1 0)=0,
  xi_(2,2,0)=epsilon|1,
  xi_(1 1 1)=epsilon|1|(epsilon|1)(epsilon|1)^*(epsilon|1)=1^*,
  xi_(1 2 1)=0|(epsilon|1)(epsilon|1)^*(0)=1^* 0,
  ...
))=(1^* 0 1^* 0 1^*)^*$

//я залью это на гх под маркой "raw"?
// можно использовать https://typst.app/universe/package/finite  подключил
//надо научиться пользоваться. я умею. 
//имба
#pagebreak()

== Регулярные языки
=== Минимизация ДКА

$L={"строки из 0, 1: " \#0=\#1 mod 2}$\ #v(0.2cm)


#align(center)[*Примеры автоматов для такого языка:*]
#columns(2)[
  #align(center)[
#automaton((
  q1: (q2: 1, q3: 0),
  q2: (q1: 1, q4: 0),
  q4: (q2: 0, q3: 1),
  q3: (q1: 0, q4: 1),
), final: ("q1","q4"), labels: (q1: $0$, q2: $1$, q3: $1$, q4: $0$),layout: finite.layout.snake.with(columns: 2, spacing: 1), style: (transition: (curve: 0.2)))]
#colbreak()
#v(0.4cm)
  #align(center)[
#automaton((
  st: (ed: (0,1)),
  ed: (st: (0,1))
), final: ("st"), labels: (st: $= mod 2$, ed: $!=$))
]]
#align(center)[_Автоматы эквивалентны друг другу, но правый в 2 раза меньше левого_]
\
#def эквивалентные состояния\
$A$ - ДКА\
$u, v in Q$\
$u tilde v, "если" forall s in Sigma^*:  [delta (u, s) in T] = [delta (v,s) in T]$
\ \
#columns(2)[
*!* $tilde$ --- _отношение эквивалентности:_\
+ Рефлексивность: $u tilde u$ --- очевидно
+ Симметричность: $u tilde v <=> v tilde u$ --- очевидно.
+ Транзитивность: $u tilde v and v tilde w => u tilde w$\
 *Доказательство:* (от противного)\ 
 Из $u$ приходим в терминальное состояние. Из $w$ приходим в не терминальное состояние.
  Тогда, посмотрим на $v$. если $v$ приходит в терминальное состояние то $v tilde.not w$, в другом случае $u tilde.not v$
#colbreak()
*Занимательный факт:*\
Для минимизации ДКА необходимо выделить все эквивалентные состояния и объединить их между собой
]
\
Так как $tilde$ --- отношение эквивалентности, мы можем выделять классы эквивалентности -- вершины минимизированного автомата

Если до перестройки автомата между вершинами классов $u$ и $v$ было проведено ребро $s_1$, то оно должно быть проведено между классами $K(u)$ и $K(v)$
\ \
*Утверждение:*\
$u tilde v, c in Sigma => delta(u, c) tilde d(v, c)$
\ \
#proof
Если $delta(u,c)$ и $delta(v,c)$ отличаются строкой $s$, то $u$ и $v$ отличаются строкой $c s$
\ \
*Алгоритм выделения классов эквивалентности* _($O(n^2 dot abs(Sigma))$)_\
- $u tilde.not v and delta(a,c)=u and delta(b,c)=v => a tilde.not b$
//- $u in T, v in.not T => u tilde.not v$
//+ $forall x in T, space forall y in.not T: $ "скажем", что $(x, y)$ не эквивалентны

$
"used"[n][n]\
"used"[u][v]="True" => u tilde.not v
$

```py
for x in T:
  for y !in T:
    used[x][y] = used[y][x] = True
    queue.add((x, y))
    queue.add((y, x))
while queue:
  u,v=queue.next()
  for c in Sigma:
    for x in Nodes.where(x=> u in x.at(c)):
      for y in Nodes.where(y=> v in y.at(c)):
        if not used[x][y]:
          used[x][y]=True
          queue.add((x,y))
```

// maybe use https://typst.app/universe/package/algorithmic

- $"used"[x][y]="False" => x tilde y$

- Строим новый автомат $A$

#th
$A$ - ДКА, $forall u, v in Q, u tilde.not v$, все вершины $A$ достижимы из $S A$. тогда
+ $forall B$ - ДКА $L(A)=L(B), abs(Q_B)>=L(Q_A)$

+ $forall B$ - ДКА $L(A)=L(B), abs(Q_B)=L(Q_A) => A$ и $B$ изоморфны 
\
#proof
+
  - Запишем ватомат $A$ и автомат $B$ как один большой автомат _с двумя стартовыми вершинами_
  - $S_A tilde S_B$
  - $forall v in Q_A exists u in Q_B: v tilde u$
  - Предположим, что $Q_B < Q_A => exists x, y in Q_A: x tilde z, y tilde z => x tilde y$ --- противоречие
+ $abs(Q_A) = abs(Q_B)$ --- биекция\
  $Pi: Q_A -> Q_B$\
  $x in Pi(x) => delta_A (x, c) tilde delta_B (Pi(X), c)$
  

//2. Найдём нашим алгоритмом классы эквивалентности

//3. *Утверждение* (неверное) каждой вершине автомата $A$ единственная соответствует эквивалентная вершина $B$  

// #automaton((
//   sA: (A1),
//   A1: (),
//   A2: ()
// ))
//хуй знает как это записать
// ты про что конкретно? я не понял, что на картинке
//картинку

== Нерегулярные языки
*Классический пример нерегулярного языка:*

$L$ - язык ПСП. ${\"\",\"()\", \"(())\", \"()()\",...}$
\ \
Для того, чтобы проверить, является ли строка ПСП, необходимо пройтись по строке, поддерживая баланс скобочек. Если во время прохода баланс окажется отрицательным или будет не равен 0 после прохода по сторке, строка не ПСП
\ \
Чтобы создать автомат для проверки ПСП, необходимо создать по состоянию на каждое значение баланса скобок, что не получится сделать за конечное число вершин
\ \

#proof #v(0.2cm)
$L in.not Reg$, от противного:\
$make exists L in Reg => exists A$ - ДКА, $space L(A)$=ПСП, $space abs(Q_A)=n$

Построим последоватьльность \ $s_1=\"(\", quad s_2=\"((\", quad ..., quad s_(n+1) = s_n + "("$\ #v(0.2cm)
Тогда, по принципу Дирихле, будет хотя бы одно совпадение состояний.
\ \
*Лемма о разрастании (boost) (о накачке (pumping)):*\ #v(0.2cm)

$L in Reg => exists n>0:
forall w in L, abs(w)>=n, exists x,y,z: w=x y z, abs(x y)<=n, y!=epsilon => forall k>=0, x y^k z in L$
\ \
*Отрицание леммы о разрастании:*\ #v(0.2cm)

$forall n>0 exists w in L, abs(w)>=n: forall x,y,z: w=x y z, abs(x y)<=n, y!=epsilon exists k>=0: x y^k z in.not L => L in.not Reg$
\ \

*Пример:*

$L={0^n 1^n} = {epsilon, 01, 0011, dots}$


$! L in Reg$
+ $n>0$
+ выбирем $w=0^n 1^n$
+ $x=0^a, y=0^b, z=0^(n-a-b)1^n$
+ $k=0 => x k^k z=0^a 0^(n-a-b) 1^(n)=0^(n-b) 1^n$

$L in Reg => exists A$ - ДКА, $n=abs(Q_A)$


#automaton((
  s: (v: "x"),
  v: (v: "y", end: "z"),
  end: ()
))


#pagebreak()
// хз о чем речь

== Система линейных уравнений в регулярных выражениях

$L=alpha L+beta$, где $L - $ язык, $alpha, beta$ - регулярные выражения, $+ equiv |$
\ \
*Пример:*
$L="a" L + "b" ="a"^* "b"$

Докажем единственность решения:\
Существует минимальный контрпример:\
$x in L, x in.not a^* b$\
$cases(delim: "|", reverse: #true,
  x=b,
  x eq.not epsilon,
  x eq.not a,
) => abs(x)>=2$

$x=a y, y in L, y in.not a^* b => x$ - не минимальный контрпример. $=> exists.not x: x in L, x in.not a^* b$
\ \
*Пример:*
#automaton((
  x: (x: 1, y: 0),
  y: (x: 1, z: 0),
  z: (z: (0,1))
))

// $(0|1)^* 00 (0|1)^*$

$L_i$ - язык слов, которые допускаются из состояния $i$\
$cases(
  x=1x + 0y,
  y=1x + 0z,
  z=0z + 1z + epsilon,
) => cases(
  z=(0|1)^*,
  y=1x+0 (0|1)^*,
  x=1x+0(1x+0 (0|1)^*)=(1|01)x+00(0|1)^*
) => x=(1|01)^* 00 (0|1)^*$

#note $x_1=alpha_1 x_1+alpha_2 x_2 + alpha_3 x_3 + ... + beta= alpha_1 x_1 + beta'$

*Правила:*
$x=a x+b = a^* b$\
$x$ - терминальный - $x=a x+b+epsilon$

$L=alpha L + beta$\
$alpha^* beta subset L$
- $x in beta => x in L$
- $x in alpha, y in beta, => x y in L <=> alpha beta in L$
- $x in alpha^k, y in beta, => x y in L <=> alpha^k beta in L$

+ $epsilon in.not alpha => alpha^* beta$ - ед. решение.
  $x$ - мин. решение $x in L, x in.not alpha^* beta$
  - $x in beta - x in alpha^* beta$
  - $x in alpha L - x=y z, y in alpha, z in L$\
    $abs(y)>=1 => abs(z)<abs(x), z in.not alpha^* beta$ ($w in alpha^* beta => alpha w in alpha^* beta$)
+ $epsilon in alpha => forall N in Sigma^*: alpha^* beta union N - $ решение
  Ответ - $alpha^* beta union A$, ($A$ - язык)\
  *Пример:*
  $3 divides.not "#1"$
  #automaton((
    x: (x: 0, y: 1),
    y: (y: 0, z: 1),
    z: (z: 0, x: 1)
  ))
  $cases(
    x=0x+1y,
    y=epsilon+0y+1z,
    z=epsilon+0z+1x,
  ) => cases(
    z=0^* (1x+epsilon),
    y=0^* (10^* (1x+epsilon)+epsilon),
    x=0x+10^* (10^* (1x+epsilon)+epsilon)=(0|10^*10^*1)x+(10^*(10^*+epsilon))
  ) => x=(0|10^*10^*1)^* 10^*(10^*+epsilon)$

== Операции над регулярными языками
$A,B in Reg$
- $A union B, A B, A^*$
- $A sect B = Q=Q_A times Q_B, delta(angle.l a,b angle.r, c)=angle.l delta_A (a,c), delta_B (b,c) angle.r, S=angle.l S_A, S_B angle.r, T={angle.l a, b angle.r | a in T_A, b in T_B}$
  Произведение автоматов
- $A xor B={w | w in A xor w in B }$
  *Следствие:*\
  $A_1, ..., A_n in Reg, f: BB^n -> BB, L={w|f(w in A_1, ..., w in A_n)=1}, L in Reg$
- $overline(A)=Sigma^*\\ A: T'=overline(T)$

- $phi in "Hom", phi(alpha beta)=phi(alpha)phi(beta)$\
  $phi_0: Sigma -> Sigma^*$\
  $phi: Sigma^* -> Sigma^* quad phi(c_1 c_2 ... c_n)=phi(c_1)phi(c_2)...phi(c_n)$\
  $A in Reg => phi(A) in Reg, phi^(-1)(A) in Reg$\
  $phi(A) in.not Reg => A in.not Reg$\
  *Пример: *\
  $a^n b^n in.not Reg, phi_0: cases(a |-> a,b |-> b, c |-> b) => a^n b^n c^(n-k) in.not Reg$\
  *Пример: *\
  $a^n b^n in.not Reg, phi^(-1)_0: cases(a |-> a a,b |-> b) => a^(2n) b^n in.not Reg$\
  $phi$ может переводить ДКА в $epsilon$-НКА

#pagebreak()
= Формальные языки


#def #underline[формальная грамматика]\ #v(0.1cm)

Описание формального языка с помощью четырёх элементов:\ #v(0.1cm)
$Gamma = angle.l Sigma, space N, space S in N, space P subset ((Sigma union N)^* N (Sigma union N)^*) times (Sigma union N)^* angle.r$\ #v(0.1cm)
$Sigma$ --- алфавит (множество терминалов)\
$N$ --- множество нетерминалов\
$S$ --- начальный символ\
$P$ --- правила продукции $alpha -> beta$

//\ #v(0.2cm)
//$Sigma quad Sigma^* quad L subset Sigma^*$

//Регулярное выражение = ДКА _(= НКА)_
//\
== Контекстно-свободные грамматики


#align(center)[_(КС-грамматики, CFG)_]

*Пример:*\ #v(0.1cm)

Алфавит --- $Sigma = {\"(\",\")\"}$\ #v(0.2cm)
Нетерминалы (переменные) --- $N = \{underbracket(S,"П.С.П")}$\ #v(0.2cm)

Правила продукции --- $P=display(cases(
  S -> epsilon,
  S -> (S),
  S -> S S,
))$\ #v(0.2cm)

Стартовый нетерминал --- $S$ - старт\ #v(0.2cm)

//$S -$ стартовый нетерминал.

$display(cases(
  E -> T,
  E -> E+T,
  //(E -> T+E),
  T -> F,
  F -> T*F,
  F -> n,
  F -> (E),
))$

$Sigma={n,(,),+,*}$

$N={E,T,F}$

$E -$ старт.

#import "@preview/syntree:0.2.0": tree

Разбор выражений\
+ $()(())$\
  Пример линейного вывода
  Вывод --- $S => S S => (S)(S) => ()((S)) => ()(()) $\ \

+ $()()()$\
  Неоднозначность записи вывода\
  $S => S S => S S S$\
+ Дерево разбора\
  #tree(
    "S",
    tree("S","(",tree("S",$epsilon$),")"),
    tree("S","(",tree("S","(",tree("S",$epsilon$),")"),")")
  )

*Определение* контекстно-свободная грамматика\ #v(0.2cm)
#let xx=math.times
#let la=math.angle.l
#let ra=math.angle.r
$P = la underbracket(Sigma, "Терминалы"), underbracket(N, "нетерминалы"), underbracket(S, "старт") in N, underbracket(P, "правила") subset N xx (N union Sigma)^* ra$\ #v(0.2cm)

$(N union Sigma)^*$ --- сентенциальные формы (предложения)\ #v(0.2cm)



//обнови страничку

//*Пример разбора выражения:*\ #v(0.2cm)
//"( ) ( ( ) )"\ #v(0.2cm)
//$S => S S => (S) S => ( space ) S => ( space )(S) => (space)(space (S)space ) => (space )(space (space )space)$ --- "линейный" вывод


(Контекстно-зависимые грамматики --- $alpha A beta -> alpha gamma beta$: $alpha, beta$ --- контекст)\ #v(0.2cm)

*Стандартные обозначения*\
$A,B,C,X,Y,Z$ - нетерминалы\
$a,b,c,d,f$ - символы\
$s,t,x,y,z$ - строки из символов, $Sigma^*$\
$i,j,k,m,n$ - числа\
$alpha, beta, xi, omega$ - строки из терминалов и нетерминалов $(Sigma union N)^*$\

$(N union Sigma)^* =>$

$alpha => beta <=> alpha=xi A eta, A -> gamma in P, beta=xi gamma eta$\
$alpha =>^k beta, =>^* = union_(k=0)^oo =>^k$

Левосторонний вывод: $=>_l <=> xi in Sigma^*$\
Правосторонний вывод: $=>_r <=> eta in Sigma^*$\
\
*Определение:* однозначная граммитика\ #v(0.2cm)
$forall "строка" <=1 $ дерева разбора
\

#let cases(..args)={
  math.display(math.cases(..args))
}
Однозначная граммитика для правильных скобочных последовательностей:\
$cases(
  S -> epsilon,
  S -> S (S),
)$\
\

*Определение:* язык контекстно-свободной грамматики:\ #v(0.2cm)
$L(Gamma) = {x | S attach(=>, tr: *) x}$\
$A$ --- к.с. язык,  если $exists$ к.с. гр. $Gamma$\
$A = L(Gamma)$

Язык $0^a 1^b 2^b 3^a union 0^a 1^a 2^b 3^b$ - существенно неоднозначный (не имеет однозначной грамматики)

#let CF=math.op("CF")
=== $Reg "vs" CF$?

#def Праволинейная граммитика
$cases(
  A -> a B,
  A -> a,
  A -> epsilon
)$

Пример
$cases(
  S -> 0S,
  S -> 1A,
  S -> epsilon,
  A -> 1A,
  A -> epsilon
) = 0^* 1^*$

#tree(
  "S",
  "0",
  tree("S","0",tree("S","0",tree("A","1",tree("A","1","1"))))
)
\ \
#th праволинейные грамматики задают регулярные языки\
/*
#automaton(
  (
    x: (y: ""),
    y: (z: ""),
    z: (x: "", z: ""),
  ),
  
)
*/
$N = Q$\
$S$ --- стартовое состояние
#columns(2)[
#automaton(
  (
    A: (B: "c"),
    B: ()
  ),
  final: ()
)
$A -> c B$
#colbreak()
#automaton(
  (
    A: (),
  ),
  final: ("A")
)
$A -> epsilon$

]
$la s, alpha beta ra |-^* la p, beta ra <=> S attach(=>, tr: *) alpha P$\
$Q = N union {t}$
\ \
*Следствие:* $Reg subset.neq CF$
\ \
Регулярные языки - языки третьего класса по Хомскому\
КСГ - языки второго класса по Хомскому\
\
*Нормальная форма хомского*
$cases(
  A -> B C,
  A -> a,
  S -> epsilon" для языков принимающих " epsilon". если есть, то" S "не встречается в правых частях грамматик"
)$

Любую грамматику можно перевести в нормальную форму хомского.
\ \
Бесполезные символы:\
$S -> a$\
$S -> a A$\
$A -> a A$\
$A -> a B$\
$B -> b A$\
$C -> b$
\ \
Непорождающий символ
$A arrow.double.not^* x, x in Sigma^*$
\ \
Недостижимый символ
$S arrow.double.not^* alpha C beta$
\ \
*Избавление от бесполезных символов*
+ Удалить непорождающие
+ Удалить недостижимые
