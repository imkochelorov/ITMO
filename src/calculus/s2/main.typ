#import "..\..\..\template.typ": *

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
  title: "Математический анализ\nII семестр",
  authors: (
    "_scarleteagle",
    "imkochelorov",
    "AberKadaber"
  ),
  date: "зима/весна 2024",
  subtitle: "Лектор: Кохась Константин Петрович"
)



#let def = strong("Определение:")
#let dp(first, second)=$angle.l #first, #second angle.r$
#let sum=$limits(sum)$
#let lim=$limits(lim)$
#let proof=par(strong("Доказательство:"))
#let th=strong("Теорема:")
#let lm=strong("Лемма:")
#let defnot = strong("Обозначение:")
#let int=$display(limits(integral))$
#let emptyset=$diameter$
#let qed=$space qed$
#let note=strong("Замечание:")
#let cor(..number)= {
  if number.pos().len() == 0 {
    strong("Следствие:")
  }
  else {
    strong("Следствие " + str(number.pos().at(0)) + ":")
  }
}
#let limsup = $overline(lim)$
#let liminf = $underline(lim)$
#let smile = emoji.face.smile.slight
#let frown = emoji.face.frown.slight
#let wink = emoji.face.wink
#let pole(a, b) = $lr(|, size: #200%)_#pad(bottom: -13pt)[$#a$]^#pad(top: -13pt)[$#b$]$

#outline(title: "Оглавление", indent: auto)

#pagebreak()

= Неопределённый интеграл

#def _первообразная_\ $F, f: dp(a, b) -> RR$\
$F$ --- _первообразная_ $f$, если $forall x in dp(a, b) quad F'(x)=f(x)$
\ \
#th $f$ --- непр на $dp(a, b) => exists$ пер-я $f$
\
#proof
Чуть позже.
\ \
#th $F$ --- пер-я $f$ на $dp(a, b) =>$
- $forall c in RR quad F+c$ --- пер-я $f$
- $G$ --- пер-я $f => exists c in RR: G-F=c$
#proof
- $(F+c)' = f$
- $(G-F)' = f - f = 0 => G-F = "const"$
\ 
#def _неопределённый интеграл_ \
_Неопределённый интеграл_ функции $f$ на $dp(a, b)$ --- мн-во всех первообразных $={F+c, c in RR, f "- пер-я"}$
\  \
#defnot $int f, int f(x) dif x$

\
*Примеры*:
- $int 1/(x+a^2) dif x = ln abs(x+a^2) + C$ 

- $int 1/x dif x = ln abs(x) + C$
- $int 1/(x^2+1) dif x = arctan x$
- $int 1/(x^2-1) dif x = 1/2 ln((x-1)/(x+1))$ #emoji.face.frown.slight
- $int 1/(sqrt(1-x^2) dif x) = arcsin x$
- $int 1/(sqrt(1+x^2)) = ln abs(x + sqrt(x^2 + 1))$

\
//#th _о свойствах неопределённого интеграла_\
== Свойства
Пусть $f, g$ имеют пер-е на $dp(a, b) =>$
- $int f+g=int f + int g$

- $forall alpha in RR quad int alpha f = alpha int f$
- Замена переменной: $phi: dp(c, d) -> dp(a, b)$ дифф $=> int f(phi(t)) phi' dif t = (int f(x) dif x bar_(x=phi(t))) = int f(phi(t)) dif phi(t)$
  - Можо читать справа налево: $F(phi(t)) = h(t) => x=phi(t) => t = phi^(-1) (x)$
- $forall alpha, beta in RR, alpha != 0 quad int f(alpha x + beta) dif x = 1/alpha F(alpha x + beta)$
#proof
- Тривиально.

- Тривиально.
- $F$ --- пер-я $f => int f(phi(t)) phi'(t)=F(phi(t))$
- Частный случай предыдущего пункта.
\
Пример: $int (dif x)/(sqrt(x^2 + 16)) = 1/4 (dif x)/(sqrt(x^2/16+1))=1/4 int (dif x)/(sqrt((x/4)^2 + 1)) = 1/(1 slash 4) 1/4 ln abs(x/4 +sqrt(x^2/16 + 1))$

#th $f, g$ дифф на $dp(a, b), f'g$ имеет пер-ю на $dp(a, b)=> g'f$ имеет пер-ю на $dp(a, b)$ и $int f g' = f g - int f'g$
\ \
#proof
$(f g - int f'g)' = f'g + f g' - f'g = f g'$
\ \
*Пример:*

\
$int sqrt(1 - x^2) dif x =^(???)_(quad quad space x=sin t\ [-1, 1] <-> [-pi/2, pi/2]) int sqrt(1-sin^2 t) cos t dif t = int cos^2 t dif t = int 1/2 + (cos 2t)/2 dif t = 1/2 t + 1/4 sin 2t=$$=1/2 arcsin x + 1/4 sin(2 arcsin x)=1/2 arcsin x + 1/2 x sqrt(1-x^2)$
\
\
#quote("Если у вас что-то такое в уме - изгоните немедленно!", attribution: "КПК", block: true)

= Определённый интеграл
#def _плоская фигура_\  
_Плоская фигура_ --- огр. подмн-во $RR^2$
\ \
#def _множество плоских фигур_\
$cal(E)$ = мн-во плоских фигур\ \
#def _площадь_\
_Площадь_ --- функция $sigma: cal(E) -> [0, +infinity)$:
- Аддитивность: $A_1, A_2 in cal(E) quad A= A_1 union.sq A_2 quad sigma A = sigma A_1 + sigma A_2$

- Нормировка: $sigma(dp(a, b) times dp(c, d)) = (b - a)(d-c)$ _(площадь прямоугольника)_
\
*Новости* (хорошая и странная): \ Площади существуют, площадей много.
\ \
#note
- $sigma$ монотонна: $A, B in cal(E), A subset B => sigma A <= sigma B$

- $sigma ("верт. отрезка")=0$
\
#def _ослабленная площадь_\
_Ослабленная площадь_ $sigma: cal(E)-> [0, +infinity)$:
- $sigma$ монотонна

- Нормировка
- Ослабленная аддитивность: $E in cal(E) quad E=E_1 union E_2$ (разбиение верт. отрезком) $=> sigma E=sigma E_1 + sigma E_2$

\
*Новости* (хорошие и странные):\ Ослабленные площади существуют, ослабленных площадей много
\ \
*Пример:*\ $sigma_1 E = inf {sum sigma(P_k): E subset limits(union.big)_"кон." P_k}$\ \
$sigma_2 E = inf {sum sigma(P_k): E subset limits(union.big)_"счётн." P_k}$
\ \
$sigma_1([0, 1]^2 sect (QQ times QQ))=1$\
$sigma_2([0, 1]^2 sect (QQ times QQ))=sigma_2(limits(union.big)_(k=1)^(+infinity) {P(x_k)}), P(x_k) = [x^k_1 - epsilon/sqrt(2^k), x^k_1 + epsilon/sqrt(2^k)] times [x^k_2 - epsilon/sqrt(2^k), x^k_2 + epsilon/sqrt(2^k)]$\
$=> sigma_2([0, 1]^2 sect (QQ times QQ))=0$

$sigma_1$ и $sigma_2$ различаются только в патологических случаях. Для подграфиков непрерывных ф-ций они дают одно и то же.
\ \
#def _положительная срезка_\
Положительная срезка $f$: $f^+=max(f, 0)$. Отрицательная срезка $f$: $f^-=max(-f, 0)$.
\ \
#note \ 
$f=f^+-f^-$\ $abs(f)=f^++f^-$
\ \
#def _подграфик функции_\ $f>=0$ на $[a, b], E subset [a, b]$. _Подграфик ф-ции $f$ на мн-ве_ $E$ $"ПГ"(f, E)=$$={(x, y) in RR^2: x in E, 0 <= y <= f(x)}$
\ \
#def _определённый интеграл_\ Определённый интеграл функции $f$ на $[a, b]$ $int_a^b f = sigma("ПГ"(f^+, [a, b])) - sigma("ПГ"(f^-, [a, b]))$
\ \

== Свойства
#note\ Далее считаем $f in C([a, b])$ \
\
#note 
- $f >= 0 => int_a^b f >= 0$

- $f equiv c quad int_a^b f = c (b - a)$ #emoji.face.smile.slight 
- $int_a^b (-f) = -int_a^b f$
- при $a = b quad int_a^b = 0$ 
\
*Свойство 1:* _аддитивность по промежутку_\ \ $forall c in [a, b] int _a^b = int_a^c f + int _c^b f$\ \
*Свойство 2.* _монотонность_\ \
$f, g in C([a, b]), f <= g => int_a^b f <= int_a^b g$
\ \
#proof
$f <= g => f^+ <= g^+, f^- >= g^+$\
\
*Следствие:* \
\
$"ПГ"(f^+, [a, b]) < "ПГ"(g^+[a, b]) => &sigma("ПГ"(f^+)) &<= sigma("ПГ"(g^+))\ &sigma("ПГ"(f^-)) &<= sigma("ПГ"(g^-))$\
\ \
*Свойство 3:* $f in C[a, b] =>$\ \
1.$space min f dot (b - a) <= int_a^b f(x) dif x <= max f (b-a) <= max f dot (b - a)$\ \
2.$space abs(int_a^b f) <= int_a^b abs(f)$\  \
3.$space exists c in [a, b]: int_a^b f(x) dif x = f(c) (b-a)$ \ \  
#proof
2.\
$-abs(f(x))<=f(x) <= abs(f(x))$\ \
$-int_a^b abs(f) <= int_a^b f <= int_a^b abs(f)$\ \
3.\
Для $a = b$ утверждение тривиально\ \
Если $a != b$: $min f <= 1/(b-a) int_a^b f <= max f$, далее по теореме о промежуточном значении  $1/(b-a) int_b^a f$ --- значение $f$ в некоторой точке
\ \
#def _интеграл с переменным верхним пределом_ \ $f in C([a, b]), Phi: [a, b] -> RR, Phi(x) = int_a^x f$ --- _интеграл с переменным верхним пределом_\ \

#th (_Барроу_) \ $Phi$ --- интеграл с пер. верх. пределом, дифф на $[a, b]$, $forall x quad Phi'(x)=f(x)$ \ \

#proof \
$int_a^y f - int_a^x f = (int_a^x f + int_x^y f) - int_a^x f$\ \
$y > x: lim_(y->x+0) (Phi(y)-Phi(x))/(y-x)=lim_(y->x+0) 1/(y-x) int_x^y f = lim_(y->x+0) f(c)=f(x)$\ \
$x > y$: аналогично\ \

*Пример:*\ \
$(int_(x^2)^(x^3) e^(-t^2) dif t)'_x = (int_a^x^3 - int_a^x^2)'_x = (Phi(x^3)-Phi(x^2))' = e^(-x^6) dot 3x^2 - e^(-x^4) dot 2x$\ \
$dif/(dif x)(int_(int_(x^2)^(tg x) e^t^2 dif t)^(int_(sin x)^(ln x) sqrt(s^4 + 2 s) dif s) sin n^2 dif n)$ #emoji.face.wink
\ \
#th (_формула Ньютона-Лейбница_)\ \ $f in C([a, b]), F$ --- пер-я $f => int_a^b f(x) dif x = F(b)-F(a)$\ \ \ \
#proof \
$Phi = F+C$\ \
$int_a^b f = Phi(b) - Phi(a) = (F(b)+C) - (F(a)+C)=F(b)-F(a)$

Согласование: $a > b => int_a^b f = -int_b^a f$
#quote("До Ньютона не было законов Ньютона", attribution: "КПК", block: true)
= Верхний предел последовательности

#def _частичный предел последовательности_\ $(x_n) subset RR$. Если $exists a, exists n_k: x_n_k -> a$, то $a$ --- _частичный предел последовательности_ $(x_n)$\ \

*Пример:*
- $x_n = (-1)^n$\
  $n_k: 2, 4, 6, dots => x_n_k->1$\
  $n_k = 1, 3, 5, dots => x_n_k -> -1$
\
#def _верхний предел / нижний предел_ \ $(x_n) subset RR, quad y_n = sup(x_n, x_(n+1), dots), quad z_n = inf(x_n, x_(n+1), dots) => z_n <= x_n <= y_n, quad y_(n+1) >= y_n,quad$$z_(n+1)<=z_n$ \ \
_Верхний предел_ $overline(lim_(n->+infinity)) x_n= limits(op("lim sup"))_(n -> +inf) x_n =lim_(n->+infinity) y_n$\ \ _Нижний предел_ $underline(lim_(n->+infinity)) x_n= limits(op("lim inf"))_(n->+inf) x_n = lim_(n->+infinity) z_n$
\ \
#th
- $underline(lim) x_n <= overline(lim) x_n$

- $forall n quad x_n <= tilde(x)_n => overline(lim) x_n <= overline(lim) tilde(x)_n, underline(lim) x_n <= underline(lim) tilde(x)_n$
- $lambda >= 0 quad overline(lim) lambda x_n = lambda overline(lim) x_n, underline(lim) lambda x_n = lambda underline(lim) x_n$ ($lambda = 0 => underline(lim) lambda x_n=overline(lim) lambda x_n=0$)
- $overline(lim) (-x_n) = -(underline(lim) x_n), underline(lim) (-x_n) = -(overline(lim) x_n)$
- $overline(lim) (x_n + tilde(x)_n) <= overline(lim) x_n + overline(lim) tilde(x)_n$\
  $underline(lim) (x_n + tilde(x)_n) >= underline(lim) x_n + underline(lim) tilde(x)_n$

\ \
// следующая лекция

#pagebreak()
$(x_n)$\
$y_n = sup(x_n, x_(n+1), dots)$\
$z_n = inf(x_n, x_(n+1), dots)$\
$z_n <= x_n <= y_n$\ \
$overline(lim) x_n eq.def lim y_n in overline(RR)$\
$underline(lim) x_n = lim z_n$\
$overline(lim) (x_n + tilde(x)_n) <= overline(lim) x_n + overline(lim) tilde(x)_n$\
$sup(x_n + tilde(x)_n, x_n + tilde(x)_(n+1), dots) <= underbrace(sup(x_n, x_(n+1), dots), y_n) + underbrace(sup(tilde(x)_n, tilde(x)_(n+1), dots), tilde(y)_n)$

\ 
// пункт 6
- $t_n -> l in RR => limsup (x_n + t_n) = limsup x_n + l$
#proof
По опр. предела $forall epsilon > 0 quad exists N_0: forall k > N_0 quad l-epsilon < t_k < l + epsilon$\ 
$x_k + l - epsilon < x_k + t_k < x_k + l + epsilon$\
$~~>_(sup "по" k >= N > N_0) quad y_N + l - epsilon <= limits(sup)_(k >=N) (x_k+t_k) <= y_N + l + epsilon$\
$=> limsup x_n + l - epsilon <= limsup (x_n + t_n) <= limsup x_n + l + epsilon$\
$epsilon -> 0 => limsup (x_n + t_n) = limsup x_n + l$\
\
// пункт 7
- $t_n -> l > 0, l in RR quad limsup (x_n t_n) = limsup x_n dot l$
Без доказательства\ \  // тудааааа
#th (_Техническое описание верхнего предела_)\
$(x_n)$ --- вещ. последовательность $=>$
- $limsup x_n = +infinity <=> x_n$ не огр сверху

- $limsup x_n = -infinity <=> x_n -> -infinity$
- $limsup x_n = l in RR <=>$
  - $forall epsilon > 0 quad exists N: forall n > N quad x_n < l + epsilon$
  - $forall epsilon > 0 quad exists (n_i): forall i quad x_n_i > l - epsilon$ (т.е. существует бесконечно много n)
#proof
- Очевидно:\ $=>: y_n -> +infinity quad forall k quad exists y_n > k+1$ т.е. $sup(x_n,x_(n+1),dots)>k+1$ (т.е. $forall k quad exists x_i > k$) \
  $arrow.l.double: x_n$ не огр сверху $=> y_n equiv +infinity$
- Очевидно: $x_n <= y_n$\
  $=>: y_n -> -infinity => x_n -> -infinity$\
  $arrow.l.double: forall Epsilon < 0 quad exists N: forall k > N quad x_k < Epsilon => y_(N+1) <= Epsilon$
- $=>:$
  - $y_n -> l, x_n <= y_n => forall epsilon > 0 quad exists N: forall n > N quad x_n <= y_n < l-epsilon$
  - $y_n$ убывает, $y_n -> l => l <= y_n quad forall n$\
    $forall epsilon > 0 quad forall n quad y_n = sup(x_n, x_(n+1), dots)$\
    $exists x_k, k >= n: l - epsilon < x_k$\
    Берём $n=1$, находим $k=k_1$\
    Берём $n>k_1$, находим $k=k_2$\
    Берём $n>k_2$, находим $k=k_3$\
    И т.д.
- $arrow.l.double:$\
  - $space forall epsilon > 0 quad exists N: forall n > N quad x_n < l + epsilon " т.е." x_(n+1) < l + epsilon, x_(n+2) < l+epsilon, dots$
    $space => space y_n <= l + epsilon space$по определeнию.\
  - $forall epsilon > 0 quad forall n quad y_n >= l - epsilon$\
    т.к. $y_n=sup(x_n, x_(n+1), dots), exists$ б.м. $x_i > l-epsilon$\
    $=> forall n quad y_n >= l$
  $=> y_n -> l$
#th\
$(x_n)$ --- вещ. последовательность $=> exists lim x_n in overline(RR) <=> limsup x_n = liminf x_n$ и если оба утв. верны, все 3 предела совпадают
#proof
- $=>: lim x_n = plus.minus infinity => $ очев.: $limsup x_n = +infinity$ ($x_n$ не огр сверху $=> limsup x_n = +infinity$)\
  $liminf x_n = +infinity$ по тех. описанию, п.2\ \
  Если $lim x_n = -infinity$ #emoji.face.smile.slight Аналогично\ \
  Пусть $lim x_n = l in RR$, выполняется тех. описание $=> limsup x_n=l$\
  Аналогично $liminf x_n = l$
- $arrow.l.double: z_n <= x_n <= y_n, z_n -> l, y_n -> l => x_n -> l$
#th (_о характеризации верхнего предела как частичного_)\
$(x_n)$ --- вещ. последовательность $=>$
- $forall l in overline(RR)$ --- частичный предел $x_n: liminf x_n <= l <= limsup x_n$
- $exists n_k: x_n_k ->_(k->infinity) limsup x_n, exists m_j: x_m_j ->_(j->+infinity) liminf x_n$
#proof
- $n_k: x_n_k -> l quad z_n_k <= x_n_k <= y_n_k$\
  $z_n_k -> liminf x_n, x_n_k -> l, y_n_k -> limsup x_n => liminf x_n <= l <= limsup x_n$
- Про верхний: $limsup x_n = plus.minus infinity$ очев\
  $limsup x_n = l in RR => exists n_k: l-1/k < x_n_k < l+1/k$ (из тех. описания)\
  $l-1/k -> l, l+1/k -> l => x_n_k -> l$
*Пример:*\
$x_n = sin n$\
$limsup sin n = 1$\
$forall k quad sup(sin k, sin(k+1), dots)=1$\
Будем блуждать по окружности с шагом $n_i$.\
$n_0 = 1$\
В какой то момент (на 7-ом шаге) наш шаг пересечет точку 0 и разобьется на 2 дуги - большую и меньшую. Теперь будем делать шаги по 6:\
$n_1 = 6$\
И теперь на каждом шаге мы будем отодвигаться от 0 на величину меньшей из тех двух дуг, которые мы описали раньше:\
$n_1, 2n_1, 3n_1, dots$\
В какой то момент и она пересечет точку 0, повторим с ней тот же процесс:\
$n_2 = n_1 k$ или $n_1 (k+1)$ (соответственно более короткой половинке дуги, которую делит 0)\
$n_2, 2n_2, dots$\
$n_3 = n_2 l$ или $n_2 (l+1)$ (аналогично)\
и т.д.\
Длина шага: $1, <1/2, <1/4, <1/8, dots$\
$1/2^k < epsilon$\
Существует б.много $sin x_k > 1-epsilon, sin x_k <= 1 forall k => limsup sin n = 1$\

// тут должна быть 4 лекция
#pagebreak()
= Некоторые приложения определнного интеграла
#lm\
$f, g in C[a, b] quad alpha, beta in RR$\
$int_a^b alpha f + beta g = alpha int_a^b f + beta int_a^b g$\
#proof
$F, G$ --- первоообр. $f$ и $g$\
$alpha F + beta G$ --- первообр. $alpha f + beta g$\
Обе части $= alpha F + beta G pole(a, b)$

*Пример:*\
$f in C[a, b] quad I_f = 1/(b-a) int_a^b f$ --- ср. арифм. $f$ на $[a, b]$\
$f, g in C[a, b]$ монотонно возр.\
Тогда $I_f dot I_g <= I_(f g)$\
(_неравенство Чебышёва_)\
$int_a^b f dot int_a^b g <= (b - a) int_a^b f g$\
#proof
монот $=> forall x, y quad (f(x) - f(y)) (g(x) - g(y)) >= 0$\
$f(x) g(x) - f(y) g(y) - f(x) g(y) + f(y) g(y) >= 0 arrow.wave int_a^b dots dif y, 1/(b-a)$\
$f(x)g(x) - I_f g(x) - f(x) I_g + I_(f g) >= 0 arrow.wave int_a^b dots dif x, 1/(b - a)$\
$I_(f g) - I_f dot I_g - I_g dot I_f + I_(f g) >= 0$ --- удовенное неравенство которое мы хотели #emoji.face.smile.slight #emoji.face.smile.slight
\ \
#th _формула интегрирования по частям_
$f, g in C^1[a, b]$, Тогда $int_a^b f g' pole(a, b) - int_a^b f' g$
#proof
$int_a^b f g' + f' g = f g pole(a, b)$
\ \
*Пример:*\ // спасибо
// и еще, как сделать скобку [ типа системы уравнений чтобы записать по частям интегрирование // йоу спасибо огромное, думаю дальше справлюсь
// $display(cases(delim: "[", 1&\,quad "cond1", -1 dot 10^1000&\,quad "cond2"))$\
$H_n = 1/n! display(int)_(-pi/2)^(pi/2) (pi^2/4 - t^2)^n cos(t) dif t$\
$H_n = display(cases(delim: "[", f = (pi^2/4-t^2)^n&\,quad f' = -2 n t(pi^2/4-t^2)^(n-1), g'=cos(t)&\,quad g = sin(t))) display(cases(delim:"[", reverse: #true, &\ &\ &\ &\ &\ &\ )) = display((pi^2/4 - t^2)^n sin(t)/n! pole(-pi/2, pi/2) + (2n)/n! int^(pi/2)_(pi/2)) t(pi^2/4 - t^2)^(n-1) = display(cases(delim:"[", f = t(pi^2/4-t^2)^(n-1) =>f' = (pi^2/4-t^2)^(n-1) + (-2)(n-1)(t^2-pi^2/4)(pi^2/4-t^2)^(n-2)-pi^2/4(n-1)(pi^2/4-t^2)^(n-2) &\ g' = sin(t) => g = -cos(t))) display(cases(delim:"[", reverse: #true, &\ &\ &\ &\ &\ &\ )) =$
\ \
$= 2/(n-1)! (-t(pi^2/4-t^2)^(n-1) pole(-pi/2, pi/2) + int_(-pi/2)^(pi/2)(pi^2/4-t^2)^(n-1) cos(t) dif t + 2 (n-1) int_(-pi/2)^(pi/2) (pi^2/4-t^2)^(n-1) cos(t) dif t - pi^2/2(n-1) int_(-pi/2)^(pi/2)(dots)^(n-2) cos(t ) dif t) = 2H_(n-1) (4n-4)H_(n-1) -pi^2 H_(n-2) = (4n-2)H_(n-1) - pi^2 H_(n-2)$\ \

Изначально мы считаем что $n in NN$. При $n>2$ все хорошо, везде интегрировать можно, деления на ноль при сокращении не происходило. При n = 2 тоже все хорошо --- в этом можно убедиться при помощи метода присатльного взгляда.\

Остается найти $H_1$ и $H_0$: Очевидно, что $H_0 = 2$.\ \
$H_1 = 2int_(-pi/2)^(pi/2) t sin(t) dif t = display(cases(delim:"[", f = t => f' = 1 &\ g' = sin(t) => g = -cos(t)) cases(delim:"[", reverse: #true, &\ &\ &\ &\ &\ )) = 2t cos(t) pole(-pi/2, pi/2) + 2 int_(-pi/2)^(pi/2) cos(t) dif t = 0 + 4 = 4$

\
#th _Иррациональность числа $pi$_\
Число $pi$ --- иррационально.\ \
#proof 
Проверим, что $pi^2$ --- иррационально.\
Для этого исползьуем то что мы только что сделали:\ $H_n = (4n-2)H_(n-1) - pi^2 H_(n-2) = (4n-2)((4n-6)H_(n-2) - pi^2 H_(n-3)) - pi^2 H_(n-2) = dots$\ 
Продолжая так действовать мы получим, что:
$H_n = dots H_0 + dots H_1 = F_n (pi^2)$ --- многочлен от $pi^2$ с целыми коэффициентами, степени не выше $n$\
Теперь предположим противное: пусть $pi^2$ --- рациональное, т.е. $pi^2 = l/m$\
$H_n = 1/n! display(int)_(-pi/2)^(pi/2) (pi^2/4 - t^2)^n cos(t) dif t = F(l/m) =>^(dot m^n)  0< (m^n)/n! display(int)_(-pi/2)^(pi/2) (pi^2/4 - t^2)^n cos(t) dif t = F_n (l/m)dot m^n in ZZ => (m^n)/n! display(int)_(-pi/2)^(pi/2) (pi^2/4 - t^2)^n cos(t) dif t >= 1$ --- это не верно, т.к. если помахать руками то $n!$ растет слишком бытро.\ 
Формальное доказательство:
$(m^n)/n! display(int)_(-pi/2)^(pi/2) (pi^2/4 - t^2)^n cos(t) dif t <= m^n / n! dot 10^n dot pi$ --- здесь мы воспользовались тем что $abs(int_a^b f) <= max(abs(f))(b-a) space$ и взяли 10 для большого запаса.\
Теперь видно, что при $n-> infinity$ выражение стремиться к 0, поэтому оно не может быть $>= 1$ для любого $n$.\ \
 
#th _о замене переменной в определенном интеграле_\
$f in C( dp(a, b)),quad  phi: dp(alpha, beta) -> dp(a, b), space phi in C^1(dp(alpha, beta)), quad [p, q] in dp(a, b)$\ 
Тогда $int_p^q f(phi(t))phi'(t)dif t = int_(phi(p))^(phi(q)) f(x) dif x$\
\
#proof
$F$ --- первообразная $f$, тогда $F(phi(t))$ --- первообразная $F(phi(t))phi'(t)$
#quote("Очень сложное слово первообразная - очень тяжело его на 4-ой паре писать", attribution: "КПК", block: true)
Л.Ч. $= F(phi(t)) pole(t=p, t=q) = F(x) pole(x = phi(p), x = phi(q)) =$ П.Ч.\ \ \

*Очень странная формула:*\
Во первых нам никто не говорил, что $phi([p, q]) = [phi(p), space phi(q)]$, она может выходить за пределы этого отрезка.\
Пример: $int_0^((5pi)/6) f(sin(t))cos(t) dif t = int_0^(1/2)f(x) dif x$ --- здесь пока $t$ гуляет от 0 до $phi/2, space sin(t)$ пробегает от 0 до 1, а потом от 1 до $1/2$.\ \
Проверим что мы делали все верно:
$int_0^((5pi)/6) f(sin(t))cos(t) dif t = int_0^(pi/6) + int_(pi/6)^(pi/2) + int_(pi/2)^((5pi)/6) = int_0^(1/2) + int_(1/2)^1 + int_1^(1/2) = int_0^(1/2)f(x) dif x$\ \

Продолжение теоремы: хотим еще уметь делать преобразования в обратную сторону:\
$int_0^1 sqrt(1-x^2) dif x = [x = sin(t)] = int_(2pi)^(pi/2)sqrt(1-sin^2(t))cos(t)dif t$ \ \
#th _Формула Тейлора с остатком в интегральной форме_\
$dp(a, b) in R, quad f in C^(n+1)(dp(a, b)), quad x, x_0 in dp(a, b)$ \ \
Тогда $f(x) = limits(sum)_(k = 0)^n f^((k))(x_0)/k!(x-x_0)^k + 1/n! int_(x_0)^x (x-t)^n f^((n+1))(t) dif t$ \

#proof Индукция по $n$ и интегрирование по частям. \
База: $n = 0$ \ 
$f(x) = f(x_0) + int_(x_0)^x f'(t)dif t$ --- это формула Ньютона-Лейбница.\ \
Переход:\
$1/n! int_(x_0)^x (x -t)^n f^((n+1))(t)dif t = display(cases(delim: "[", f = f^((n+1))(t) => f' = f^((n+1))(t) &\ g' = (x-t)^n =>g = - (x-t)^(n+1)/(n+1)) cases(delim: "[", reverse:#true, &\ &\ &\ &\ &\ &\ )) =$ \ \
$= -1/(n+1)! f^((n+1))(x-t)^(n+1) pole(t=x_0, t=x) - int_(x_0)^x (x-t)^(n+1) f^((n+2))(t) dif t$ --- победа, получили ровно то что хотели --- в первом слагаемом после подстановке получиться следующий элемент суммы, интеграл ровно тот котоырй нужен.\ \


#quote("Чтобы обеспечить психическое здоровье на практике, неужели если рассмотреть простецкую фукнцию - целую часть x, неужели ее нельзя проинтегрировать",  attribution: "КПК", block: false)
\ \
#def _Кусочно-непрерывная фукнкция_\
$f$ --- кусочно-непрерывная фунция на $[a, b] <=>$ существует конечное число точек $x_1, x_2, dots , x_n$, таких что: $f -$ непрерывна на $[a, x_1), (x_1, x_2), dots , (x_n, b]$, а точки $x_1, dots, x_n$ --- разрывы первого рода.\ \
Замечание --- такая фукнция $f$ --- ограничена.
\ \
#def _Почти первообразная_\
$F$ --- почти первообразная некоторой фукнции $f$ на $[a, b]$, если выполняется $F'(x) = f(x)$ --- при всех $x$ кроме конечного числа точек и $F$ --- непрерывна на $[a, b]$. \  \
*Пример:*\
$F(x) = abs(x), space F -$ почти первообразная $"sign"(x)$


#pagebreak()
*Напоминание:*\
$f: [a, b] -> RR$ --- кусочно непрерывная \
$x_0 = a < x_1 , x_2 < dots < x_(n - 1) < b = x_n$\
--- $forall k quad f$ --- непрерывная на $(x_(k - 1), x_k)$ \ 
$exists $ конечный $lim_(x->x_k- 0) f, space lim_(x->x_(k-1)+0) f$\
Тогда можно считать, что  $ forall k quad f in C([x_(k-1), x_k])$, $quad int_a^b f = sum_(k=1)^n int_(x_(k-1))^(x_k) f$\
#def почти первообразная \ $F$ --- _почти первообразная_ $f(x)$, если \ $F in C[a, b]$, дифф. всюду кроме кон. числа точек, $F'(x) = f(x) space forall x$, где $F$ дифф.
\ \
#th\
$f$ --- кус. непр., $F$ --- почти первообр., $F$ --- дифференцируема всюду кроме $x_i$ из определения кусочно непрерывной \
Тогда:  $int_a^b = F(b) - F(a)$\ 
#proof
На $(x_(k-1), x_k) space F$ --- первообразная $f$\
Но мы знаем что у $f$ есть полноценная первообразная на  $[x_(k-1), x_k]$ и при этом эта первообразная с точностью до константы совпадает с $F$ на $(x_(k-1), x_k)$. #v(0.2cm)
Обозначим эту первообразную $tilde(F): tilde(F) in C([x_(k-1), x_k]) space "и"space  tilde(F) = F$ на $(x_(k-1), x_(k))$#v(0.2cm)
Мы получили: непрерывную функцию $F$, а также фунцию $tilde(F)$, которая совпадает с нашей на каждом интервале. Получается что эти функции совпадают на все отрезке.#v(0.2cm)

$int_a^b f = sum_(k=1)^n space int_(x_(k-1))^(x_k) f = sum_(k=1)^n F(x_k) - F(x_(k - 1)) = F(x_n) - F(x_0) = F(b) - F(a)$\ #v(0.1cm)
#image("1.png", width: 30%)
\ \
*Пример:* неравенство Чебышева\
$I_f dot I_g <= I_(f g) quad$ ($f, g$ --- возр), $space I_f = 1/(b-a) int_a^b f$
\ \
*Утверждение (неравенство Чебышева для сумм):*\
$a_1 <= a_2 <= dots <= a_n$, $ space b_1 <= b_2 <= dots <= b_n$\ #v(0.2cm)
Тогда $(1/n sum_(k=1)^n a_k) (1/n sum_(k=1)^n b_k) <= 1/n (sum_(k=1)^n a_k b_k)$\ #v(0.2cm)
#proof
#image("2.png", width: 30%)
$f(x) = a_(ceil(x)), quad x in (0, n]$#v(0.2cm)
Тогда $int_0^n f$ --- с одной стороны площадь под графиком, но она как раз и есть одна из сумм неравенства Чебышева#v(0.2cm)
На $(k-1, k) quad F(x) = x dot a_k, space x in [k-1, space k]$ --- возникает проблема: в точках $a_i$ происходит разрыв первого рода, а мы хотим чтобы $F$ была непрерывна. Тогда добавим сдвиги на константу:\
$ F(x) = cases(delim: "[", a_1 x && x in [0, 1], a_2 x + (a_1-a_2) &quad& x in [1, 2], a_3 x + (a_1+a_2-2a_3) && x in [2, 3], dots dots) $ 
Когда мы рассмотрим такие фукнци для $f, g, f g$ мы получим ровно интегральное неравенство Чебышева.

= Правило Лопиталя
_by_ Иоганн Бернулли
== Лемма об ускоренной сходимости
$f, g: D subset RR -> RR, space a$ --- предельная точка $D, space a in overline(RR)$#v(0.1cm)
Пусть $exists space dot(U) (a) quad f != 0, g != 0$#v(0.1cm)
$lim_(x->a) f(x) = 0, lim_(x->a) g(x) = 0$#v(0.3cm)
Тогда $forall (x_k), space display(cases(x_k -> a, space x_k in D, space  x_k != a)) quad exists (y_k), space  display(cases(y_k -> a, space y_k in D, space y_k != a)):quad  lim f(y_k)/g(y_k) = 0, space lim g(y_k)/g(x_k) = 0$#v(0.2cm)
#proof
В качестве $y_k$ будем брать некоторые элементы $(x_n)$ так, чтобы:#v(0.2cm)
$display(cases(abs(f(y_k)/g(x_k)) < 1/k arrow.l.double abs(f(y_k)) < 1/k abs(g(x_k)), space abs(g(y_k)/g(x_k)) < 1/k arrow.l.double abs(g(x_k)) < 1/k abs(g(x_k))))$ --- здесь следование в другую сторону, т.к. например в первой строчке $x_k$ нам дано, поэтому значение $1/k abs(g(x_k))$ нам известно, а т.к. $f$ стремиться к 0 точно найдется такой номер, начиная с которого $f$ меньше чем это известное нам значение. Обозначим это $x_i$ как $y_k$. Аналогично во второй строке\
$$
== Лемма 2
Аналогичное верно для случая
$space lim_(x->a) f = +infinity, space lim_(x->a) g = +infinity$\ #v(0.25cm)
$forall (x_k), dots quad exists (y_k), dots: lim f(y_k)/g(x_k) = 0,space lim g(y_k)/g(x_k) = 0$\ \
== Правило Лопиталя
$f, g: (a, b) -> RR, space a in overline(RR),$#v(0.2cm)
$f, g$ --- дифференцируемы на $(a, b), quad g' != 0$ на $(a, b)$\ #v(0.2cm)
$lim_(x->a + 0)f/g = [0/0, space infinity/infinity]$\ #v(0.2cm)
Пусть $lim_(x->a+0) (f'(x))/(g'(x)) = A in overline(RR)$\ #v(0.2cm)
Тогда $exists lim_(x->a+0) f/g = A$ // дошик среди теорем
\ \
#proof
$g' != 0 => g' $ --- сохраняет знак (т. Дарбу) $=> g$ --- строго монотонно $=>$ в окр. точки $a space g != 0$#v(0.1cm)
По Гейне: $display(cases(x_k-> a, space  x_k != a, space x_k in (a, b))), space $ строим последовательность $y_k$ из леммы\ #v(0.2cm)
Теорема Коши: $display((f(x_k) - f(y_k))/(g(x_k) - g(y_k)) = (f'(xi_k))/(g'(xi_k)))=>  f(x_k) - f(y_k) = display((f'(xi_k))/(g'(xi_k)) (g(x_k) - g(y_k)))=>[
space :g(x_k)]$\ #v(0.25cm)
$=>display(f(x_k)/g(x_k) = limits(f(y_k)/g(x_k))_(arrow.b\ 0)+limits((f'(xi_k))/(g'(x_k)))_(arrow.b\ A) dot (1-limits(g(y_k)/g(x_k))_(arrow.b\ 0)))$\ \
*Пример:*\ #v(0.2cm)
$lim_(x-> +infinity) x/(sqrt(x^2 + 1)) = lim_(x->+infinity) 1/(x/(sqrt(x^2 + 1))) = lim_(x -> + infinity) sqrt(x^2 + 1)/x=$#smile\ #v(0.2cm)
$0 =lim_(x->0) (x^2 sin 1/x)/(sin x) = lim_(x->0) (2limits(x)^(0\ arrow.t) sin 1/x - cos 1/x)/limits(cos x)_(arrow.b\ 1)=$#frown\
$lim_(x->0+) ln(x)/x = lim_(x->+0) (1/x)/1 = lim_(x->+0) 1/x = +infinity$\ \
*Пример:*\ #v(0.2cm)
$int_0^(+infinity)e^(-x^2) dif x = sqrt(pi)/2$ --- интеграл Эйлера-Пуассона\ #v(0.2cm)
$+infinity$ в верхнем пределе означает, что:
$int_0^R e^(-x^2) dif x ->_(R->+infinity) sqrt(pi)/2 space <=>space sqrt(pi)/2 - int_0^R e^(-x^2) ->_(R->+infinity) 0$\ #v(0.2cm)
Теперь мы хотим заменить интеграл на эквивалентную фукнцию, то есть найти $g(R):$#v(0.2cm)
$1 = display(lim_(R->+infinity) (sqrt(pi)/2 - int_0^R e^(-x^2) dif x)/g(R) = [0/0] =^("Лопиталь")lim_(R->+infinity) (-e^(-R^2))/(g'(R))=1)$\ \
I попытка:\
$g(R)=e^(-R^2) => g' = -2R e^(-R^2) => display((-e^(-R^2))/(-2R e^(-R^2)) -> 0)$#v(0.2cm)
II попытка:\
$display(g(R) = (e^(-R^2))/(2R)=> (e^(-R^2))/(e^(-R^2) - underbracket((e^(-R^2))/limits(2R), =o(e^(-R^2)))) ->_(R->+infinity) 1)$#v(0.2cm)
Победа, мы получили: $int_0^R e^(-x^2) dif x = sqrt(pi)/2 - (e^(-R^2))/(2R) + o((e^(-R^2))/R)$

= Приложение определённого интеграла
_Общая схема_ $ space dp(a, space b)$\
$"Segm"(dp(a, space b)) = {[p, q]: [p, q] subset dp(a, b)}$ --- множество всех подотрезков $dp(a, b)$

#align(center)[#image("3.png", width: 20%)_представление $[p, q] in $ Segm$(a, b)$, если $(p, q)$ лежит в заштрихованном треугольнике_] // 
\
== Аддитивная функция промежутка

$Phi: "Segm" dp(a, b) -> RR$#v(0.15cm)
$forall [p, q] in "Segm" dp(a, b) quad forall c in [p, q] quad Phi([p, q]) = Phi([p,c]) + Phi([c, q])$#v(0.15cm)
Это похоже на итнетграл, он тоже аддитивен. Поэтмоу попробуем найти некоторую фукнцию $f:$\ $[p, q] |-> int_p^q f$ // this one

== Плотность аддитивной функции промежутка
$Phi: "Segm" dp(a, b) -> RR, space f: dp(a, b) -> RR$\ #v(0.2cm)
$f$ --- плотность $Phi$, если $forall Delta in "Segm": limits(min)_Delta f dot l_Delta <= Phi(Delta) <= limits(max)_Delta f dot l_Delta$\
$l_Delta$ -- длина отрезка $Delta$.\ \
*Теорема:* (о вычислении а. ф. п. по плотности)\
$f: dp(a, b) -> RR, $ --- непрерывна, $Phi: "Segm" dp(a, b) -> RR$ --- а.ф.п,
$f$ --- плотность $Phi$#v(0.1cm)
Тогда:\
$forall [p, q] in "Segm" quad Phi([p, q]) = int_p^q f(x)d x$

#proof
Не умаляя общности рассмотрим $[a, b]$\ #v(0.2cm)
$F(x) = display(cases(delim: "[", 0\, &quad& x=a, Phi([a, x])\, &&x in (a, b]))$\ #v(0.2cm)
Проверим $F$ --- первообразная $f$:\ #v(0.25cm)
$display((F(x + h) - F(x)) / h = (Phi[a, x+h] - Phi[a, x])/h = underbracket( Phi([x, x+h])/h, in [min_Delta f, max_Delta f]) = f(x + Theta h)), space 0 <= Theta <= 1$\ #v(0.2cm)
(В последенм равенстве мы воспользовались теоремой о промежутоном значении для непрерывной фунции)#v(0.2cm)
$F'_+ = lim_(h->+0) f(x + Theta h) = f(x)$\ #v(0.2cm)
Аналогично $F'_- = f(x)$\ #v(0.2cm)
$int_p^q f = F(q) - F(p) = Phi([p, q])$
\ \
*Пример 1.1:* площадь подграфика\ #v(0.2cm)
$f: dp(a, b) -> RR$, непр., $quad Phi: "Segm" dp(a, b) -> RR:quad Phi([p, q]) = sigma("ПГ"(f, [p, q]))  $\ #v(0.2cm)
Тогда $f$ --- плотность, из монотонности площади\

#image("4.png", width: 25%)
$(q - p)dot min f <= sigma("ПГ"(f, [p, q])) <=  (q - p) dot max f$\ #v(0.2cm)

$Phi([p, q]) = sigma("ПГ"(f, [p, q])) = int_p^q f$\ \

*Пример 1.2:*\ #v(0.2cm)
$display(x^2/a^2 + y^2/b^2 = 1)$\
#align(center)[#image("5.png", width: 25%) _График эллипса_]
\ 
$sigma_"элл" = int_(-a)^a y^+ (x) dif x =display(cases(delim:"[", x=a cos t, y=b sin t)), quad t in [pi, 0] cases(delim:"[", reverse:#true, &\ &\ &\ &\ ) =  -int_pi^0 b sin t dot a sin t dif t=a b int_0^pi sin^2 t dif t = a b pi/2$\ \
#align(center)[#image("6.png", width: 25%) _Геометрический способ поиска площади подграфика_] // из-за свойств симметрии синусоиды площадь подграфика равна половине площади прямоугольника
\
*Пример 2:* площадь криволинейного сектора
$dp(a, b)$\
$Phi: [p, q] |-> sigma("Сектор"([p, q], r(phi)))$ --- аддитивная функция промежутка. Чтобы ее удобно исхать найдем ее плотность:\
Проверим, что $1/2 r^2 (phi)$ --- плотность а.ф.п. $Phi$:#v(0.15cm)
$1/2 (q-p) dot limits(min)_([p, q]) r^2 (phi)  <= Phi [p, q] <= 1/2 (q-p) dot limits(max)_([p, q]) r^2 (phi)$#v(0.2cm)
Криволинейный сектор $([p, q], min r) subset$ Сектор $([p, q], r(phi)) subset$ Криволинейный сектор $([p, q], max r)$#v(0.1cm)
Т.е. это была действительтно плотоность а.ф.п $Phi => $ $Phi([p, q]) = 1/2 int_p^q r^2 (phi) dif phi$\
\
*Пример 1:*
Посчитаем площадь круга\ #v(0.2cm)
$sigma "Круга" = 1/2 int_0^(2pi) R^2 d phi = pi R ^2$ #smile#v(0.2cm)
*Пример 2:* \
$S'=1/2 int_p^q r^2 (phi) d phi =display(cases(delim:"[", phi=arctan y(t)/x(t), r=sqrt(x^2+y^2)) cases(delim:"[", reverse:#true, &\ &\ &\ &\ &\ &\ )) = 1/2 int_(t_p)^(t_q) = (x^2+y^2) dot display(1/(1+(y^2(t))/(x^2(t))) dot (y'x - x'y)/(x^2) dif t)=$\
#align(right)[$= 1/2 int_(t_p)^(t_q) y'(t)x(t)-x'(t)y(t))dif t$]\ \

Подставим в получившуюся формулу уравнение окружности с радиусом $R$:#v(0.2cm)
$display(cases(x=R cos t, y=R sin t)),space t in [0, pi/2] space => space S = R^2/2 int_0^(pi/2) cos^2 t + sin^2 t dif t = (pi R^2)/4$
 \ \
*Пример:* Изометрическое неравенство\
$G subset RR^2 space space G$ --- замкнутая выпуклая фигура. Диаметр $G = sup(rho(A, space B), space A, space B in G) =d<= 1$\
Тогда $sigma(G) <= pi (d/2)^2 quad$ (равенство для круга $r = 1/2$)
\ \
#proof
Введем с.к. так чтобы вся наша фигура лежала выше оси $O_x$ а также введем функцию $f(x)$ описывающую "нижнюю" часть нашей фигуры#v(0.1cm)
$f(x)$ --- вып., $forall x_0$ где $exists f'(x_0) => exists$ касательная\
$G$ замк., вып. $=> r(phi)$ непр.#v(0.2cm)
$sigma = 1/2 int_(-pi/2)^(pi/2) r^2 (phi) dif phi=1/2 int_0^(pi/2) + int_(-pi/2)^0 = 1/2 int_0^(pi/2) r^2 (phi) dif phi + 1/2 int_0^(pi/2) r^2 (phi_"нов"-pi/2) dif phi_"нов"=$\
$=1/2 int_0^(pi/2) r^2 (phi) + r^2 (phi - pi/2) dif phi=1/2 int_0^(pi/2) \"A B\"^2 dif phi<=1/2 int_0^(pi/2) d^2 dif phi = (pi d^2)/4$\ \
#def циклоида --- траектория точки на окружности, катящейся по прямой\
// см лекцию для объяснения этого треша
$S_"черн" + S_"син" = S_"прям" + S_"лепестка"$\
$S = 2 pi r^2 + pi r^2$\
$S=3 pi r^2$\ \
$ cases(x(phi) = r phi - r sin phi, y(phi) = r - r cos phi), phi in [0, 2pi] $\
$S = int_0^(2pi r) y(x) dif x = int_0^(2pi) (r-r cos phi) (r-r cos phi) dif phi=r^2 int_0^(2pi) 1-2 cos phi + cos^2 phi dif phi = 2 pi r^2 + 0+pi r^2$
// вместо изюминки вы прожевали доширак, я не знаю. чушь какая-то

#pagebreak()
/*
#columns(3)[
  50 \
  10\
  40
  #colbreak()
  кр\
  теор.опрос\
  экзaмен
  #colbreak()
  30\
  0\
  30 из 40 = 75%\
  #line()
  60
]
*/

// я час назад в первый раз за сем сел за прогу
// пиздец
// у нас main должен работать за O(log n) или binary search?
// main
// а, то есть нельзя пройтись по всем элементам и перекастовать в int?
// а тут кста хз
// я бы сказал что незя
// но кажется у тех, кто так делал, принимали
// а ты как делал?
// переводил в инт только те элементы, которые бинпоиск смотрит, то есть логарифм
// кринж но окэй
// поч кринж то
// int binarySearch(String[] args)
// да
// вопросы?
// ставишь пред условием $forall i in [0, args.length): args[i] in {`parsable as integers strings`}$
// насколько плохо кастовать x в int O(log n) раз?

== Аналитические функции
$f(x) in C^infinity =>$ для нее можно писать формулу Тейлора:\ #v(0.2cm)
$f(x) = limits(sum)_(k = 0)^(+ infinity) (f^((k)) (x_0))/k!(x - x_0)^k$\ #v(0.2cm)
$e^x = limits(sum)^(+infinity)_(n = 0) x^n/n! $ --- всюду сходится с рядом Тейлора \ #v(0.2cm) 
$ ln(1 + x) = x - x^2/2 + x^3 / 3- dots$ --- сходится с рядом Тейлора в точках из $[-1, 1]$
\
\
*Пример неаналитической функции*\  #v(0.2cm)

$ f(x) = cases( e^(-1/x^2)\, &quad x != 0, 0\, &quad x=0) $
*Утверждение:* $forall n in NN quad exists f^((n)) (0) = 0$\ \
*Доказательство:*\ #v(0.2cm)
1)  $exists f'(0) quad$ если 
$space exists limits(lim)_(x -> x_0 + 0) f'(x) = a$, то $f'_+(x_0) = a$ \
 #v(0.2cm)#h(2.8cm) 
$space exists limits(lim)_(x -> x_0) #h(0.45cm) f'(x) = a$, то $f'#h(0.1cm) (x_0)  = a$
\ #v(0.2cm)
$lim_(x->0) 2/(x^3) e^(-1/x^2) =^"Лопиталь"  lim (2 (1/x^3) e^(-1/x^2))/(3x^2) = lim 2/3 dot (e^(-1/x^2))/x^5 $ --- не повезло #v(0.2cm)
#h(2.35cm)$=display( lim (2/x^3)/e^(1/x^3) = [infinity/infinity]=^"Лопиталь"lim (-6/x^3)/(-1/x^3 dot e^(1/x^3)) = lim_(x->0) (6/x)/(e^(1/x^2)) =^"Лопиталь" lim (-6/x^2)/(-1/x^3 e^(1/x^2)) = lim_(x->0) (6x)/(e^(1/x^2)) = 0)$\
#v(0.2cm)
_Следствие:_ $forall k space limits(lim)_(x->0) e^(-1/x^2)/x^k = 0$\
#v(0.2cm)
Итак, $f'(0) = 0, quad$ то есть $f'(x) = cases(delim: "{", 1/x^3 e^(-1/x^2)\, &quad x != 0, 0 &quad x=0)$\ \
Проверим по индукции по $n$, что 
$forall n space exists P_n (x)$ --- многочлен: $f^((n)) (x) = cases(delim: "[", display(P_n (1/x) e^(-1/x^2))\, &quad display(x != 0), display(0)\, &quad display(x=0))$\ #v(0.2cm)
База: $n= 0, space 1 $ см. раньше //??? // ??? //всм см раньше 1
$ f^((n+1)) = cases(delim: "[", display((P'_n (1/x) (-1/x^2) + P_n (1/x) dot (1/x^3)) e^(-1/x^2))\, &quad x != 0, ?\, &quad x=0) $#v(0.2cm)
$ f^((n+1)) = limits(lim)_(x->0)(f^((n)) (x)) = limits(lim)_(x->0)P_(n+1)(1/x)e^(-1/x^2) = 0 $
\ \

== Продолжение плотности аддитивной фукнции промежутка
$f$ --- плотность аддитивной функции промежутка $Phi$, если:\ #v(0.2cm)
$forall Delta in "Segm" quad limits(min)_Delta f dot |Delta| <= Phi(Delta) <= limits(max)_Delta f dot |Delta| quad$ _(f непрерывна, в ином случае вместо min и max, inf и sup)_ \ \


\
#th *(Напоминание)*
$f$ --- плотность $Phi$ ($f$ --- непр) $=> Phi([p, q]) = int_p^q f$
#v(0.2cm)
#columns()[
#align(center)[#image("7.png", width: 30%) $f = 1/2 r^2(phi)$]  
#colbreak()
Вот здесь нам повезло, что вот эта функция оказалась аддитивной фукнцией промежутка, и это легко доказалось, но на самом деле обычно все не так просто, поэтому нужен более мощный инструмент
]
\
#th (_обобщ. теорема о плотности_)\ #v(0.2cm)
$Phi$ --- а.ф.п: $"Segm"(dp(a, b)) -> RR, f in C[a, b]$\ #v(0.2cm)
Пусть $forall Delta in "Segm"(dp(a, b)) quad exists$ функции  промежуткака $m_Delta, M_Delta:$

+ $m_Delta dot abs(Delta) <= Phi(Delta) <= M_Delta dot abs(Delta)$

+ $forall x in Delta quad m_Delta <= f(x) <= M_Delta$

+ #columns(2)[ $forall$ фикс. $x in dp(a, b) quad M_Delta - m_Delta -->_(abs(Delta) -> 0\ x in Delta) 0$#v(0.2cm)
  т.е. $forall epsilon > 0 quad exists space delta > 0: forall Delta in "Segm"dp(a, b):$ #v(0.2cm)
  $ abs(Delta) < delta, x in Delta quad M_Delta - m_Delta < epsilon$
  #v(0.2cm)
#colbreak()
#align(right)[#image("8.png", width: 80%)]
]
Тогда $f$ --- плотность $Phi$ $("и " forall space  [p, q] subset dp(a, b) quad Phi([p, q]) = int_p^q f)$
\ \
#proof\
Не умаляя общности рассмотрим отрезок $[a, b]$, $quad F(x) = cases(delim: "[", display(0)\, &display(x = 0), display(Phi[a, x])\, quad &display(x > a)), quad "тогда"space  ? F' = f$\ #v(0.2cm)
Фиксируем $x$, Пусть $h >0 $ \ #v(0.2cm) $(F(x + h) - F(x))/h = Phi[x, space x+h]/h,$ то есть из (1) $quad m_[x, space x + h] <= (F(x+h) - F(x))/h <= M_[x, space x + h] $\
#v(0.2cm) #h(5.28cm) из (2)  $quad m_[x, space x+h] <= #h(0.7cm) f(x) #h(0.7cm) <= M_[x, space x+h]$\
#v(0.25cm)
Таким образом
$quad abs((F(x + h) - F(x)) / h - f(x)) <= M_[x, space x+ h] - m_[x, x+h] limits(-->)_(h -> 0)^("из" (3)) 0$\ #v(0.3cm)
Т. е. $(F(x + h) - F(x)) / h limits(-->)_(h -> 0) f(x),$ т.е. $quad F'_+(x) = f(x)$\
#v(0.3cm) #h(3.3cm) Аналогично $F'_- (x) = f(x)$
\ \
== Фигуры вращения  
#columns(2)[
I тип:\
$f >= 0$, непр.\
$T([a, b]) = {(x, y, z) in RR^3:$#v(0.2cm)
#h(2.5cm)$ x in [a, b], space y^2 + z^2 <= f^2 (x) }$\
$$
#colbreak()
#align(right)[#image("9.png", width: 55%)]
]\
#columns(2)[
II тип:#v(0.2cm)
$U limits(([a, b]))_(0 <= a < b) = {(x, y, z) in RR^3:$#v(0.1cm)
#h(2cm)$ space a^2 <= x^2 + z^2 <= b^2,$#v(0.2cm)
#h(2cm)$space 0 <= y <= f(sqrt(x^2 + z^2))}$\ \
#colbreak()
#align(right)[#image("10.png", width: 73%)]
]
Нам хочеться считать объемы, поэтому введем а.ф.п.:\
$[a, b] |-> Phi[a, b] = V(T[a, b])$\
#v(0.2cm)
#h(1.4cm)$Psi[a, b] = V(U[a, b])$
\ \
#th
#v(0.2cm)
1) $Phi[a, b] = pi int_a^b f^2 (x) dif x$
#v(0.2cm)
2) $Psi[a, b] = 2 pi int_a^b x f(x) dif x$
\ \
#proof
#v(0.2cm)
1) ИЕЯ (упражнение)
#v(0.2cm)
2) ? $2 pi x f(x) $ --- плотность $Psi$#v(0.2cm)
  $quad U[a, b] subset $ Цилиндр над кольцом (с основанием) $quad a^2 <= x^2 + z^2 <= b^2, space$высоты $limits(max)_[a, space b] f$\ #v(0.2cm)
  -  $Psi[a, b] <= (pi b^2 - pi a^2) max f = pi (b + a) (max f )(b - a) <= pi dot limits(max)_(x in [a, space b]) 2 x dot (limits(max)_(x in [a, space b]) f) dot (b-a)$\ #v(0.2cm)
    $Psi[a, b] >= pi min 2x dot (min f) (b - a)$\
    #v(0.2cm) $M_[a, space b] = pi dot limits(max)_(x in [a, space b]) = pi dot max 2x dot max f$\
    #v(0.2cm) $m_[a, space b] = pi dot min 2x dot min f$\ 
    #v(0.2cm) Это ровно первый пункт обобщенной теоремы плотности #v(0.2cm)
  -  $m_[a, space b] <= 2 pi x f(x) <= pi dot max 2x dot max f(x)$\  
    #v(0.2cm) Это второй пункт теоремы#v(0.2cm)
  -  $M-m -->_(x in Delta\ abs(Delta ->0)) 0$\ #v(0.2cm)
    $max f -> f(x) <- min f$\ #v(0.2cm)
    $limits(max)_(t in Delta) 2 t -> 2 x <- min 2 t$
    #v(0.2cm) Это третий пункт

Получилось что все 3 пункта выполнены $=>$ это действительно плотность $Psi$\ \
*Посчитаем объём бублика:*\
$(x-R)^2 + y^2 = r^2$ --- это формула которой задается сечение бублика. $R$ --- расстояние от центра координат, $r$ --- радиус круга сечения.
#v(0.4cm)
$V_"бублика" = 2 dot 2pi int_(R-2)^(R+2) x sqrt(r^2 - (x-R)^2) dif x=4pi int_(R-2)^(R+2) (x-R) sqrt(r^2 - (x-R)^2) dif x + 4pi R int_(R-2)^(R+2) sqrt(r^2 - (x-R)^2) dif x$\ #v(0.4cm)
$=0+4pi R dot (pi r^2)/2 = 2pi R dot pi r^2 = 2pi^2 R r^2$

#align(center)[#image("11.png", width: 50%)]

// до начала 6 дней  // начала чего? // стрима
// начал же... // в waiting room было написано "начало 4 марта 13:30"
#pagebreak()
== Интегральные суммы
$f in C[a, space b]$\ \
#columns(2)[
#def дробление отрезка\ #v(0.2cm)
_Дробление отрезка $[a, b]$_ --- набор точек $x_0 = a < x_1 < x_2 < dots < x_n = b$
#colbreak()
#align(right)[#image("12.png", width: 60%)]
]\
\ \
#columns(2)[
#def ранг дробления (мелкость)\ #v(0.2cm)
_Ранг дробления_ --- $limits(max)_(1<=k<=n) (x_k - x_(k-1))$
#colbreak()
#align(right)[#image("13.png", width: 60%)]
]
\
#columns(2)[
#def оснащение\ #v(0.2cm)
_Оснащение_ --- набор точек $xi_1, dots, xi_n: forall k quad xi_k in [x_(k-1), x_k]$
#colbreak()
#align(right)[#image("14.png", width: 60%)]
]
\
#columns(2)[
#def интегральная (риманова) сумма\  #v(0.2cm)
_Интегральная сумма_ --- $sum_(k=1)^n f(xi_k) (x_k - x_(k-1))$
#colbreak()
#align(right)[#image("15.png", width: 60%)]
]
\
#th (_об интеграле как о пределе интегральной суммы_)\ #v(0.2cm)
$f in C[a, space b] quad $ Тогда\ #v(0.2cm)
$forall epsilon > 0 space exists space delta > 0: forall $ дробление $x_0 = a < x_1 < dots < x_n = b, $ где ранг дробления $< delta$\ #v(0.2cm)
$ abs(int^b_a f - limits(sum)_(k = 1)^n f (x_(k - 1)) (x_k - x_(k-1) )) < epsilon $
\ \
#proof #v(0.2cm)
Теорема Кантора о равномерной непрерывности: $f$ --- непр. на $[a, b] => f$ --- равн. непр.\ #v(0.2cm)
Равномерно непрерывно означает: $display(forall epsilon > 0 quad exists space delta > 0: forall x\, space overline(x): abs(x - overline(x)) < delta quad abs(f(x) - f(overline(x))) < epsilon/(b-a))$\ #v(0.4cm)
$display(abs(int_a^b f - sum_(k=1)^n dots) =^((*)) abs(sum_(k=1)^n int_(x_(k-1))^(x_k) (f(x) - f(x_(k-1))) dif x) <= sum abs(dots) <= sum_(k=1)^n int_(x_(k-1))^(x_k) abs(f(x) - f(x_(k-1))) dif x < sum int_(x_(k-1))^(x_k) epsilon/(b-a) dif x =)$\ #v(0.4cm)  $display(= sum_(k=1)^n epsilon/(b-a) abs(b-a) = epsilon)$\ \
$(*):$ здесь интеграл разбился по аддитивности на $display(sum_(k=1)^n int_(x_(k-1))^(x_k) f(x)), space$ а каждый элемент суммы представили в виде $display(sum_(k=1)^n int_(x_(k-1))^(x_k) f(x_(k-1))), space$ так как у нас каждый элемент суммы --- прямоугольник с основанием $x_k - x_(k-1)$ #v(0.2cm) и высотой $f(x_(k-1))$.
\ \
*Замечание:* в общем случае можно взять не конец отрезка, а некоторую точку $xi_k$ на нем и все будет работь.\ \ \


#def модуль непрерывности\ #v(0.2cm)
$f: [a, b] -> RR$\ #v(0.2cm)

$display(omega(delta) := limits(sup)_(x, f in [a, b]\ abs(x - t) < delta) abs(f(x) - f(t)))$ --- модуль непрерывности\ \
Т. Кантора: $omega(delta) ->_(delta -> 0) 0$ [для непр. $f$]\ #v(0.2cm)
T. Лагранжа: $f$ --- дифф на $[a, space b] quad M = max abs(f') quad$ Тогда $omega(delta) <= M dot delta$\ #v(0.2cm)
\ #v(0.2cm)
_Предыдущая теорема:_ если ранг дробления $< delta$, то $abs(int_a^b f - sum_(k=1)^n f(x_(k-1))(x_k - x_(k-1))) <= omega(delta) dot (b-a)$#v(0.2cm)
Если хотим в терминах теоремы Лагранжа: $f in C^1 quad M = max abs(f') quad abs(int - sum) <= M delta(b - a)$
#columns()[
#align(center)[#image("16.png", width: 62%)
#colbreak()
Сделаем равномерное дробление отрезка $[a, b]$ \
Посмотрим на сколько отличается интеграл от суммы.\
Он отличается ровно на площадь красных треугольничков.\
Сместим все треугольнички в последний столбец и оценим их площадь площадью прямоугольника --- победа.]
  
]
\ \

#th (_об интегральной сумме центральных прямоугольников_) #columns(2)[
$f in C^2[a, space b] quad  a = x_0 < x_1 < x_2 < dots < x_n = b$#v(0.2cm)$ quad delta = max(x_k, space x_(k - 1)), space xi_k = (x_(k-1) + x_k)/2$\ #v(0.2cm)
Тогда $abs(int_a^b f - sum_(k=1)^n f(xi_k) (x_k - x_(k-1))) <= delta^2/8 int_a^b abs(f'')$
\ \
#proof #v(0.2cm)
Упражнение (зная доказательств следующей теоремы)

#colbreak()
#align(right)[#image("17.png", width: 30%)]
]
\ \
#th (_формула трапеций_)\ #v(0.2cm) // да
$f in C^2 [a, b] quad a = x_0 < x_1 < dots < x_n = b quad delta = max (x_k - x_(k-1))$\ #v(0.2cm)
Тогда $abs(int_a^ f - limits(sum)_(k = 1)^n (f(x_(k-1)) + f(x_k)) / 2(x_k - x_(k-1))) <= delta^2/8 int_a^b abs(f'')$ \ \
#proof #v(0.2cm) 
Хотим интегрировать по частям: $int_alpha^beta u'v = u v pole(alpha, beta) - int_alpha^beta v' u $\
#v(0.4cm)
$int_(x_(k-1))^(x_k) f = int_(x_(k-1))^(x_k) f(x) dif x = $ \ \ $display(mat(delim: "[", v=f, v=f'; u'=1, u=x-xi_k)) =f(x) (x-xi_k)pole((x=x_(k-1)), (x=x_k)) - int_(x_(k-1))^(x_k) f'(x) (x-xi_k) dif x = (f(x_k) + f(x_(k-1))) (x_k - x_(k-1))/2 +$\ #v(0.4cm)  
$+display(1/2)int_(x_(k-1))^(x_k) f' (-2(x-xi_k)) dif x = display(mat(delim: "[", v=f', f'=f''; u'=-2(x-xi_k), limits(u=(x-x_(k-1))(x_k-x))_("на" [x_(k-1), x_k])))=$\ #v(0.4cm)
$=display((f(x_k) + f(x_(k-1)))/2 (x_k - x_(k-1)) + 1/2) (u dot f'pole(x=x_(k-1),x=x_k) - int_(x_(k-1))^(x_k) f'' dot u(x) dif x), space $ где $space u(x) = (x-x_(k-1))(x_k - x)$\ \ \ #v(0.2cm)
Суммируем эти формулы по $k=1,2,dots,n$\ #v(0.2cm)
$int_a^b f = display(sum_(k=1)^n) "трап" - 1/2 int_a^b f'' (x) u(x) dif x$\ #v(0.4cm)
$abs(int_a^b f - sum "трап") = 1/2 abs(int_a^b f'' (x) u(x) dif x) <= 1/2 int_(a)^b abs(f'') u(x) dif x <=^((*)) delta^2/8 int _a^b abs(f'')$\ \
$(*)$ Здесь мы заменили $u(x)$ на ее максимальное значение. Заметим что $u(x)$ выглядит как набор парабол ветвями вниз, которые проходят через точки $x_i$, при этом расстояние между $x_i <= delta => max(u) = delta^2/4$ \
#image("31.png", width: 30%)
\ 
Подсказка для центральных прямоугольников:\
#image("32.png", width:35%)

\ \ \
$[a, b] = [0, n], x_k = k$\
Формула трапеций: $abs(int_0^n f(x) dif x - sum_(k=1)^n (f(x_k) + f(x_(k-1)))/2 dot 1) <= 1/8 int_0^n abs(f'')$\
#smile $f(x) = x$#v(0.2cm)
$abs(int_0^n x dif x - (0/2 + 1/2 + (1+2)/2 + (2+3)/2 + dots + ((n-1)+n)/2)) <= 0$\
$=> 1+2+dots+n = n/2 + int_0^n x dif x = (n^2+n)/2$ #smile\
Это частный случай формулы Эйлера-Маклорена

#pagebreak()

== Простейший случай формулы Эйлера-Маклорена

$m, space n in ZZ quad f in C^2 [m, space n] quad$ Тогда\
$int_m^n f(x) d x = limits(sum)_(i = m)^n f(i) - 1/2 int_m^n f''(x) dot {x} (1 - {x}) d x$ \
Это очевидно, АГА. Это формула трапеции\
$limits(sum)_(k =  1)^n (f(x_(k - 1)) +f(x_k))/2 (x_k - x_(k-1))$\
Дробим $[m, space n]$ на единичные отрезки\
$psi(x) = (x - x_(k-1)) (x_k - x)$\
$delta^2/8 int dots quad 1/2 f(m) + f(m+1) + dots + f(n - 1) + 1/2f(n)$\
$-delta^2/2 int_a^b abs(f'') quad int f'' dot psi(x)$
//TODO
\
\
*Пример 1:* $f(x) = x^p, space p>-1$\
$1^p + 2 ^p + dots + n^p = n^p/2 + 1/2 + int_1^n x^p d x + 1/2 int_1^n (x^p)'' {x}(1 0 {x})d x$

//TODO

#pagebreak()
// скип
#pagebreak()

= Неравенства
== Интегральное неравенство Йенсена
#th\
$display(cases(reverse:#true,
f -" выпуклая, непр. на" dp(A, B),\
phi: [a, b] -> dp(A, B) - "непрерывная",\
lambda: [a, b] -> [0, +infinity)- "непр. и" int_a^b lambda = 1)) => f(underbrace( int_a^b lambda(t) phi(t) dif t, c)) <= int_a^b lambda(t) f(phi(t)) dif t$
// привет
//ку
// ты пришел дотехать те 2 лекции?
//могу и их, но вообще я зашёл перед тем, как аисд доделать
// тогда удачи, мне тут еще дофига
//оке, тебе тоже удачи
// <3
#proof\
Пусть $m = min phi, M = max phi$#v(0.2cm)
$c = int_a^b lambda(t) phi(t) dif t <= M int_a^b lambda(t) dif t = M, space$ аналогично $c >= m$#v(0.2cm)
Если $phi = "const" => display(cases(f(int_a^b lambda(t)dot "const" dif t) = f("const"dot int_a^b f(t) dif t) = f("const"), int_a^b lambda(t) f("const")dif t = f("const")dot int_a^b lambda(t) dif t = f("const")))$#v(0cm) \
В таком случае неравенство очевидно выполняется: $f("const") <= f("const")$#v(0.3cm)

В противном случае: $phi != "const" => m < c < M$ \ \

Берём в точке $c in dp(A, B)$ опорную прямую к графику: $y = alpha x + beta quad (*)$\
#image("18.png", width: 40%)
$f(c) = alpha c + beta=alpha int_a^b lambda(t) phi(t) dif t + beta  underbracket((int_a^b lambda(t) dif t), =1) = int_a^b lambda(t) (alpha phi(t) + beta) dif t <=^("в силу")_(" выпуклости") int_a^b lambda(t) f(phi(t)) dif t$ \ \
Комментарий по $(*)$: мы не хотим, чтобы опорная прямая была вертикальной, поэтому мы берём $c$ не на #v(0.15cm) конце отрезка. Можно это записать так: $c = int_a^b lambda(t) phi(t) dif t < M int_a^b lambda(t) dif t$ вместо нестрогого неравенства.\ \
== Пример (неравенство Коши в интегральной форме):
*Напоминание (обычное неравенство Коши):* $root(n, a_1 dots a_n) <= (a_1 + dots + a_n)/n$#v(0.2cm)
Теперь интегральная форма:
$f in C[a, b], space f > 0 => exp(1/(b-a) int_a^b ln f dif x) <= 1/(b-a) int_a^b f(x) dif x$#v(0.2cm)
_В качестве упражнения можно доказать при помощи интегральных сумм_#v(0.1cm)\
Доказательство при помощи неравенства Йенсена:\
$f^* <-> exp$ --- здесь $f^*$ на самом деле тот $f$ который был в формулировке неравенства Йенсена, но во избежании коллизии обозначений с тем $f$ который введен в этой теореме немного его переименуем.#v(0.1cm)
$lambda <-> 1/(b-a)$#v(0.1cm)
$phi <-> ln$#v(0.1cm)
Если исползьовать эти фукнци то наше неравенство ровно сведется к неравенство Йенсена. 
== Неравенство Гёльдера для сумм
#th\
$p > 1,space  q > 1,space  1/p + 1/q = 1,space  a_i, b_i > 0 space forall i = 1 dots n$#v(0.2cm)
Тогда $display(sum_(i=1)^n a_i b_i <= (sum a_i^p)^(1/p) (sum b_i^q)^(1/q))$\ \
#proof
$f(x) = x^p$ --- вып. на $[0, +infinity) quad quad  f'' = p(p-1)x^(p-2) >= 0$#v(0.2cm)
Нер-во Йенсена для этой фукнции: $(sum alpha_i x_i)^p <=^((1)) sum alpha_i x_i^p, space$  где $sum alpha_i = 1$#v(0.2cm)
В качестве $alpha_i$ возьмем $alpha_i =display((b_i^q)/(sum b_i^q))$ --- подходит под нужное нам условие#v(0.2cm)
В качестве $x_i$ возьмем $x_i = a_i b_i^(-1/(p-1)) (sum b_i^q)$\ \
Найдем $a_i x_i$ чтобы подставить его в Л.Ч.  (1): $alpha_i x_i = a_i b_i^(q - 1/(p-1)) = a_i b_i$\ \
Найдем $alpha_i x_i^p$ чтобы подставить его в П.Ч. (1):
$alpha_i x_i^p = display(cancel(b_i^q)/(sum b_i^q)) a_i^p cancel(b_i^(-p/(p-1))) (sum b_i^q)^p = a_i^p (sum b_i^q)^(p-1)$\ \
Подставляем то что мы только что получили в (1): $(sum a_i b_i)^p <= (sum a_i^p) (sum b_i^q)^(p-1)$\ \
Возводим предыдущее равенство в степень $1/p: (sum a_i b_i) <= (sum a_i^p)^(1/p) (sum b_i^q)^((p-1)/p=1/q)$\ \
*Наблюдение 1:* неравенство работает для нулевых слагаемых т.к нулевые множители не влияют на сумму слева и не уменьшают сумму справа#v(0.2cm)
*Наблюдение 2:*\
$a_i, b_i in RR$\
$abs(sum a_i b_i) <= sum abs(a_i b_i) <= (sum abs(a_i)^p)^(1/p) (sum abs(b_i)^q)^(1/q)$\ \
*Замечание для нер-ва Йенсена:* #v(0.1cm)
$f(sum alpha_i x_i) <= sum alpha_i f(x_i)$, $f$ --- строго выпукла, $alpha_i != 0$. Равенство достигается при $x_1 = x_2 = dots = x_n$#v(0.2cm)
Идя по док-ву нер-ва Гёльдера, заметим, что если нет нулей, то $f(x)=x^p$ --- строго выпукла на $(0, +infinity)$. Равенство достигается тогда, когда:\
$forall i quad quad  display(cases(reverse: #true,  a_i b_i^(-1/(p-1)) = lambda ,a_i^p b_i^(-p/(p-1))=lambda^p=lambda_0)) => a_i^p = lambda_0 b_i^q  => (a_1^p dots a_m^p) arrow.t arrow.t (b_1^q dots b_n^q)$ --- эта запись означает что вектора #v(0.2cm)пропорциональны дург другу\ \
== Интегральное нер-во Гёльдера
$p > 1,space q > 1,space 1/p + 1/q = 1,space f, g in C[a, b] => abs(int_a^b f g) <= (int_a^b abs(f)^p)^(1/p) (int_a^b abs(g)^q)^(1/q)$\ \
#proof #v(0.2cm)
$[a, b]$ дробим на $n$ равных частей: $display(x_k = a + k dot (b-a)/n = a + k Delta x_k)$#v(0.1cm)
*Дискретное неравенство Гёльдера:*\
$a_k = f(x_k) (Delta x_k)^(1/p)$#v(0.1cm)
$b_k = g(x_k) (Delta x_k)^(1/q)$#v(0.1cm)
$a_k b_k = f(x_k) g(x_k) Delta x_k$#v(0.1cm)
$sum abs(f(x_k) g(x_k)) Delta x_k <= (sum abs(f(x_k))^p Delta x_k)^(1/p) (sum abs(g(x_k))^q Delta x_k)^(1/q)$\ \
Свертка интегральных сумм в интеграл: $n -> +infinity: int_a^b abs(f(x) g(x)) dif x <= (int_a^b abs(f)^p)^(1/p) (int_a^b abs(g)^q)^(1/q)$\
Из-за предельного перехода равенство найти не получится #frown \ \
Неравенство Гёльдера, случай $n=2$:#v(0.2cm)
$sum a_i b_i <= (sum a_i^2)^(1/2) (sum b_i^2)^(1/2)$ --- нер-во Коши-Буняковского\ \
$p -> 1, q -> +infinity$:\
$sum a_i b_i <= sum a_i lim_(q -> +infinity) (sum b_i^q)^(1/q) = sum a_i max(b_i)$\
== Неравенство Минковского
#th\
$p >= 1, space a_i, b_i in RR$\
Тогда $(sum_(i=1)^n abs(a_i + b_i)^p)^(1/p) <= (sum abs(a_i)^p)^(1/p) + (sum abs(b_i)^p)^(1/p)$\
$p=1$ --- очев\
Смысл неравенства: елси $p>1$, тогда мы можем задать норму в $RR&^n: (a_1 dots a_n) |-> (sum abs(a_i)^p)^(1/p)$ \ \
#proof
$sum a_i abs(a_i + b_i)^(p-1) <= (sum a_i^p)^(1/p) (sum abs(a_i+b_i)^(q (p-1)=p))^(1/q)$#v(0.2cm)
$sum b_i abs(a_i + b_i)^(p-1) <= (sum b_i^p)^(1/p) (sum abs(a_i + b_i)^p)^(1/q)$#v(0.2cm)
Просуммируем два полученых неравенства:#v(0.2cm)
$sum(a_i + b_i) abs(a_i + b_i)^(p-1) = (sum (a_i + b_i)^p)^1 <=((sum abs(a_i)^p)^(1/p) + (sum abs(b_i)^p)^(1/p)) (sum abs(a_i + b_i)^p)^(1/q)$#v(0.2cm)
$(sum (a_i + b_i)^p)^(1/p) <= dots$\ \ \

#th (инт. н-во Минковского)\
$f, g in C[a, b], p >= 1$. Тогда $(int_a^b abs(f+g)^p)^(1/p) <= (int_a^b abs(f)^p)^(1/p) + (int_a^b abs(g)^p)^(1/p)$\ \
Смысл интегрального н-ва Минковского: $f |-> (int_a^b abs(f)^p)^(1/p)$ --- норма\
#proof
Вариант 1. Переписать дискр. доказательство.\
Вариант 2. Интегральные суммы\

В н-ве Гёльдера в предельном переходе $(sum b_i^q)^(1/p) -> max abs(b_i)$\
$(b_1, dots, b_n) |-> max abs(b_i)$ --- норма

= Конечные $epsilon$-сети
#def $epsilon$-сеть\
$(x, rho)$ --- МП, $D subset X$\
Мн-во $N subset X$ называется $epsilon$-сетью для $D quad forall x in D quad exists space n in N: rho(x, n) < epsilon$\ \
#def сверхограниченность\
$D$ --- сверхограниченно, если $forall epsilon > 0$ в $X quad exists$ конечная $epsilon$-сеть $N$ для мн-ва $D$\ \
#lm\
$D$ --- сверхограниченно в $X <=> D$ --- сверхограниченно в $D$#v(0.2cm)
#proof
$arrow.l.double:$ тривиально\
$=>:$ Берём конечную $epsilon/2$-сеть в $X$\
$forall n in N$ рассмотрим шар $B(n, epsilon/2)$. Отметим в каждом шаре точку $d_n$ --- конечное число.\
Тогда ${d_n}$ --- $epsilon$-сеть, лежащая в $D$.\ \
#lm\
Сверхограниченность сохраняется при равномерно непрерывных  отображениях.\
Т.е. $D subset X$ --- сверхогр., $f: X -> Y$ --- равн. непр. ($forall epsilon > 0 quad exists delta > 0: forall x_1, x_2: rho(x_1, x_2) < delta => rho(f(x_1), f(x_2)) < epsilon$)#v(0.2cm)
Тогда $f(D)$ --- св.огр. в $Y$, т.к. $f(delta"-сеть")=epsilon$-сеть\ \

*Вопрос из зала:* почему  не получиться так, что ограниченное всегда является свехрограниченным?#v(0.2cm)
Ответ: рассмотрим нормированное пространство последовательностей $L  = {(x_1, x_2, dots), abs(overline(x)) = sum_(i=1)^(+infinity) abs(x_i)}$\ 
$D = (e_1,e_2, dots) subset overline(B(arrow(0), 1))$ --- ограниченное множество.#v(0.2cm)
$e_k = (underbrace(0\, dots\, 0, (k-1)), 1, 0, dots)$\ \
$rho(e_k, e_j) = norm(e_k - e_j) = 2$ --- но это говорит нам о том что $D$ не сверхограниченно\ \
#lm\
$D$ --- сверхогр. $=>$ замыкание $D$ тоже\
$D subset limits(union.big)_N B(n, epsilon) => overline(D) subset limits(union.big)_N B(n, 2epsilon) => N$ --- $2epsilon$-сеть для $overline(D)$\ \
#lm\
$D$ --- сверхогр. $<=> forall$ посл. точек из $D$ содержит фундоментальную подпоследовательность#v(0.1cm)
*Напоминание (фундаментальная посл-ть):* $x_n$ --- фунд. $<=> forall epsilon > 0 quad exists N: forall m, k > N quad rho(x_n, x_k) < epsilon$#v(0.2cm)
#proof
$=>: epsilon := 1$. Строим конечную 1-сеть $N_1$\
$limits(union.big)_(a in N_1 \ ("кон.")) B(a, 1) supset D$#v(0.2cm)
$exists a_1 in N_1:$ в $B(a_1, 1)$ сод. беск. много членов последовательности $x_n$.#v(0.2cm)
Берём все эти бесконечно много $x_n$ и объединяем в подпоследовательность $(x_n^((1)))$, возьмём любой её член и обозначим $x_n_1$#v(0.2cm)
Теперь $epsilon := 1/2$, строим конечную $1/2$-сеть $N_2$#v(0.2cm)
$limits(union.big)_(a in N_2) B(a, 1/2) supset D$\
$exists a_2 in N_2:$ в $B(a_2, 1/2)$ содержит бесконечно много элементов из  $x_n^((1))$\
Берём эти элементы и обозначем $(x_n^((2)))$, возьмём член $x_n_2 (n_2 > n_1)$\
$dots.v$\
$(x_n_i)$ --- фундаментальная#v(0.3cm)
$arrow.l.double epsilon:$. Нет $epsilon$-сети?#v(0.2cm)
Какая то $x_1, "другая" x_2 in.not B(x_1, epsilon) " и " x_3 in.not B(x_1, epsilon) union B(x_2, epsilon)$#v(0.2cm)
Таким образом построим посл-ть: $forall x_k, x_m quad rho(x_k, x_m) >= epsilon$ #v(0.2cm)
У посл-ти $(x_n)$ нет фунд. подпосл. Противоречие в определении для обсуждаемого $epsilon$.\ \
#lm\
$X$ --- сверхогр. $=>$ в $X$ имеется счётное всюду плотное подмножество $Q$. (т.е. $X$ --- сепарабельное)#v(0.2cm)
#proof
$Q = limits(union.big)_(n=1)^(+infinity) (1/n"-сеть")$\ \
#th\
$(X, rho)$ --- МП. Эквивалентны:
+ $X$ --- компактно
+ $X$ --- полно и сверхограниченно
#proof
*Замечание:* в МП комп. $<=>$ секв. комп.\
$(1)=>(2):$\
$X$ --- неполно $=> exists$ фундаментальная последовательнсоть, не имеющая предела $=> forall$ подпоследовательности верно, что она тоже не имеет предела $=>$ это противоречит секвинциальной компактности\
$X$ --- не сверхограничено $=>$ по лемме 4 $exists$ последовательность, у которой $exists.not$ фунд. подпосл. $=>$ у этой последовательности нет сходящейся подпоследовательности $=>$ противоречит секвинциальной компомпактности\
$(2)=>(1):$\
$X$ --- сверхограниченно $=> forall$ последовательность точек из $X quad exists$ фундаментальная подпоследовательнсоть $=>_(X" - полное")forall$ последовательнсоть точек из $X$ имеет схододящейся подпоследовательности, т.е. это секвинциальная компактность.
= Несобственный интеграл
#def несобственный интеграл#v(0.1cm)
$f:[a, b) -> RR quad (-infinity < a < b <= +infinity)$#v(0.2cm)
$f$ --- *допустима*, если $forall A: a <= A < b quad f$ --- кусочно-непрерывна на $[a, A]$\ \
$Phi(A)=int_a^A f(x) dif x$, где $A in [a, b)$\
Если $exists lim_(A->b-0) Phi(A) in overline(RR)$, то величина называется несобственным интегралом $int_a^(arrow b) f(x) dif x$\
Если $exists.not lim_(A->b-0) Phi(A) in overline(RR)$, то несобств. инт. не существует.\
Если $lim Phi(A) in RR$, то интеграл сходится.\
Если $lim Phi(A) = {plus.minus infinity}$ или не сущ., то интеграл расходится.\ \
*Пример:*#v(0.2cm)
+ $int_1^(+infinity) 1/x dif x$\ \
  $int_1^A 1/x dif x = ln A ->_(A -> +infinity) +infinity$ --- расходиться #v(0.2cm)
  
+ $int_0^1 1/x dif x = lim_(A->+0) int_A^1 1/x dif x = -ln A ->_(A->+0) +infinity$ --- расходиться#v(0.25cm)

+ $int_1^(+infinity) (dif x)/x^2 = lim_(A -> +infinity) (-1)/x pole(1, A) = lim_(A -> +infinity) -1/A + 1 -> 1$ --- сходиться #v(0.25cm)

+ $int_1^(+infinity) sin x dif x = lim_(A->+infinity) int_1^A sin x = lim_(A->+infinity) -cos A + cos 1$ --- не существует

\ \
#note 
+ $f in C[a, b]: int_a^(arrow b) f = int_a^b f$ --- очевидно\
+  Теперь можно находить $int_a^(+infinity)$ (стрелочка не нужна, потому что нет путаницы)\
+ Стрелочка не меняет значения для собственных интегралов, а несобственность и так понятна#v(0.2cm)

  $int_a^(arrow b) f = F pole(a, ->b) = lim_(A -> b-0) F(A) - F(a)$\
\ \
*Свойства:*
+ Критерий Больцано-Коши#v(0.1cm)
  *Напоминание для фунций:*#v(0.2cm)
  $exists$ кон. $lim_(x->a) f(x) <=> forall epsilon > 0 quad exists delta > 0: forall x_1: abs(x_1 - a) < delta, forall x_2: abs(x_2 - a) < delta: abs(f(x_1)-f(x_2)) < epsilon$ #v(0.2cm)
  *Для интегралов:*#v(0.1cm)
  Сходимость $int_a^(arrow b) f <=> forall epsilon > 0 quad exists Delta in [a, b): forall A, B > Delta quad abs(int_A^B f) < epsilon$\
  Отрицание: $exists space epsilon > 0: forall Delta in [a, b) quad exists A, B > Delta: abs(int_A^B) >= epsilon$,#v(0.2cm)
  т.е. если $exists space  epsilon  space exists space  (a_n), (b_n) -> b-0 quad abs(int_(a_n)^(b_n) f) >= epsilon => int_a^(arrow b) "расходится"$\ \
  *Пример:*#v(0.1cm)
  $int_1^(+infinity) sin x dif x$ --- расходится#v(0.2cm)
  $A_n = 2 pi n, B_n = 2 pi n + pi:$
  $int_(A_n)^(B_n) sin x = 2 >= epsilon = 2$
  
+ Аддитивность по промежутку#v(0.2cm)
  $forall c in (a, b)$, пусть $exists int_a^(arrow b) f => $
 $int_a^(arrow b) f = int_a^c f + int_c^(arrow b) f$#v(0.2cm)
  #proof#v(0.1cm)
  Очевидно. Берём $A: c < A < b$#v(0.2cm)
  $int_a^A f = int_a^c + int_c^A, quad A ->b-0$\ \
  _Соглашение._ $f$ --- допустимая для $int_0^(->+infinity), int_(->-infinity)^0 quad => quad$
  $int_(-infinity)^(+infinity) f = int_0^(+infinity) f + int_(-infinity)^0 f = int_(2024)^(+infinity) f + int_(-infinity)^2024 f$, если сложение#v(0.2cm) корректно (не случается ситуации $+infinity-infinity$)#v(0.4cm)
  _Общее соглашение._ $f: RR -> RR$ непрерывна, кроме $a_1, a_2, a_3$#v(0.2cm)
  $b_1 < a_1 < b_2 < a_2 < b_3 < a_3 < b_4$#v(0.2cm)
  $int_(-infinity)^(+infinity) f = int_(-infinity)^(b_1) + int_(b_1)^(->a_1) + int_(->a_1)^(b_2) + int_(b_2)^(->a_2) + int_(->a_2)^(b_3) + int_(b_3)^(->a_3) + int_(->a_3)^(b_4) + int_(b_4)^(+infinity)$, если все существует и сложение корректно.\ \
  *Пример:*\
  $int_(-1)^(1) 1/x dif x space cancel(=0)$, т.к. он расходится (возникает выражение $-infinity+infinity$)#v(0.2cm)
  Можно сделать небольшой трюк:$int_(-1)^1 = lim_(epsilon -> 0) int_([-1, 1] without [-epsilon, epsilon]) 1/x dif x = 0$,  но это достатоно опасно так что не стоит так делать.\ \
  #cor()\
  $a < A < b, int_a^(->b) f$ сходится, 
  тогда $int_(A)^(->b) f -->_(A->b-0) 0$#v(0.2cm)
  #proof#v(0.2cm)
  $int_a^(->b) f = limits(int_a^A f)_(space arrow.b\ int_a^(->b) f) + limits(int_A^(->b) f)_(arrow.b\ 0)$
  
+ $f, g$ --- допустимые на $[a, b)$, $int_a^(->b) f, int_a^(->b) g$ сходятся, $lambda in RR$\ \
  Тогда $lambda f, f plus.minus g$ --- допустимы и $int_a^(->b) lambda f = lambda int_a^(->b) f, quad int_a^(->b) f + g = int_a^(->b) f + int_a^(->b) g$
  #proof
  Упражнение читателю.\
  
+ $f, g$ --- допустимы, $int_a^(->b) f, int_a^(->b) g$ сущ., $f <= g$\
  Тогда $int_a^(->b) f <= int_a^(->b) g$#v(0.2cm)
  #proof
  При $a < A < b quad int_a^A f <= int_a^A g, quad A -> b-0$\
  
+ Интегрирование по частям:#v(0.2cm)
  $f, g$ --- дифф, $f', g'$ --- допустимы. Тогда\*\ #v(0.2cm)
  $int_a^(->b) f g' = f g pole(a, ->b) - int_a^(->b) f'g$\ \
  #proof #v(0.2cm)$int_a^A f g' = f g pole(a, A) - int_a^A f'g, quad A -> b-0$#v(0.2cm)
  \*: если $exists space 2$ выражения со стрелочками, то $exists$ и третий и имеет место "="
+ Замена переменной: #v(0.2cm)
  $phi:[alpha, beta) -> dp(A, B), space phi in C^1$ #v(0.2cm)
  $phi(beta - 0) in overline(RR), f in C(dp(a, b))$ #v(0.3cm)
  Тогда: $int_alpha^(->beta) (f op(circle.small) phi) phi' = int_(phi(alpha))^(->phi(beta-0)) f$ #v(0.2cm)
  #proof
  $f in C[a, b] quad lim_(A->b-0) int_a^A f = lim_(A->b-0) (int_a^b f - int_A^b f) = int_a^b f$\
  $abs(int_A^b f) <= max abs(f) dot (b-A) -> 0$
= Признаки сходимости интеграла
*Наблюдение.*\
$f$ --- допустима на $[a, b)$, $f >= 0, Phi(A) = int_a^A f$\
$int_a^b f$ --- сходится $<=> Phi$ --- огр. $quad$ (очевидно: $Phi arrow.tr$)\
В этом случае $lim_(A->b-0) Phi(A) = limits(sup)_[a, b) Phi$\ \
#th _признак сравнения_\
$f, g$ --- допустимые на $[a, b), f, g >= 0$\
+ $f <= g$ на $[a, b]$. Тогда:
  - Если $int_a^b f$ расходится, то $int_a^b g$ расходится #v(0.2cm)
  - Если $int_a^b g$ сходится, то $int_a^b f$ сходится #v(0.2cm)

+ $lim_(x->b-0) f(x)/g(x) = l$
  - $l in (0, +infinity): int_a^b f, int_a^b g$ сходятся одновременно, расходятся тоже #v(0.2cm)
  - $l = 0: int_a^b f$ расходится $=> int_a^b g$ расходится; $int_a^b g$ сх $=> int_a^b f$ сходиться #v(0.2cm)
  - $l = +infinity: int g$ расходится $=> int f$ расходится; $int f$ сх  $=> int g$ сходиться #v(0.2cm)
#proof
+ $f <= g quad Phi(A) = int_a^A f, Psi(A) = int_a^A g,quad  Phi <= Psi$\
  $int_a^b f$ расходиться $=> Phi$ неограничена $=> Psi$ неограничена $=> int_a^b g$ расходиться\ #v(0.2cm)
  $int_a^b g$ сходиться $=> Psi$ ограничена $=> Phi$ ограничена $=> int_a^b f$ сходиться #v(0.2cm)
  
+ Сходимость $int_a^b f$ или при $c in (a, b)$ сходимостьсть $int_c^b f$ --- одно и то же #v(0.4cm)
  - $l in (0, +infinity): exists space c in (a, b): "при" x in (c, b) quad l/2< f(x)/g(x) < 3/2 l$ #v(0.1cm)\
   $int_a^b f$ сходиться $=> int_c^b f$ сходиться, на $(c, b) quad l/2 g(x) < f(x) => int_c^b l/2 g$ сходиться $=> int_c^b g$ сходиться #v(0.3cm)
   $int_a^b g$ сходиться $=> int_c^b g$ сходиться, $f < 3/2 g => int_c^b 3/2 g$ сходиться $=> int_a^b f$ сходиться  #v(0.3cm)
  - $l = 0 quad$ для $epsilon = 1 quad exists space  c: forall x in (c, b) quad f(x)/g(x) < 1$, т.е. $f < g$ и результат слеюует из 1 части признака  #v(0.2cm)
    #h(37pt)для $Epsilon = 1 quad exists space c: forall x in (c, b) quad f(x)/g(x) > 1$  #v(0.2cm)

*Примеры:*\  #v(0.2cm)
+ "Эталоны":\
  $int_a^(+infinity) 1/(x^p) dif x = display(cases(delim: "[", 1/(1-p) x^(1-p) pole(a, +infinity)&\, quad p!=1, ln x pole(a, +infinity)&\, quad p=1)) = display(cases(delim: "[", "кон"&\, quad p > 1, +infinity&\, quad p <= 1))$\ \
  $int_(->0)^1 1/(x^p) dif x = display(cases(delim: "[", "кон"&\, quad p < 1, 
  +infinity&\, quad p >= 1))$\ \
  
+ $int_0^(+infinity) (cos^2 x)/(x^2 + 1) dif x$  #v(0.2cm)
  $(cos^2 x)/(x^2 + 1) <= 1/(x^2 + 1)=>$ проверим
  $int_0^(+infinity) 1/(x^2 + 1) dif x = arctan x pole(0, +infinity) = pi/2$ --- он сходиться $=>$ изначальный сходиться\

+ $int_10^(+infinity) (arctan x)/(sqrt(x) ln x) cos 1/x dif x$#v(0.2cm)
  Попробуем заменить $f$ на эквивалентную: $f tilde_(x->+infinity) c/(sqrt(x) ln x)$#v(0.2cm)
  $int_10^(+infinity) c/(sqrt(x) ln x) dif x$\ \
  $display(cases(reverse: #true,
  int_10^(+infinity) 1/sqrt(x) = +infinity\, int^(+infinity) 1/x = +infinity,
  lim_(x->+infinity) ln(x)/sqrt(x) = 0,
  1/sqrt(x) > 1/(sqrt(x) ln x) > 1/x
  )) => int_10^(+infinity) c/(sqrt(x) ln x) dif x$ --- расхдится\ \
 
+ $int_10^(+infinity) (dif x)/(x^alpha (ln x)^beta)$#v(0.2cm)
  + $alpha > 1:$
    $alpha = 1 + 2 a, space a > 0$#v(0.2cm)
    $display(1/(x^(1+2a) (ln x)^beta) = 1/(x^(1+a)) dot 1/(x^a (ln x)^beta))$#v(0.2cm)
    #emoji.face.wink $lim_(x->+infinity) x^a (ln x)^beta = +infinity =>$ при больших $x: (exists space c: forall x > c: space display(1/(x^a (ln x)^beta) < 1))$ --- но это надо доказать\
    Докажем что предел $+infinity$ при помощи правила Лопиталя: $lim_(x->+infinity) (x^a)/((ln x)^(-beta)) = (lim limits((x^(a/(-beta))/(ln x)))_(arrow.br +infinity))^(-beta) = +infinity$#v(0.4cm)
    Предел в скобках тоже найдем при помощи правила Лопиталя:  $lim (x^gamma)/(ln x) = lim (gamma x^(gamma - 1))/(1/x) = lim gamma x^gamma = +infinity$#v(0.4cm)
    $int_10^(+infinity) -> int_c^(+infinity) 1/(x^(1+a)) dot underbracket(1/(x^a (ln x)^beta), <1) < int_c^(+infinity) 1/(x^(1+a))$ --- сходистся $=>$ при $alpha > 1$ интеграл начальный сходиться.#v(0.2cm)
    Название только что примененного приёма: _удавить логарифма_) #v(0.2cm)\
  + $alpha < 1:$
    $alpha = 1-2a, a > 0$\ #v(0.2cm)
    $display(1/(x^(1-a)) dot 1/(x^(-a) (ln x)^beta))$#v(0.2cm)
    $display(lim_(x->+infinity) (x^a)/(ln x)^beta) = dots = +infinity$#v(0.2cm)
    При $x > c: quad display(1/(x^(-a) (ln x)^beta)) > 1 => display(1/x^(1-a) dot 1/(x^(-a ln x)) > 1/x^(1 - a)) =>$ интеграл расходиться#v(0.4cm)
  + $alpha = 1$:#v(0.2cm)
    $display(int_10^(+infinity) (dif x)/(x (ln x)^beta) =_(y=ln x) int_(ln 10)^(+infinity) (dif y)/(y^beta))$ --- это эталонный случай: $beta <= 1$ --- расходится, $space beta > 1$ --- сходится

    \ 
== $Gamma$-функция Эйлера
  $Gamma(t) = int_(0)^(+infinity) x^(t - 1) e^(-x) dif x, t > 0$\
  + При $t > 0$ интеграл сходится: $int_0^1 x^(t-1) e^(-x) dif x$, т.к.  
    $space x^(t-1) e^(-x) tilde_(x->+0) x^(t-1)$ --- эталонный случай (сходиться)\
    $display(x^(t - 1) e^(-x) dif x = int_1^(+infinity) e^(-x/2) dot underbracket(e^(-x/2) dot x^(t - 1), -->_(x->+infinity) 0))$\ #v(0.2cm)
     то, что выделеная часть стремиться к 0, означает, что $exists space c: forall x > c quad e^(-x/2) x^(t - 1) < 1$ #v(0.2cm)
    Получается, что $e^(-x/2) dot underbracket(e^(-x/2) x^(t-1), <1) < e^(-x/2) space$ и нам необходимо проверить сходимость следующего интеграла:  #v(0.1cm)
    $int_c^(+infinity) e^(-x/2) dif x = -2 e^(-x/2) pole(c, +infinity)$ --- сходиться, значит и изначальный сходиться. #v(0.2cm)\
  + $Gamma$ --- выпукла на $(0, +infinity) => Gamma$ --- непрерывна\
    Для начала покажем, что подынтегральная фукнция выпукла:
    $t |-> f_x(t) = x^(t-1) e^(-x)$\
    Для этого возьмем две производные:\
    $f'(t) = x^(t-1) ln x e^(-x)$ #v(0.2cm)
    $f''(t) = x^(t-1) ln^2 x e^(-x) >= 0$ --- значит действительно выпукла. #v(0.2cm)
    Напишем определение выпуклосьи: $forall t_1, t_2 space forall alpha in (0, 1) quad f_x(alpha t_1 + (1-alpha t_2)) <= alpha f(t_1) + (1-alpha) f_x (t_2)$\ \
    Интегрируем это неравенство по 
    $x :int_0^(+infinity) f_x (alpha t_1 + (1-alpha) t_2) dif x <= alpha int_0^(+infinity) f_x (t_1) dif x + (1-alpha) int_0^(+infinity) f_x (t_2) dif x$\ \
    Для понимания происходящего: последнее слагаемое имеет такой вид: $(1-alpha) int_0^(+infinity) x^(t_2 - 1) e^(-x) dif x$ #v(0.2cm)
    Итого мы получили, что $Gamma(alpha t_1 + (1-alpha) t_2) <= alpha Gamma(t_1) + (1-alpha) Gamma(t_2)$, а это как раз занчит что #v(0.2cm)
    $Gamma$ выпуклая $=> Gamma$ --- непрерывна\ \ \
  + 
    + $Gamma(t + 1) = int_0^(+infinity) limits(x^t)_f limits(e^(-x))_g' dif x = limits(x^t (-e^(-x)))_(=0) pole(x=0, x=+infinity) + t int_0^(+infinity) x^(t-1) e^(-x) dif x = t dot Gamma (t)$ #v(0.2cm)
    + $Gamma(1) = int_0^(+infinity) e^(-x) = -e^(-x) pole(0, +infinity) = 1$ #v(0.2cm)
    + $Gamma(n+1) = n!, n in NN$ #v(0.2cm)
      $Gamma(t+1) = t Gamma(t) => Gamma(t) = Gamma(t+1)/t tilde_(t->0) 1/t$ #v(0.2cm)
    + $Gamma(1/2) = sqrt(pi)$\
    #image("19.png", width: 40%)

== Интеграл Эйлера-Пуассона
$I = int_0^(+infinity) e^(-x^2) dif x = 1/2 sqrt(pi)$ #v(0.2cm)
$int_0^(+infinity) e^(-x^2) dif x =_(x=sqrt(y)) int_0^(+infinity) 1/(2 sqrt(y)) dif y = 1/2 Gamma(1/2)$ #v(0.4cm)
#proof #v(0.2cm)
$1-x^2 <= e^(-x^2) <= 1/(1+x^2) quad forall x in RR$ --- левая часть это выпуклость в прямом её виде,  правая часть: $1+x^2 <= e^x^2$ #align(right)[--- тоже выпуклость.]\
#image("20.png", width: 20%)
$display(limits(int_0^1 (1-x^2)^n)_(=_(x=cos t) w_(2n+1)) <= int_0^1 e^(-n x^2) <= limits(int_0^(+infinity) e^(-n x^2))_(=_(x=y/sqrt(n)) 1/sqrt(n) I) <= limits(int_0^(+infinity) 1/(1+x^2)^n dif x)_(=_(x=tg t) w_(2n-2)))$\ \
Здесь в качестве $w$ использовался интеграл из формулы Валлиса:\
#box(stroke: 1pt, inset: 7pt, "Формула Валлиса:\n"+$w_n = int_0^(pi/2) sin^n x = display(cases(delim: "[", (n-1)!!/n!! pi/2&\, quad "четн", (n-1)!!/n!!&\, quad "нечет"))$ +"\n\n В частности: "+ 
$(2k)!!/(2k-1)!! dot 1/sqrt(k) -> sqrt(pi)$)\ \

Итого мы получили:\
$display(w_(2n+1) <= 1/sqrt(n) I <= w_(2n - 2))$ #v(0.4cm)
$display(limits((2n)!!/(2n+1)!!) sqrt(n) <= I <= (2n-3)!!/(2n-2)!! pi/2 sqrt(n) = 1/((2n-2)!!/(2n-3)!! 1/sqrt(n-1)) dot (pi/2)/(sqrt(n-1)/sqrt(n)) -> sqrt(pi)/2)$#v(0.4cm)
$display((2n)!!/((2n-1)!! sqrt(n)) n/(2n+1) -> sqrt(pi))$\ \
== Абсолютно сходящиеся интегралы
#def абсолютно сходящийся интеграл\
$f$ --- допустимая на $[a, b)$ #v(0.2cm)
$int_a^b f$ абсолютно сходится $<=> 
display(cases(int_a^b f - "сходится", int_a^b abs(f) - "сходится" ))$
\ \
#th\
$f$ --- допустимая на $[a, b)$. Тогда эквивалентны:
+ $int_a^b f$ --- абсолютно сходиться

+ $int_a^b abs(f)$ --- сходится
+ $int_a^b f_+, int_a^b f_-$ оба сходятся
 #v(0.2cm)
#proof
$1=>2$: Да. #emoji.face.cool\
 #v(0.2cm)
$2=>3$: $0 <= f_plus.minus <= abs(f)$\
 #v(0.2cm)
$3=>1$: $int_a^b f = int_a^b f_+ - int_a^b f_-, quad int_a^b abs(f) = int_a^b f_+ + int_a^b f_-$\
*Замечание:*\ #v(0.2cm)
$int_a^b f$ сходится $arrow.r.double.not f -->_(x->b-0) 0$\  #v(0.4cm)
*Пример:*\ #v(0.2cm)

$sum_(n=1)^(+infinity) 1/2^n = 1$
#image("21.png", width: 30%)
Можно подобрать ширину так, чтобы высота $n$-го треугольника $=n!$, площадь $=1/2^n$ и получиться кусочно непрерывная функция, у которой сходящийся интеграл, но которая при этом не стремиться к 0 и даже не ограничена.

#pagebreak()

*Продолжаем абсолютно сходящиеся интегралы* \ \

*Пример:*\ #v(0.2cm)
$int_1^(+infinity) (sin x)/x^p dif x, quad p in RR$ --- изучим абсолютную сходимость\ #v(0.2cm)

1\. $abs((sin x)/x^p) <= 1/x^p quad => space $ при $p > 1$ сходится абсолютно
\ \
2\. При $p < 0 quad int_(2 pi n)^(2 pi n + pi) (sin x)/x^p >= (2 pi n)^(-p) int_(2 pi n)^(2 pi n + pi) sin x >= 2 ( 2 pi n)^(-p)$ расходится (в т.ч. абс. расх.)\ \
3\. При $p = 0$ тоже расходится: $abs(int_(A^n)^(B_n) sin x) > 1/1000, quad A_n = 2pi n, B_n = 2pi n+pi, A_n, B_n -> +infinity$\ \
4\. $int_1^(+infinity) abs(sin x)/x^p dif x, quad p in (0, 1] tilde.triple int_1^(+infinity) 10^(-6)/x^p dif x$ расходится\ \
$int_(pi n)^(2 pi n) abs(sin x)/x^p >= int_(pi n)^(2 pi n) abs(sin x)/x dif x >= 1/(pi n) int_(pi n)^(2 pi n) abs(sin x) dif x = 2/pi$ --- нет абс сходимости
\ \ \ \
#image("22.png", width: 50%)
$int_(2 pi n)^(2 pi n + pi) 1/x^p sin x + int_(2 pi n + pi)^(2 pi n + 2 pi) 1/x^p sin x$\ \ $y = x - pi$ \ \
$int_(2 pi n)^(2 pi n + pi) (sin x)/x^p - int_(2 pi n)^(2 pi n + pi) (sin y)/(y+pi)^p sin x$\ \
$int_(2 pi n)^(2 pi n + pi) sin x(1/x^p - 1/((x+pi)^p))$\ \

$int_1^(+infinity) (sin x)/x^p = display(mat(delim: "[", f=1/x^p, g' = sin x))=-(cos x)/x^p pole(1, +infinity) - p underbracket(display(int)_1^(+infinity) (cos x)/x^(p+1), "абс. сх.")$\ \
$int_1^(+infinity) abs(sin x)/x^p >=_(wink) int_1^(+infinity) (sin^2x) / x^p = int_1^(+infinity) (1 - cos 2 x)/(2 x^p) d x = underbracket(int_1^(+infinity) 1/(2 x ^p), =+infinity) - underbracket(int_1 ^(+infinity) (cos 2 x)/(2x^p), "сх")$
\ \
// Я НИХРЕНА НЕ ПОНЯЛ, поэтому временно этот интеграл отправляется в 
== Признаки сходимости
#th (_признак Дирихле_)\ #v(0.2cm)
$f, g$ --- допустимы на $[a, b)$\  #v(0.2cm)
Пусть: #v(0.2cm)

1\. первообразная $f$ ограничена: $exists C: forall B in (a, b) quad abs(int_a^B f) <= C$
 #v(0.2cm)
2\. $g(x)$ --- монотонная, $g in C^1 ([a, b]), quad g(x) -->_(x->b-0) 0$ #v(0.2cm)
Тогда $int_a^(->b) f g$ --- сходится\
\ 
#proof
Обозначим $F(B) = int_a^B f$ --- первообразная.\
$int_a^b f g = underbracket(F(x) g (x) pole(a, ->b), "огр" dot "б.м.") - underbracket(int_a^(->b) F(x) g'(x) dif x, "абс. сх.": int_a^(->b) abs(F(x)) dot abs(g'(x)) dif x <=\ <= C int_a^(->b) abs(g') dif x = plus.minus C int_a^(->b) g' dif x =\ = plus.minus g(x) pole(a, ->b))$ #v(0.2cm)
Тут в оценке у второго интеграла мы воспользовались тем что, $g(x)$ --- монотонная, поэтому $g'(x)$ всегда одного знака и модуль может раскрыться только двумя способами.
\ \
#th (_признак Абеля_)\ #v(0.2cm)
$f, g$ --- допустимые на $[a, b)$\ #v(0.2cm)
Пусть:
#v(0.2cm)
1\. $int_a^(->b) f$ --- сходится
#v(0.2cm)
2\. $g in C^1 ([a, b]), g(x)$ монотонна, ограничена
#v(0.2cm)
Тогда $int_a^(->b) f g$ сходится.
\ \
#proof #v(0.2cm)
Пусть $lim_(x->b-0) g(x) = alpha in RR$\ #v(0.2cm)
$int_a^(->b) f g = underbracket(int_a^(->b) f alpha, "сх по п.1") + underbracket(int_a^(->b) f (g-alpha), "сх по Дирихле")$
\ \
*Пример:*\ #v(0.2cm)
$int_1^(+infinity) (sin x)/x^p: quad f = sin x quad F = cos x$ --- огр. $quad g = 1/x^p, space p > 0 =>$ монот, $->0 -->$ сх по Дирихле\ \
$int_10^(+infinity) sin(x^3 - x) dif x: quad underbracket(f = (3 x^2 - 1) sin(x^3 - x), F = -cos(x^3-x) - "огр.") , quad underbracket(g = (1)/(3x^2 - 1), "монот"\,space  ->0) =>$ сходится\  \

== Интеграл Дирихле
$display(int_0^(+infinity) (sin x)/x dif x = pi/2)$\
Для начала покажем, что: 
$display(cos x + cos 2 x + dots + cos n x = (sin (pi + 1/2) x)/(2 sin x/2) - 1/2)$\ \
*Напоминание из тригонометрии:* $space cos(alpha) sin(beta) = 1/2 (sin(alpha + beta) - sin(alpha - beta))$\ \
$2 sin x/2 cos k x = sin (k+1/2)x - sin((k-1/2)x)$\ \
Получается телескопическая сумма, и после сокращения всего получисться верное равенство.\ \

Теперь проинтегрируем обе части :
$space display(0 = int_0^pi cos x + dots + cos n x = int_0^pi (sin(n + 1/2)x)/(2sin x/2) dif x - pi/2)$#v(0.2cm)
Переносим $pi/2$ в другую сторону: 
$display(int_0^pi (sin(n+1/2)x)/(2sin x/2) dif x = pi/2)$\ \
Проверим, что $display(int_0^pi (sin (n+1/2)x)/(2sin x/2) - int_0^pi (sin(n+1/2) x)/(x)) -->_(n -> +infinity)0$ #v(0.2cm)

Если это выполняется, то $display(int_0^pi ((sin n + 1/2)x) / x -> pi/2 = int_0^((n + 1/2)pi) (sin y)/y dif y -> int_0^(+infinity) (sin y)/y)$
\ \
*Утверждение.* Функция $f(x) = display(1/(2 sin x/2) - 1/x)quad $ (пусть $f(0) = 0$)  чтобы была непрерывность на $RR$)\ 
$display(f' = (-cos x/2)/(2^2 dot sin^2 x/2) + 1/x^2), quad x != 0$\ \
$display(lim_(x->0) f' = lim_(x->0) (4 sin^2 x/2 - x^2 cos x/2)/(4 x^2 sin^2 x/2) = lim_(x->0) (4(x/2 - x^3/48 + o(x^3))^2 - x^2 (1-x^2/8 + o(x^2)))/x^4 = -1/12 + 1/8) quad smile$\ \

$display(int_0^pi limits(sin(n+1/2) x)_g' dot limits(f(x))_f dif x = underbracket(-(cos(n+1/2)x)/(n+1/2) dot f(x)pole(0, pi), = space 0)  + 1/(n+1/2) underbracket(int_0^pi underbracket(cos(n+1/2) x underbracket(f'(x), "непр"), "непр") dif x, <= "const") -->_(n->+infinity)0)$

#image("23.png", width: 35%)\ \
== Интегрирование ассимптотических разложений
*Напоминание:*#v(0.2cm)
$phi_k: (a, b) -> RR$\ \
$underline(x -> a) quad forall k quad phi_(k+1) = o(phi_k)," тогда при "  x->a quad {phi_k}$ --- шкала асимпт. разложения\ \
$forall n space f = c_0 phi_0 (x) + c_1 phi_1 (x) + dots + c_n phi_n (x) + o(phi_n)$\ \
Пример --- формула Тейлора: $f(x) = sum_(k=0)^n (f^((k)) (a))/k! (x-a)^k + o((x-a)^n)$\ \
$f tilde sum_(k=0)^(+infinity) c_k phi_k (x)$\ \
$g tilde sum_(k=0)^(+infinity) c_k phi_k (x)$\ \
$forall n quad f - g = o(phi_n), n -> +infinity$\ \
\
#lm (_об интегрировании асимптотических равенств_)\
$f, g in C([a, b)), quad g >= 0, int_a^(->b) g$ расх\
$F(x) = int_a^x f, quad quad $
$G(x) = int_a^x g$\
Тогда при $x -> b-0$ из соотношений #v(0.2cm) #h(1.5cm)$f = O(g),#h(10pt)f = o(g),#h(7pt)f tilde g$#v(0.2cm)  следует $F = O(G), space F = o(G), F space tilde G $
\ \
#proof #v(0.2cm)
1\. $F = O(G):$ #v(0.2cm)
$exists M space  exists x_0$ при $x in [x_0, b) quad abs(f(x)) <= M g(x)$\ \
Чего мы хотим? Мы хотим похожее неравенство на интегралы: $int_a^x f <= mu dot int_a^x g$ //quad int_(x_0) ^x int_a ^ (x_0 f)$  
#v(0.2cm)

Пусть $int_a^(x_0) abs(f) dif x = c_1. quad$ Возьмём $x_1: x_0<x_1<b quad quad int_(x_0)^(x_1) g = alpha > 0$\ \
При $x > x_1 quad abs(int_a^x f) <= int_a^x abs(f) = int_a^(x_0) + int_(x_0)^x <= c_1 + M dot int_(x_0)^x g = c_1 / alpha  int_(x_0)^(x_1) g + M int_(x_0)^(x_1) g <= (c_1/alpha + M) int_(x_0)^x g <= (c_1/alpha + M) int_a^x g$
\ \
2\. $F = o(G):$\ #v(0.2cm)
$display(forall epsilon > 0 quad exists x_0: abs(x_0) < epsilon/2 g(x))$\ \
Хотим: $display(forall epsilon > 0 quad exists x_0: abs(int_(x_0)^x f) <= epsilon/2 int_(x_0)^x g)$\ \
$exists x_1 > x_0 quad$ для $с:= int_a^(x_0) f$ при $x > x_1 quad abs(c + int_(x_1)^x) <= epsilon int_(x_0)^x g$\ \
$abs(int_(x_1)^x f) < epsilon/2 int_(x_1)^x g$\ \
$int_a^B -->_(B->b-0) +infinity$\ \
$c < epsilon/2 int_(x_0)^x g$\ \ 
$abs(int_a^(x_0) f) <= epsilon int_(x_0)^x g <= epsilon int_a^x g$ при $x > x_1$
\ \
3\. $f tilde g$\ \
$lim_(x->b-0) F(x)/G(x) = [infinity/infinity] =^"Лопиталь" lim_(x->b-0) f(x)/g(x) = 1$
\ \ \
#lm\
1. $phi_n in C([a, b]) space phi_n >= 0$ --- шкала асимптотического разложения при $x -> b-0$ \ \
  Пусть $forall n quad Phi_n (x) = int_(x)^(->b) phi_n (x)dif x$ --- сходится, тогда $Phi_n$ --- тоже шкала\
+  $f in C([a, b]) quad F(x) = int_x^b f$ --- сходится\
  Пусть $f(x) tilde sum c_n phi_n (x)$\ #v(0.2cm)
  Тогда $F tilde sum c_n Phi_n$
\ 
#proof #v(0.2cm)
+ Проверим, что $Phi_(n+1) = o(Phi_n): quad  display(lim_(x->b-0) (Phi_(n+1) (x))/(Phi_n (x)) = [0/0] =^"Лопиталь" lim_(x->b-0) (-phi_(n+1))/(-phi_n) = 0)$\ #v(0.3cm)
+ $f(x) = sum_(k=1)^n c_k phi_k (x) + o(phi_n)$\ #v(0.3cm)
  $display(lim (F(x) - sum_(k=1)^n c_k Phi_k)/Phi_n = [0/0] =^"Лопиталь" lim (f(x)-sum c_k phi_k (x))/(phi_n (x)) = 0)$\ \
*Пример:*\
$arctan x tilde_(x->+infinity) ?$\ #v(0.2cm)
При дифференцировании:\ #v(0.2cm)
$display(1/(x^2 + 1) tilde 1/x^2)$\ \
$display(pi / 2 - arctan x = int_x^(+infinity) (dif t)/(t^2 + 1) tilde int_x^(+infinity) (dif t)/t^2 = 1/x)$\ \
$display(arctan x = pi/2 - 1/x + o(1/x))$\ \
II способ:\ \
$display(1/(x^2 + 1 )= 1/x^2 dot 1/(1+1/x^2) = 1/x^2 - 1/x^4 + 1/x^6 - 1/x^8 + dots)$ --- ряд Тейлора \ \
Проинтегрируем и получим:
$display(pi/2 - arctan x = 1/x - 1/(3x^3) + 1/(5 x^5) - dots)$\
#pagebreak()


= Ряды

//я открываю для себя #strike()[чужие гитхабы] новые главы // открыты для #strike()[код-ревью от Корнеева] изучения
#align(center)[$(a_k)$ --- вещественная последовательность\ \ $a_1 + a_2 + a_3 + dots $ --- ряд]\
#align(center)[$sum_(k=1)^(+infinity) a_k$ --- ряд в другой записи] \
#align(center)[$forall n space S_n = a_1 + a_2 + dots + a_n$ --- частичная сумма ряда]\
Рассмотрим предел:
$ lim_(n->=infinity) S_n $
Если предел существует и равен $S in overline(RR)$, то $S$ --- сумма ряда\

- $S in RR:$ ряд сходится

- $S in {-infinity; +infinity}:$ ряд расходится\

Если предел не существует, то ряд расходится\ \
*Замечание:*\ #v(0.3cm)
$S_n - S_(n-1) = a_n$
\ \
*Примеры рядов:*\ #v(0.3cm)
+ Ряд, состоящий из нулей: $sum_(k=1)^(+infinity) 0 = 0$ --- сходится к 0  #v(0.3cm)
  Ряд, состоящий из единиц: $sum_(k=1)^(+infinity) 1 = +infinity$ --- расходится #v(0.3cm)
  Ряд, состоящий из чередующихся единиц и минус единиц: $sum_(k=0)^(+infinity) (-1)^k$ --- расходится\  \

+  Геометрическая последовательность:  $sum_(k=0)^(+infinity) q^k = 1/(1-q) quad abs(q) < 1$\ #v(0.3cm)
  $S_n = 1 + q + q^2 + dots + q^n = (q^(n+1) - 1)/(q-1) -->_(n->+infinity) 1/(1-q)$\ \

+  $1 + 1/1! + 1/2! + dots = e$\ #v(0.3cm)
   $sum_(k=0)^(+infinity) 1/k! x^k = e^x$ --- чтобы это доказать распишем формулу Тейлора для
   $e^x$ в $x_0 = 0:$\ #v(0.3cm)
   #align(right)[$e^x = sum_(k=0)^n display(1/k! x^k + underbracket(e^c/(n+1)! x^(n+1), ->0))$]

+  $sum_(k=1)^(+infinity) 1/(k^alpha), quad alpha > 0$\ #v(0.3cm)
  $sum_(k = 1)^(+infinity) 1/k^alpha = 1/(1-alpha) (1/(n^(alpha - 1)) - 1) + 1/2 dot 1/n^alpha + 1/2 + underbracket(O(max(1, dots)), = O(1))$\ #v(0.3cm)
   При $alpha <= 1 quad$ ряд расходится\ #v(0.2cm)
   При $alpha > 1$ ряд сходится\ #v(0.2cm)

#columns(2)[
#def $n$-й остаток ряда\ #v(0.3cm)
$sum_(k=n)^(+infinity)$ --- $n$-й остаток ряда\ \
#colbreak()
_Соглашение:_ \ 
$sum a_k$ --- будем называть рядом $A$\ 
$sum b_k$ --- будем называть рядом $B$
]
*Свойства:*\

- $sum a_k, space sum b_k, space c_n = a_n + b_n => sum c_k = sum a_k + sum b_k$

- $sum a_k$ сходится, $lambda in RR$ Тогда $sum_(k=1)^n lambda a_k$ сходится, $sum lambda a_k = lambda sum a_k$
- 

  - $sum a_k$ сх $=>$ любой остаток тоже сходится
  
  - Если $k$-й остаток ряда сходится $=>$ сам ряд сходится
  - $r_n = sum_(k=n)^(+infinity) a_n, space $ ряд сходится $<=> r_n -> 0$\ #v(0.3cm)
    #proof
    а) ($m$-й ост.) $n > m$\ #v(0.3cm)
      $sum_(k=1)^n a_k = sum_(k=1)^m a_k + sum_(k=m+1)^n a_k$\ #v(0.3cm)
      $sum_(k=1)^(+infinity) a_k = sum_(k=1)^m a_k + sum_(k=m+1)^(+infinity) a_k$\ #v(0.3cm)
      
    б) Очевидно\ #v(0.3cm)
    в) $=>: sum_(k=1)^(+infinity) a_k = limits(S_m)_(->sum_(k=1)^(+infinity) a_k) + limits(r_(m+1))_(->0)$\ #v(0.3cm)
    #h(0.4cm) $arrow.l.double:$ тривиально
\
#columns(3)[
#strike()[*нано*]#th (_о граблях_):\ #v(0.3cm)
$sum a_n$ --- сходится, тогда $a_n ->0$
#colbreak()
#proof #v(0.3cm)
$a_n = S_n - S_(n-1) -->_(n->+infinity) 0$
#colbreak()
*Пример:*\ #v(0.3cm)
$alpha in (0, pi): sum sin n alpha$ --- расх, т.к. \ #v(0.3cm) #h(2.4cm)$sin n alpha arrow.not_(n->+infinity) 0$]
*Грабли:*\ #v(0.3cm) $sum 1/n, quad 1/n ->0 quad$ _Значит, эээ..., ничего, показалось._\ \
// кста не гуглится
//грабли
//а ну кажется очев. это личный термин Кохася
\ 
*Критерий Больцано-Коши:* \ #v(0.3cm) ряд сходится $<=> forall epsilon > 0 quad exists N: forall n > N quad forall m in NN quad abs(S_n - S_(n+m)) < epsilon$\ #v(0.3cm)
#h(2.15cm) $abs(a_(n+1) + a_(n+2) + dots + a_(n+m)) < epsilon$\ #v(0.3cm)
ряд расходится $<=> exists epsilon > 0: forall N quad exists n > N, exists m: abs(a_(n+1) + a_(n+2) + dots + a_(n+m)) >= epsilon$
\ #v(0.3cm)
#h(0.0cm) *Пример:*\ #v(0.3cm) $1/(n+1) + 1/(n+2) + dots + 1/(n+n) >= n dot 1/(2n) = 1/2$\ #v(0.3cm)
$sum_(k=1)^n 1/(n+k) = sum 1/n dot 1/(1+k/n) -> int_0^1 1/(1+x) dif x = ln(1+x) pole(0, 1) = ln 2$\ #v(0.2cm)
Здесь мы воспользовались суммами Риманна: $sum 1/n f(k/n) -> int_0^1 f(x) dif x$

= Сходимость неотрицательных рядов
#lm\ #v(0.2cm)
$a_n >= 0$. Тогда $sum a_n$ --- сходится $<=> S_n^((a))$ --- ограничена #v(0.2cm)
#proof #v(0.2cm)
$S_n^((a)) = sum_(k=1)^n a_k$ --- возрастает\
$S_n$ --- ограничена и монотонна $=> exists$ кон $lim S_n$\
$ exists$ кон $lim S_n => S_n$ --- ограничена.  
\ \
#th (_признак сравнения_)\  #v(0.2cm)
$forall a_k, forall b_k, quad a_k, b_k >= 0$\ #v(0.2cm)
+ $forall n quad a_n <= b_n$ (или даже $forall k > 0: forall n quad a_n <= k b_n$)\  #v(0.2cm)
  Тогда $display(cases(sum b_k "сх" => sum a_k "сх", sum a_k "расх" => sum b_k "расх")) quad (*)$  #v(0.2cm)
+ Пусть $lim_(n->+infinity) a_n/b_n = l in [0, +infinity)$\  #v(0.2cm)
  - $0 < l < infinity quad sum a_k$ сх $<=> sum b_k$ сх\  #v(0.2cm)
  - $l = 0 quad "выполняется " (*)$\  #v(0.2cm)
  - $l = +infinity quad display(cases(sum a_k "сх" => sum b_k "сх", sum b_k "расх" => sum a_k "расх"))$  #v(0.2cm)
// Эталонные ряды:\
// $sum 1/n^alpha quad display(cases(alpha > 1 &quad "сх", alpha <= 1 &quad "расх"))$\ \
// $sum q^n quad display(cases(0 < q > 1 &quad "сх", q >= 1 &quad "расх"))$\
// Попытаемся заменить на эквивалентный ряд:\
// $sum_(n=1)^(+infinity) (sqrt(n) arctan n)/(n^2 + sin^2 n)$\
// $a_n tilde (c sqrt(n))/n^2 = c/n^1.5$
+ Пусть начиная с некоторого места $(exists N_0 quad forall n > N_0)$ $a_(n+1)/a_n <= b_(n+1)/b_n$\
  Тогда выполняется $(*)$
#proof
+ $S_n^((a)) <= S_n^((b))$ при всех $n quad (S_n^((a)) <= k S_n^((b)))$\  #v(0.2cm)
  - $sum b_n$ сх $=> S_n^((b))$ огр $=> S_n^((a))$ огр $=> sum a_n$ сх\  #v(0.2cm)
  - $sum a_n$ расх $=> S_n^((a))$ --- не огр $=> S_n^((b))$ --- не огр $=> sum b_n$ --- расх
  *Замечание:* Можно быдо бы в условии $a_n <= b_n$ начиная с некоторого места \
  *Соглашение:* фразу "начиная с некоторого места" будем обозначать абривеатурой НСНМ
  #v(0.2cm)
+ $l in (0, +infinity):$\  #v(0.2cm)
  - Для $epsilon = l/2 quad exists N: forall n > N: quad 0 < l/2 < a_n/b_n < 3/2 l space <=>  space a_n < 3/2 l b_n,space b_n < 2/l l a_n$ \ #v(0.2cm)
    Теперь использую первое утверждение мы получаем что $sum a_k$ сх $<=> sum b_k$ сх#v(0.2cm)
  - $l = +infinity:$\ #v(0.2cm)
    $exists N: forall n > N quad a_n/b_n > 1 =>a_n > b_n$ --- здесь опять используем первое утверждение и победа\ #v(0.2cm)
  - $l = 0:$\ #v(0.2cm)
    $exists N: forall n > N quad a_n/b_n < 1$ --- аналогично предыдущему пункту #v(0.2cm)
+ Пишем неравенства при $n = N_0 + 1, n + 1, dots, n+k-1:$\ #v(0.2cm)
  $display(cases(reverse:#true,
a_(n+1)/a_n <= b_(n+1)/b_n,
a_(n+2)/a_(n+1) <= b_(n+2)/b_(n+1),
dots,
a_(n+k)/a_(n+k-1) <= b_(n+k)/b_(n+k-1)
)) => ^("перемножаем") space a_(n+k)/a_n <= b_(n+k)/b_n => a_(n+k) <= a_n/b_n b_(n+k)$ --- выполено замечание к I пункту\ \ \
*Пример:*\  #v(0.2cm)
*Эталонные ряды:*\  #v(0.2cm)
#box(stroke: 1pt, inset: 7pt, $sum 1/n^alpha quad display(cases(alpha > 1 &quad "сх", alpha <= 1 &quad "расх"))$+"\n\n"+ $sum q^n quad display(cases(0 < q > 1 &quad "сх", q >= 1 &quad "расх"))$)
#v(0.4cm)
- Исследуем $sum_(k=1)^(+infinity) k^2024 e^(-k)$\  #v(0.2cm)
  Попробуем доказать, что $k^2024 e^(-k) < 1/k^2$ при больших $k$\ #v(0.2cm)
  То есть нужно проверить (после домножения на $k^2$): $display(k^2026/e^k < 1?)$\ #v(0.2cm)
  $lim k^2026/e^k = (lim k/e^(k/2026))^2026 =^"Лопиталь" (lim 1/e^(k/2026) 2026)^2026 = 0 =>$ НСНМ то что мы пытались доказать верно.  #v(0.2cm)
  Теперь исползьуем первый пункт предыдущей теоремы и первый эталонный ряд --- победа\ \
- $sum_(k=1)^(+infinity) e^(-sqrt(k))$\ #v(0.2cm)
  Перепишем эталоны:\  #v(0.2cm)
  $sum e^(-alpha ln k), sum e^(k ln q)$\  #v(0.2cm)
  НСНМ $e^(-sqrt(k)) < 1/k^2 <=> e^overbrace(-sqrt(k) + 2 ln k, ->-infinity) < 1$. Числитель стремится к бесконечности, т.к.
  $lim sqrt(k)/(ln k) = +infinity$\  #v(0.2cm)
  Используем то же что и в предыдущем пункте --- победа\ \
#th (_признак Коши_)\ 
$sum a_n, space a_n >= 0, quad K_n := root(n, a_n)$\  #v(0.2cm)
*light:* #v(0.1cm)
+ $exists space q < 1 quad K_n <= q space $ НСНМ, тогда $sum a_n $ сх #v(0.2cm)
+ $K_n >= 1$ для беск. мн-ва $n$, тогда $sum a_n$ расх
*pro:* #v(0.1cm)
$K := limsup K_n = limsup root(n, a_n)$\  #v(0.2cm)
+ $K > 1 quad sum a_n$ расх #v(0.2cm)
+ $K < 1 quad sum a-n$ сх
*Замечание:* Для рядов $sum 1/n, sum 1/n^2 quad K = lim root(n, 1/n) = 1$,  но при этом первый ряд расходится, а второй сходится
$=> "при" K = 1$ признак не работает   #v(0.2cm)
#proof
+
  + $K_n <= q => root(n, a_n) <= q => a_n <= q^n "а значит" space  sum limits(q^n)_((q < 1))$ сх $=> sum a_n$ сх  #v(0.2cm)
  + $K_n >= 1 quad a_n >= 1$ для беск мн-ва номеров $=> a_n arrow.not 0 =>$ расходится  #v(0.3cm)
+
  + $K > 1 quad limsup K_n > 1 => exists$ беск много $n: K_n > 1$ (техн. описание верхнего предела) $ =>  #v(0.2cm) sum a_n$ расх   #v(0.2cm)
  + $K < 1 quad exists N_0: forall n > N_0 quad K_n <= q$,  где $q in (k, 1)$ --- тоже техн. описание верхнего предела.   #v(0.2cm)
*Пример:*\  #v(0.2cm)
$sum k^2024 e^(-k)$\ \
$root(k, k^2024 e^(-k)) = k^(2024/k) 1/e = underbrace(e^(2024/k ln k), -> 1) 1/e -> 1/e < 1$\ \
#th (_признак Д'Аламбера_)\  #v(0.2cm)
$sum a_n, a_n > 0 quad D_n := a_(n+1)/a_n$\  #v(0.2cm)
*light:*\  #v(0.2cm)
+ $exists space q < 1 quad D_n <= q space$ НСНМ. Тогда $sum a_n$ сх  #v(0.2cm)
+ $D_n >= 1$ НСНМ. Тогда $sum a_n$ расх #v(0.2cm)
*pro:* Пусть $exists lim_(n->+infinity) D_n = D$ #v(0.2cm)
+ $D < 1 quad sum a_n$ сх #v(0.2cm)
+ $D > 1 quad sum a_n$ расх #v(0.2cm)
*Замечание:* $sum 1/n, sum 1/n^2 quad D=1 frown$\  #v(0.3cm)
#proof
+
  + НСНМ $a_(n+1)/a_n <= q quad a_(n+1) <= q a_n$\
  $display(cases(reverse:#true, a_(n+1) <= q a_n,
  a_(n+2) <= q a_(n+1),
  dots.v,
  a_(n+k) <= q a_(n+k - 1))) => a_(n+k) <= q^k a_n => sum_(k=1)^(+infinity) a_(n+k)$ --- сходится\
  
  2. НСНМ $a_(n+1) >= a_n$, т.е. $a_n arrow.not 0$ --- расходится #v(0.3cm)
+
  + $D < 1 quad$ НСНМ $D_n <= q <1 => sum a_n$ сх ---  первый пункт light  #v(0.2cm)
  + $D > 1 quad$ НСНМ $D_n >= 1 => sum a_n$ расх --- второй пункт light #v(0.2cm)

  
*Пример:*  #v(0.2cm)
- $sum k^2024 e^(-k)$\  #v(0.2cm)
  $lim ((k+1)^2024 e^(-(k+1)))/(k^2024 e^(-k)) = 1/e < 1$\  #v(0.3cm)
- $sum e^(-sqrt(k))$\ #v(0.2cm)
  $e^(-1/sqrt(k)) -> 1$\ \
= Функциональные последовательности и ряды. Равномерная сходимость последовательности функций
#def поточечная сходимость\ #v(0.2cm)
$f_n, f_0: E subset X --> RR$\ #v(0.2cm)
Последовательность $f_n$ сходится поточечно на $E$ к $f_0$\ #v(0.2cm)
$f_n -->_(n->+infinity) f_0$ на $E <=> forall x in E quad lim_(n->+infinity) f_n (x) = f_0 (x)$\ #v(0.2cm)
$forall x in E quad forall epsilon > 0 quad exists N: forall n > N quad abs(f_n (x) - f_0 (x)) <epsilon$\ #v(0.2cm)
*Пример:*\  #v(0.2cm)
+ $f_n: [0, +infinity) --> RR, quad f_n (x) = x^n/n$\  #v(0.2cm)
  Если $E subset (0, 1] quad f_n (x) -> f_0 (x) equiv 0$ на мн-ве $E$\ #v(0.2cm)
  Если же $E sect (1, +infinity) != emptyset =>$ поточечной сходимости нет т.к. значения $f_n ->_(n, x->+infinity) + infinity$#v(0.2cm)
+ $f_n (x) = (n^alpha x)/(1+n^2 x^2), quad 0 < alpha < 2, x in [0, 1]$\  #v(0.2cm)
  при $x in [0, 1] quad f_n (x) -> f_0 (x) equiv 0$\  #v(0.2cm)
  $wink max f_n = ? quad f'_n = n^alpha (1 + n^2 x^2 - x n^2 2x)/((1 +n^2 x^2)^2) = 0 => n^2 x^2 = 1 => x = 1/n$\  #v(0.2cm)
  $max f_n = f_n (1/n) = (n^alpha 1/n)/(1+1) = n^(alpha-1)/2 -->^(alpha > 1)_(n->+infinity) +infinity$
#columns()[#image("24.png", width: 50%)
#colbreak()
Итого мы получили последовательнсоть фукнций которая поточечно сходиться к тождественному 0, но при этом при $n-> +infinity$ её максимальное значение $->+infinity$.\
Почему она поточечно сходитсья?\
С точки зрения графика джля каждой точки будем ждать когда $n$ станет настолько большим, что этот "гребень" окажется сильно левее нее, а значение соответственно в нашей точке будет стремится к 0.
]\
#def равномерная сходимость\ #v(0.2cm)
$f, f_n: X --> RR, E subset X$\ #v(0.2cm)
$f_n$ равномерно сх-ся к $f$ на мн-ве $E$, обозначается:$ space f_n arrows_(n->+infinity) f$ на мн-ве $E$\  #v(0.1cm)
$M_n := sup_(x in E) abs(f_n (x) - f(x)) -->_(n->+infinity) 0$\ #v(0.2cm)
$forall epsilon > 0 quad exists N = N(epsilon): forall n > N quad forall x in E quad abs(f_n (x) - f(x)) <= epsilon$\ #v(0.4cm)
*Замечание:* Если $f_n arrows f$ на $E$, то $forall x in E quad f_n (x) -> f(x)$, т.е. $f_n -> f$ поточечно\ #v(0.4cm)
*Пример:*\ #v(0.2cm)
+ $f_n: [0, +infinity) --> RR, quad f_n (x) = x^n/n$\ #v(0.2cm)
  Мы уже выяснили, что: $E subset (0, 1] quad f_n (x) -> f_0 (x) equiv 0$ на мн-ве $E$\ #v(0.2cm)
  Проверим, есть ли равномерная сходимость: $ f_n arrows^? f_0 equiv 0$\ #v(0.2cm)
  $M_n := limits(sup)_(x in E) x^n/n <= 1/n -> 0 =>f_n arrows f_0 equiv 0 $\ #v(0.2cm)
 
+ $f_n (x) = (n^alpha x)/(1+n^2 x^2), quad 0 < alpha < 2, x in [0, 1]$\ #v(0.2cm)
  при $x in [0, 1] quad f_n (x) -> f_0 (x) equiv 0$\ #v(0.2cm)
  Есть ли равномерная сходимость?\ #v(0.2cm)
  $M_n := display(limits(sup)_(x in [0, 1]) (n^alpha x)/(1+n^2 x^2) = n^(alpha-1)/2) => display(cases(alpha >= 1 => M_n arrow.not 0 &quad "нет равномерной сходимости", alpha < 1 &quad "есть равномерная сходимость"))$\ #v(0.2cm)

#columns(2)[
#image("25.png", width: 60%)
#colbreak()
#image("26.png", width: 60%)
]\ 
*Замечание:* $f_n arrows f$ на $E, E_0 subset E$ Тогда $f_n arrows f$ на $E_0$\ #v(0.2cm)
*Замечание:* $cal(F) = {f : X --> RR, f "огр"}$\ #v(0.2cm)
$f_1, f_2 in cal(F) quad rho(f_1, f_2) = limits(sup)_X abs(f_1 - f_2)$ --- это метрика #v(0.2cm)
+ $rho >= 0, rho = 0 <=> f_1 = f_2$ --- очевидно #v(0.2cm)
+ $rho(f_1, f_2) = rho(f_2, f_1)$ --- очевидно #v(0.2cm)
+ $rho(f_1, f_2) <= rho(f_1, f_3) + rho(f_2, f_3)$ #v(0.2cm)
  #proof
  Напишем определение $sup$: #v(0.2cm)
  $forall epsilon > 0 quad exists x: underline(rho(f_1, f_2) - epsilon) <= abs(f_1 (x) - f_2 (x)) <= abs(f_1 (x) - f_3 (x)) + abs(f_3 (x) - f_2 (x)) <= underline(rho(f_1, f_2) + rho(f_3, f_2))$ #v(0.2cm)
  Получили ровно то, что хотели: $rho(f_1, f_2) <= rho(f_1, f_3) + rho(f_2, f_3) + epsilon$ \ \
#th (_Стокса-Зайделя_)\  #v(0.2cm)
$f_0, f_n: X --> RR, X$ --- МП, $c in X, f_n$ непр в точке $c$, $f_n arrows f_0$ на $X$, тогда $f_0$ непр в точке $c$ #v(0.3cm)
#proof #v(0.2cm)
$abs(f_0 (x) - f_0 (c)) <= ["берём любое " n] <= underbrace(abs(f_0 (x) - f_n (x)), <epsilon  "по" (*)) + abs(f_n (x) - f_n (c)) + underbrace(abs(f_n (c) - f_0 (c)), <epsilon "по" (*)) <=^? 3epsilon$\ #v(0.1cm)
Только что сверху мы дважды написали неравенство треугольника / одно неравенство ломаной, кому как удобнее
 #v(0.2cm)
$f_n arrows f_0: forall epsilon > 0 quad exists N: forall n > N quad sup abs(f_n (x) - f_0 (x)) < epsilon quad (*)$\ #v(0.2cm)
Фиксируем любое такое $n$\ #v(0.2cm)
$f_n$ непрерывна $ <=> forall epsilon > 0 quad exists U(c): forall x in U(c) quad abs(f_n (x) - f_n (c)) < epsilon$\ #v(0.2cm)
Подставим это в неравенство с ? которое мы хотелипрвоерить: #v(0.2cm)
$forall epsilon > 0 quad exists U(c): forall x in U(c) quad abs(f_n (x) - f_n (c)) <= 3epsilon$ --- непрерывность $f_0$ в точке $c$\ \
#cor()\ #v(0.2cm)
$f_n in C(X), f_n arrows f_0$ Тогда $f_0 in C(X)$\ \
*Замечание:*\ #v(0.2cm)
+ Теорема верна в топологическом пространстве с тем же доказательством
+ Для непрерывности $f_0$ в точке $c$ достаточно иметь равномерную сходимость: $f_n arrows f$ на $V(c)$\ \

*Пример:* #v(0.2cm)
$f_n (x) = x^n quad x in (0, 1) quad f_n (x) -> f_0 equiv 0$\ #v(0.2cm)
$f_n arrows f_0? quad limits(sup)_(x in (0, 1)) x^n= 1 arrow.not 0$, нет равномерной сх-сти\
*Но!*
#columns(2)[
#image("27.png")
  #colbreak()
$limits(sup)_(x in (alpha, beta)) abs(f_n - f_0) = sup x^n = beta^n -->_(n -> +infinity) 0$\ \ т.е. в каждой точке кроме 1 есть равномерная сходимость на ее окрестности\ \
]\ \
*Пример:* #v(0.2cm)
Пусть $X = K$ --- компактно, $f_1, f_2 in C(K)$\  #v(0.2cm)
$M_n := limits(sup)_(x in X) abs(f_1 (x) - f_2(x)) = max abs(f_1 (x) - f_2 (x))$ --- чебышёвское расст.\ \
#th\ #v(0.1cm)
$K$ --- компакт, для $f_1, f_2 in C(K) quad rho(f_1, f_2) = max abs(f_1-f_2)$ --- метрика на $C(K)$. Тогда $C(K)$ --- полное МП #v(0.3cm)
#proof
Берём фунд. посл. в $C(K) quad (f_n)$\  #v(0.2cm)
$forall epsilon > 0 quad exists N: forall n, m > N quad limits(max)_(x in K) abs(f_n (x) - f_m (x)) < epsilon$\ #v(0.2cm)
Заметим, что $forall x_0$ посл. $f_n (x_0)$ --- фунд. числ. посл. $=> forall x_0 quad exists lim f_n (x_0) = f_0 (x_0)$\ #v(0.2cm)
Итого мы получили: $exists f_0: f_n -> f_0$ поточечно на $X$\
// метод имитации двоечника
\
? Почему $f_0 in C(K)$ и $f_n arrows f_0$?\ #v(0.2cm)
$forall epsilon > 0 quad exists N: forall n, m > N quad forall x in K quad abs(f_n (x) - f_m (x)) < epsilon$ --- в силу фундаментальности $f_n (x)$\ #v(0.2cm)
Устремим в этой формуле $m$ к  $+infinity:$ #v(0.2cm)
$f_m (x) ->_(m ->+infinity) f_0 (x) => $ при 
$ m -> +infinity "формула перепишется так":$ #v(0.2cm)
$ forall epsilon > 0 quad exists N: forall n > N quad limits(max)_(x in K) abs(f_n (x) - f_0 (x)) <= epsilon$\ #v(0.2cm)
Ну а это как раз и означает, что 
$rho(f_n, f_0) -> 0 => f_n arrows f_0$ и тогда $f_0 in C(K)$ (по т. Стокса-Зайделя)

// теоропрос в конце 2 пары ))))
// у нас всё ещё есть проблемы с красивыми рисунками?
#pagebreak()
= Предельный переход под знаком интеграла
*Хотим сформулировать теорему:*\ #v(0.2cm)
Некоторые функции $f_n (x) -> f_0(x)$\ #v(0.2cm)
Тогда $ int_a^b f_n (x) -> int_a^b f_0 (x) $
*Антипример:*\ #v(0.2cm) $f_n (x) = n x^(n-1) (1-x^n) quad x in [0, 1]$\ \
$lim_(n->+infinity) f_n (x) = f_0 (x) equiv 0$\ #v(0.2cm)

$ int_0^1 n x^(n-1) (1-x^n) dif x= [t = x^n] = int_0^1 1-t dif t = 1/2 $ 
Функции стремятся к 0, но интеграл равен $1/2 =>$
Желаемой теоремы не существует
$ lim (int_a^b f_n (x) dif x) != int_a^b (lim f_n (x)) dif x $
\ \
#th Предельный переход под знаком интеграла \ #v(0.2cm)
$f_n, f in C[a, b], quad f_n arrows f$ на $[a, b]$\ 
$ int_a^b f_n -> int_a^b f $
#proof #v(0.2cm)
Тривиально. $ abs(int_a^b f_n - int_a^b f) <= int_a^b abs(f_n - f) dif x <= (b - a) limits(sup)_([a, b]) abs(f_n - f) -> 0 $
\ \

#cor() (правило Лейбница: дифференцирование интеграла по параметру) #v(0.2cm)

$f: [a, b] times [c, d] -> RR$ --- непрерывна на $[a, b] times [c, d]$
$ forall x, y: exists f'_y (x, y) = lim_(h->0) (f(x, y+h) - f(x, y))/h $ /*--- непрерывна на $[a, b] times [c, d]$ */ //зач дублированно // хз
$Phi(y) = int_a^b f(x, y) dif x. "Тогда" Phi "дифференцируема на" [c, d]:\  Phi'(y) = int_a^b f'_y (x, y) dif x $ // wtf
// Phi-нальная #emoji.face.cool
\ \
#proof
$ (Phi(y + h) - Phi(y)) / h = int_a^b (f(x, y+h) - f(x, y)) / h dif x = int_a^b f'_y (x, y + theta h) dif x \  theta in (0, 1), space theta = theta(x, y)  $
(В последнем равенстве нами была использована теорема Лагранжа)  #v(0.2cm)

Хотим в этой формуле считать $lim_(h->0)$. Будем делать это по Гейне, $h_n -> 0$\ #v(0.2cm)

Проверим, что $f'_y (x, y + theta h_n) arrows_(n -> +infinity) f'_y (x, y)$ равномерно по $x in [a, b]$\ #v(0.2cm)
Т.е. $limits(sup)_(x in [a, b]) abs(f'_y (x, y + theta h_n) - f'_y (x, y)) arrow.dashed_(n->+infinity) 0$\ #v(0.2cm)
Знаем: $f'_y$ ---  непрерывно на $[a,b] times [c, d] space ("компакт") =>$
$f'_y$ --- равномерно непрерывно:\ #v(0.2cm)
$ forall epsilon > 0 space exists delta > 0 space attach(forall, tr: (x, y), br:(x_1, y_1)) space rho((x, y), (x_1, y_1)) < delta: abs(f'_y (x, y) - f'_y (x_1, y_1)) <epsilon $//\ #v(0.2cm)
Используем это чтобы проверить что предел действительно 0:
$ forall epsilon > 0 space ["текст" (*)] space  forall n > N quad forall x, forall y quad abs(f'_y (x, y + theta h_n) - f'_y (x, y)) < epsilon $
$(*): h_n -> 0 => exists N: forall n > N quad abs(h_n) < delta$ --- из определения равн. непр.\ \
Это победа, предел действительно 0!\ \
Итак: $ display(lim_(n->+infinity) (Phi(y+h) - Phi(y))/h_n = lim_(n->+infinity) int_a^b f'_y (x, y + theta h_n) dif x = int_a^b f'_y (x, y) dif x) $
\ \
*Хотим предельный переход под знаком производной:*\ #v(0.2cm)
Возьмём функцию, стремящуюся к другой\ #v(0.2cm)
$f_n (x) -> f_0(x)$\ #v(0.2cm)
Продифференцируем: 
$f'_n (x) arrow.dashed^? f_0(x)$\ #v(0.4cm)
*Контрпример:*  #v(0.2cm)

$f_n (x) = x + 1/n sin (n^2024 dot x)$\ #v(0.4cm)
$f_n(x) arrows x$\ #v(0.4cm)
$f'_n ->^? 1$ \ #v(0.2cm)
НЕТ:
$f'_n (x) = 1 + underbrace(n^2023 dot cos(n^2024 x), frown)$\
\
#th (о предельном переходе под знаком производной)\ #v(0.2cm)
$f_n in C^1 (dp(a, b))$\ #v(0.2cm)

#columns(2)[
Пусть: \ #v(0.2cm) 
$f_n -> f_0 " на " dp(a, b)\ #v(0.2cm)
f'_n arrows phi " на " dp(a, b)$\ #v(0.2cm)
#colbreak()
Тогда:\ #v(0.2cm)

$f_0 in C^1(dp(a, b))$\ #v(0.2cm)

$f'_0 = phi$ на $dp(a, b)$
]
#line(length:17cm)
#columns(2)[
$quad space f_n -> f_0$\
$dif/(dif x) arrow.b quad quad arrow.b.dashed$\
$quad space f'_n arrows phi$
#colbreak()
$lim_(n->+infinity) (f'_n (x)) = (lim_(n->+infinity) f_n (x))'$
] #v(0.2cm)
#proof #v(0.2cm)
$x_0, x_1 in dp(a, b), quad f'_n arrows phi$ на $[x_0, x_1]$\ #v(0.4cm)

#columns(2)[
$ int_(x_0)^(x_1) f'_n (x) dif x quad space -->_(n->+infinity) int_(x_0)^x phi(x) dif x$\
$quad quad quad #rotate(90deg)[$=$]$\ #v(0.2cm)
$f_n (x_1) - f_n (x_0) -> f_0 (x_1) - f_0 (x_0)$\
#colbreak()
$int_(x_0)^(x_1) phi(x) dif x = f_0 (x_1) - f_0 (x_0)$\ #v(0.2cm) --- при всех $x_0, x_1 in dp(a, b)$\ #v(0.2cm)
По теореме Барроу: #v(0.2cm)
$=> f_0$ --- первообразная $phi$; $quad f'_0 = phi$
]
\ \
/*
Теорема Стокса-Зайдля - теорема 1\
Сегодняшняя теорема - теорема 2\
Правило Лейбница - теорема 3\
*/
/*$a_(n+1)/a_(n) <= b_(n+1)/b_n$\
*/

== Признак Раабе
$a_n > 0$\
+ НСНМ $space n (a_n/a_(n+1) - 1) >= r > 1 => sum a_n$ сходится

+ НСНМ $space n(a_n/a_(n+1) - 1) <= 1 => sum a_n$ расходится

#proof
2. \
Сравним ряды$space sum a_n$ и $limits(sum 1/n)_(=b_n)$\ #v(0.2cm)
$display(a_(n+1)/a_n >= (1/(n+1))/(1/n) <=> a_n/(a_(n+1)) <= (n+1)/n = 1 + 1/n <=> n (a_n/a_(n+1) - 1) <= 1 => a_n)$ --- большое, $b_n$ --- маленькое,\ #v(0.2cm)
$sum 1/n$ расх $=> sum a_n$ расх\ \
1. \
Пусть $1 < s < r$.\
Сравним ряды $sum a_n$ и $sum 1/n^s$\ \
$display(a_(n+1) / a_n <=^((?)) (1/(n+1)^s) / (1/n^s) <=> a_n/a_(n+1) >=^((?)) ((n+1) / n) ^s = (1 + 1/n)^s)$\ \
$display(cases(n(a_n / a_(n+1) - 1) >=^((?)) n (1 + 1/n) ^ s - 1 -->_(n->+infinity) s, "НСНМ" n (a_n/a_(n+1) - 1) >= r) =>)$
неравенство $(?)$ выполнено при больших n


#align(right)[т.е. ряд $sum a_n$ --- "маленький", $sum 1/n^s$ --- "большой" ($s > 1$)]\
\
#cor()\
$ a_n > 0: quad lim_(n -> +infinity) n ((a_n)/(a_n + 1) - 1) = r $
*Тогда:*

+ $r > 1: quad sum a_n$ --- сходится

+ $r < 1: quad sum a_n$ --- расходится\
\
*Упражнение:*\
Доказать, что:
$ sum_(n = 2)^(+infinity) 1/(n (ln n)^a) $
+ При $a > 1$ --- сходится

+ При $a <= 1$ --- расходится
\ \
#th интегральный признак Коши\ #v(0.2cm)
$f: [1, +infinity) -> [0, +infinity)$ ---  непр, монот\
*Тогда:* $ sum_(k=1)^(+infinity) f(k),space  int_1^(+infinity) f(x) dif x - "сх/расх одновременно" $\
#proof
Основной случай: $f arrow.b, f > 0$\

#columns(2)[
#align(center)[#image("28.png", width: 50%) $int_1^n f(x) d x >= sum_(k = 2)^n f(k)$]
#colbreak()
#align(center)[#image("29.png", width: 50%) $sum_(k = 1)^(n-1) >= int_1^n f(x) d x$]
]

$ int_1^n f = sum_(k = 1)^n int_(k - 1)^k f(x) d x >= sum_(k = 2)^n int_(k - 1)^k f(k) = sum_(k = 2)^n f(x) $
*Замечание:* можно требовать\
$ exists M quad forall x > M: f - "монотонна" $
\ 
*Следствие* из интегрального признака Коши:\
$ d/(d n) (1/(n (ln n)^a)) = -1/(n^2 (ln n)^a) - a/(n^2 (ln n)^(a+1)) $ 
\ \
#def абсолютная сходимость ряда\ #v(0.2cm)
$sum a_n$ --- абсолютно сходидтся, если $ sum a_n "сходится и"  sum abs(a_n) "сходится" $
\ \
*Пример:*\ #v(0.2cm)
$display(1/(1+x^2) = 1 - x^2 + x^4 - x^6 + dots + (-1)^n x^(2n) + ((-1)^(n+1) x^(2n+2))/(1+x^2))$\ #v(0.4cm)
Проинтегрируем от 0 до 1: #v(0.2cm)
$display(pi/4 = int_0^1 1/(1+x^2) dif x = 1 - 1/3 + 1/5 - 1/7 + dots + ((-1)^n)/(2n+1) + underbrace(int_0^1 ((-1)^(n+1) x^(2n+2))/(1+x^2) dif x, abs(int_0^1 dots arrow.t) <= int_0^1 x^(2n+2)/(1+x^2) dif x <= int_0^1 x^(2n+2) = 1/(2n+3)))$

Итог: $display(pi/4 = 1 - 1/3 + 1/5 - 1/7 + dots)$ (ф-ла Грегори-Лейбница)\
\
При этом абсолютной сходимости нет:
$sum 1/n$ --- расходится, поэтому $sum 1/(2 k )$ --- расходится, #v(0.2cm)
а $sum 1/(2k + 1) $ можно почленно оценить снизу  $sum 1/(2 k )$, а значит он тоже расходится 
\ \
*Объяснение для идиотов:*\ // для нас
Признак Раабе: \ #v(0.2cm)
$ display(n(1/(2n+1)/(1/(2n + 8)) - 1) = (2n) / (2n + 1) <= 1) - "расходится!" $
#quote("Если вы думаете так, то к вам не придраться, но вы полный идиот", attribution: "КПК", block: false)\
// #h(0cm) #emoji.face.cool
\ \
#th\ #v(0.2cm)
$forall$ ряда $sum a_n$ экв:

+ $sum a_n$ --- абс сх

+ $sum abs(a_n)$ --- сх
+ $sum a_n^+, sum a_n^-$ --- сх ($a_n^+ = max(a_n, 0), a_n^- = max(-a_n, 0)$)
\
#proof
Упражнение слушателям.

= Сходимость произвольных рядов
#th (_признак Лейбница_)\ #v(0.2cm)
$c_0 >= c_1 >= c_2 >= c_3 >= dots >= 0, c_n -> 0$\ #v(0.2cm)
Тогда $ sum (-1)^n c_n - "сх" $
_Секретное дополнение признака Лейбница:_
Если ряд сх., то $ forall N quad abs(sum_(k >= N) (-1)^k c_k) <= c_N $
// пойдет?
// ы, лан
// че не так, давай
// да норм
// че не так?
// ес че в геогебре нарисую
\
#columns(2)[
#image("30.png", width: 70%)
Доказательство сходимости ряда\
$(c_0 - c_1) + (c_2 - c_3) + (c_4 - c_5) + dots$
#colbreak()
$s_(2n-1) = (c_0 - c_1) + (c_2 - c_3) + (c_4 - c_5) + dots >= 0$\ #v(0.2cm)
$s_(2n+1) = s_(2n-1) + underbracket((c_(2n) - c_(2n+1)), >= 0) >= s_(2n-1)$\
$(s_(2n-1))$ --- возрастает\ #v(0.2cm)
$s_(2n-1)$ --- ограничено (за счет площади):\ #v(0.2cm)
$s_(2n-1) = c_0 - (c_1 - c_2) - (c_3-c_4) - dots - (c_(2n-3) - c_(2n-2)) - c_(2n-1) <= c_0$\ #v(0.2cm)
Значит $exists lim s_(2n - 1)$\ #v(0.2cm)
$limits(s_(2n), inline: #false)_(arrow.br s) = limits(s_(2n - 1), inline: #false)_(arrow.br s) + limits(c_(2n), inline: #false)_(arrow.br 0)$
]
\ \
*Ряд, для которого не работает признак Лейбница:*\ #v(0.2cm)
$ sum_(k = 2)^(+infinity) ((-1)^k)/(sqrt(k) + (-1)^k) $
Наш ряд $(-1)^k c_k, quad"где"  c_k = 1/(sqrt(k) + (-1)^k) >= 0$\ #v(0.2cm)
Монотонность?\
$k = 10^6 quad c_k = 1/1001$\
$k = 10^6 + 1 quad c_k approx 1/999$\ #v(0.2cm)
$k = 10^6 + 2 quad c_k approx 1/1001$\ #v(0.2cm)
$f(x)$ --- монотонности нет\ #v(0.2cm)
// [insert cursed drawing here]
НЕ РАБОТАЕТ
#frown\ \
$display(sum (-1)^k/sqrt(k))$ --- сходится по Лейбницу\ #v(0.4cm)
$display(a_k\, b_k > 0\, sum a_k\, sum b_k\, a_k tilde b_k => sum a_k\, sum b_k)$ сх одновр\ #v(0.4cm)
$display(sum_(k=2)^(+infinity) ((-1)^k)/(sqrt(k) + (-1)^k) - sum_(k=2)^(+infinity) ((-1)^k)/sqrt(k) = sum_(k=2)^(+infinity) ((-1)^k (-(-1)^k))/(sqrt(k) (sqrt(k) + (-1)^k)) = sum 1/(sqrt(k) (sqrt(k) + (-1)^k)))$\ #v(0.4cm)
$sum 1/k$ --- расх #frown\ #v(0.4cm)
Признак сравнения протух. 
\ \
*Преобразование Абеля: (суммирование по частям)*\ #v(0.2cm)
$sum_(k=1)^n a_k b_k = A_n b_n + sum_(k=1)^(n-1) (b_k - b_(k+1)) A_k$\  #v(0.2cm)
$A_k = a_1 + a_2 + dots + a_k <=> int f$ --- для аналогии с интегралами можно сделать такое сравнение\  #v(0.2cm)
$int f g = F(x) g(x) - int F(x) g'(x)$\
\ \ 
*Признак Дирихле* _(не про зайцев)_ и *признак Абеля:*\ #v(0.2cm)
Дан $sum a_k b_k$ #v(0.2cm)
+ (_Дирихле_) $A_n$ --- огр. посл-ть $(A_n = sum_(k=1)^n a_n)$, $b_n$ --- монот, $b_n -> 0$. Тогда $sum a_n b_n$ сх\

+ (_Абеля_) Ряд $sum a_n$ сх, $b_n$ --- монот, огр. Тогда $sum a_n b_n$ сходится
\ 
#proof
+ $A_n$ --- огр, $b_n -> 0 => A_n b_n -> 0, exists c_A: abs(A_n) <= C_A quad forall n$\ #v(0.2cm)
  Применим преобразование Абеля: $sum_(k=1)^n a_k b_k = underbracket(A_n b_n, -> 0) + sum_(k=1)^(n-1) (b_k - b_(k + 1)) A_k quad (*)$\ #v(0.2cm)
  $sum_(k=1)^(n-1) abs(b_k - b_(k+1)) abs(A_k) <= c_A sum_(k=1)^(n-1) abs(b_k - b_(k+1)) = plus.minus c_A sum_(k=1)^(n-1) b_k - b_(k+1) = plus.minus c_A (b_1 - b_n) <= 2 c_A c_B$\ #v(0.2cm)
  $b_n$ --- огр. $quad forall n space abs(b_n) <= c_B$\ #v(0.2cm)
  Значит, $sum_(k=1)^(+infinity) (b_k - b_(k+1)) A_k$ --- абс. сходящийся $=>$ он сходится $=>exists$ кон $lim_(n->+infinity) sum_(k=1)^(n-1) dots =>$ в $(*)$ всё сходится

+ $exists$ кон $lim_(n->+infinity) b_n = beta$\
  $sum_(k=1)^(+infinity) a_k b_k = underbracket(sum a_k beta, "сх") + underbracket(sum a_k (overbrace(b_k - beta, ->0)), "сх по Дирихле")$\
  $sum a_k$ сх $=> A_k$ --- огр
\ \

_Загадка._ $sum_(k=1)^(+infinity) (sin n)/n - ?$