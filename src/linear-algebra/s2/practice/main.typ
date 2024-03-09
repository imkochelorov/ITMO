#import "template.typ": *

#set page(margin: 0.55in, height: auto)
#set par(leading: 0.55em, first-line-indent: 0em)
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
  title: "Линейная алгебра\nII семестр",
  authors: (
    "_scarleteagle",
    "imkochelorov"
  ),
  date: "зима/весна 2024",
  subtitle: "Практик: 
  Мария Александровна Москаленко"
)

#let make = sym.supset.sq
#let see = $angle.spheric quad$
#let proof=par(strong("Доказательство:"))
#let sum=$limits(sum)$
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
/*
*Определение:* категория\ #v(0.2cm)
$"Cath" &-> "Obj" C \ &-> "Hom"C$

1. Определена композиция морфизмов\
  $"Hom"_C times "Hom"_C -> "Hom"_C$
2. Композиция морфизмов ассоциативна:\ #v(0.2cm)
  $forall A, B, C in "Obj"C quad exists "Hom"(A, B), "Hom"(B, C), "Hom"(A, C) => \ "Hom"(C, B) circle.small ( "Hom"(B, C) circle.small "Hom"(A, B)) = ("Hom"(C, B) circle.small "Hom"(B, C)) circle.small "Hom"(A, B)$
  
3. $exists ! id_B forall B in "Obj"C : "если" exists "Hom"_C (A, B) = f, "то" |id_B circle.small f| = f$
#align(center)[#image("2.png", width: 20%)]

#align(center)[#image("1.png", width: 15%) $f in "Hom"(A, B)$\ _если $g circle.small f = l circle.small h$, диаграмма коммутативна_]
/*
`
    f
 A --> B
 |     |
h|     |g 
 ∨     ∨
 D --> C
    l
`
*/
\ \
//#image("image.png")
$"Sets": exists F(S)$ --- функция на $S in "Sets"$ со знач. в $italic("Lin")_K$\ #v(0.2cm)
$"Sets" -->^F italic("Lin")_K$\ #v(0.4cm)
$V(KK) -->^(phi in "Hom"(cal("L")"in" KK))  V'(KK)$\
$space f arrow.b #h(1cm) arrow.l.dotted #h(1cm)arrow.b g$\
$#h(0.4cm)KK  #h(1cm)  phi*#h(1cm) KK$\
\
$g(phi(v)) in V^*$\
$g space circle.small space phi: V -> V' -> KK$\ #v(0.2cm)
$phi^* in "Obj" italic("Lin")_K^"op"$ #v(0.2cm)
$phi^*: V^* ' -> V^*$\  #v(0.2cm)

#align(center)[#image("3.png", width: 10%)]
*pull-back:* $phi^* (g) = g space  circle.small space phi$\ \

#align(center)[#image("4.png", width: 10%) _pull-back_: $phi^* (g)=g circle.small phi$]
*Утверждение:*\
$(T space circle.small space S)^* = S^* space circle.small space T^*$, где $T, S in "Hom" "Lin"_KK$\ #v(0.2cm)
$L -->^S M -->^T N$

#align(center)[#image("5.png", width: 25%) _доказательство_]

\ \
push-forward:\
$quad AA^1 -->^phi AA^2$\
$quad A_1 -->^phi A_2$\
$V_1 arrow.b dots.c arrow.dashed.r^phi^* space.hair arrow.b V_2$\
$quad A_1 dash dash dash dash A_2$\ \
$V_1: A_1 -> A_1$\
$v(a) = b => a + v = b | phi circle.tiny$\
$phi(a + v) = b'$\
$phi(a) + phi(v) = phi(a + v) = a' + v'$\
$phi(v) = v' = phi * v = dif phi (v)$\
$*$ --- push-forward \ \
$sum_mu v^mu e _mu equiv v^mu e_mu$ (более краткая запись)\
#quote("Не душите!", attribution: "Селеменчук", block: true)

//#image("image.png") // оставь так

Категория $D$
$f: underbrace(V^n times V^n times dots times V^n, "n штук") --> KK$
- Полилинейное\
  $v_1, dots, v_(n-1), v_n -> v_1, dots, v_(n-1) - v_n, v_(n-1) + v_n$
- Антисимметричность\
  $f(v_1, dots, v_i, dots, v_j, dots, v_n) = -f(v_1, dots, v_j, dots, v_i, dots, v_n)$

#th $forall phi in D => phi = c det$
#proof
Выберем базис ${e_mu} subset V^n, {v_i}_(i=1)^n subset V^n$\
$=> phi(v_1, dots, v_n) = phi(v_1^(mu_1) e_mu_1, dots, v_n^(nu_n) e_nu_n) = v^(mu_1) dots v^(mu_n) phi (e_mu_1, dots, e_mu_n)$\
$=overbrace(sum_(sigma in S_n\ sigma = (mu_1, dots, mu_n)) (-1)^P(mu_1, dots, mu_n) v^(mu_1) dots v^(mu_n), det) overbrace(phi(e_1, e_2, dots, e_n), c)$
//$underbrace(V^n times V^n times dots times V^n, n) -->^(phi_1, phi_2, phi_3, phi_4) KK$\

$V_, quad *^ V times V -> V$ --- алгебра

ДЗ: определение алгебры --- это $A$, являющееся и кольцом и $KK$ модулем $<=>$ вект. пространство с умножением на нём\
\
Free vector space composition\
$*: V times V -> V'$\
это универсальный объект в категории соответствующих отображений\
$v * v = v^mu e_mu * v^nu e_nu != v^mu v^nu (e_mu * e_nu)$\
$(v_1 * v_2) * v_3 != v_1 * (v_2 * v_3)$\
#def\
$(exists! zeta)$\
$G in "Obj" G'$ --- универсальный объект, если $forall A, B subset "Obj" C: eta in "Hom" (A, B), zeta in "Hom" (A, G) quad exists! phi in "Hom" (B, G):$ диаграмма ниже коммутативна\
$A ->^eta B$\
$quad arrow.br_zeta arrow.b.dashed phi$\
$quad quad G$\
ДЗ: доказать, что идеал:\
$R = <$$(u+v) * w - v times w - u times w,$\ $v * (omega + u) - v * w - v * u,$\ $(lambda v) * w - lambda dot v * w,$\ $u * (lambda w) - lambda dot u * w$\ $(v * u) + w - v * (u * w)>$

\ \ \
$(V * V * dots * V) -> A(V)$\
$A(V) in.rev T = sum_n V^(*n) = KK + V + V * V + dots + V * V * dots V + dots$\
$zeta in "Gr" (V), zeta = eta + zeta^i e_i + zeta^(i j) e_i times e_j$\
\
$T(V) = A(V) slash R$
\ \
$R arrow.hook A(V) -> A(V) slash R arrow.hook.l 0, R -> 0$\

#pagebreak()

$f$ --- гомоморфизмы абелевых групп\ #v(0.2cm)
$A$ --- абелевы группы\ #v(0.2cm)
$dots ->^(f_i) A_i ->^(f_(i+1)) A_(i+1) ->^(f_(i+2)) A_(i+2) ->^(f_(i+3)) dots$ --- комплекс, если:\ #v(0.2cm)
$f_(i+1) f_i = 0 <=> "Im" f_i subset.eq "Ker" f_(i+1)$\ #v(0.2cm)
Гомология комплекса: $limits(H_(i+1))_("i+1-я группа\nгомологии\nкомплекса") = "Ker" f_(i+1) slash "Im" f_i$ --- *ДЗ*: доказать что $H_i$ являются группами \  #v(0.2cm)
Точность в члене $A_(i+1) => "Im" f_(i+1) = "Ker" f_(i+2)$\
\
#ex\ #v(0.2cm)
$0 ->^g L ->^i M$ --- всегда комплекс\ #v(0.2cm)
$"Im" g subset.eq "Ker" i$
\ \
#proof
При гоморфизме нейтральный элемент переходит в нейтральный\ #v(0.2cm)
$make g^(-1)(l_1) = 0 => g^(-1)(-l_1) = 0$\
$=> 2 l_1 in "Ker"$\
\

Докажем, что $"Im" g = 0$\ #v(0.2cm)
$make l_1, l_2 in "Im" g => l_1 + l_2 in "Im" g$\ #v(0.2cm)
$=>$ либо $l_1 = -l_2$, либо $"Im" g = L$\ #v(0.2cm)
//1) $l_1 = l_2 -> l_1  != -l_2 => l_1 = -l_2$ по св-ву гомоморфизма-
$g(m dot m) = m_1 space circle.small space m_2 = m_2 space  circle.small space m_1 => m_1 space circle.small space  m_1 = m_2 space circle.small space  m_2 => m_1 = m_2$
// отображения были в первой или второй лекции матана?
// кажется в первой

// вообще то что говорит Антон называется "многозначное отображение"
// и это определяется как f: X -> 2^Y
// какой же он многознач(итель)ный
// бож что происходит
// происходит обобщение понятий из 1 сема
// можно оно будет на лекциях с лекторами и с нормальным обобщением, а не "ну я думал вы знаете, что такое отображение"
#quote("короче, доказали", attribution: "Селеменчук Антон", block: true)
#v(0.2cm)
Этот комплекс точен в $L$, если $"Ker" I = 0 => i$ --- инъекция\ #v(0.2cm)
#ex\
$M ->^i N ->^f 0$ --- комплекс\ #v(0.2cm)
$"Ker" f = N$ по св-ву гомоморфизма\
Этот комплекс точен в $N$, если $"Im" i = "Ker" f = N$, то есть $i$ сюръекция\
\ 
#ex "Точные тройки"\ #v(0.2cm)
$0 ->^g L ->^i M ->^f N -> 0$\
$#h(0.85cm)arrow.b #h(0.75cm)arrow.br$\
$#h(2.2cm)M slash L = M slash "Ker"f$\
$i^(-1) (M)=L_(arrow.b"Im" i)$\ \
$L subset M, space M slash L ==>_("если всё\nэто вект.\nпр-ва") dim M slash L = dim M - dim L$\ #v(0.2cm)
#def функтор
$F$ --- функтор из категории $C$ в $D$, если $&"Obj" D = F("Obj" C),space  &"Mor" D = F("Mor" C)$, \ #v(0.2cm) Но при этом $forall g, f in "Mor" C, exists g circle.small f => F(g circle.small f) = F(g) dot F(f)$ (ковариант)\ \ #v(0.2cm)
#def универсальный морфизм\
$make F: C -> D$ --- функтор (ков.)\ #v(0.2cm)
$X subset "Obj" D, space A,  space A' in "Obj" C, h in "Hom"_C (A, A')$\ #v(0.2cm)
$(A, u: X -> F(A))$ --- _универсальный морфизм_, если диаграмма коммутативна:
```
X --u-> F(A)            A
 \       v F(h) <--F--| v h
  \f--> F(A')           A'
```

Коммутативная диаграмма:
```
A --a--> B
 \       |  b
  \      v
   \-c-> C
```
$c = b circle.small a$

#quote("Да, мы можем натянуть. Так и говорим", attribution: "Селеменчук Антон Сергеевич", block: true)
//#quote("Я натягиваю", attribution: "Селеменчук Антон Сергеевич", block: true) // *vine boom*
// #quote("Ваня! Конспектируй, конспектируй!", attribution: "Цвей Лев", block: true)

$V * W --> K"-Vect"$

$K"-Vect" times K"-Vect" -> K"-Vect"$
\ \
$V times.circle W = V * W slash angle.l space (lambda_1 v) * (lambda_2 w) - lambda_2 lambda_1 (v * w)space angle.r$\ // ааааааааааааааааа 
#v(0.2cm)
$V times.circle W times.circle U = V * W * U slash angle.l space v * (w * u) - (v * w) * u space angle.r$

// как он теперь вместо отображения говорит? Соответствие? ага
#v(0.2cm)
$[a, b] = mat(delim: "|", i, j, k; a_1, a_2, a_3; b_1, b_2, b_3)$\ #v(0.2cm)
$[a, [b, c]] != [[a, b], c]$\ #v(0.2cm)
\ \
#def тензорная алгебра\
$KK$ --- это $RR$ или $CC$\
Тензорная алгебра --- $limits(T(V))_("по типу"\ KK[x]) = limits(sum)_(i = 0)^(+infinity) V^(times.circle i) = KK + V + V times.circle V + V times.circle V times.circle V + dots$
\ \ 
//#def (забывающий) функтор\
Возьмём (забывающий) функтор $u: K"-Alg" -> K"-Vect"$, $quad K"-Alg"$ --- ассоциативна\
и сопоставляем каждой алгебре её векторное пространство $A(V)$\ \
Тогда по произвольному $X in "Obj" ("K-Vect")$, построим $T(X)$\
($forall$ лин. отображение $X -> A in "K-Alg"$ может быть единственным образом, продолжено до гомоморфизма алгебр $T(X) -> A$)

```
  г-->
-U(X) --u--> T(X)
  \          |
   \         v ∃!h
    \--f---> A
```
// бля у меня просто голова плывёт уже
// same
// он написал 2 продолжения одного утверждения


$sigma = angle.l (v times.circle w - w times.circle v) times.circle t, t times.circle (v times.circle w - w times.circle v) angle.r$ --- двусторонний идеал?
$S(V) = T(V) slash sigma$\
$Lambda(V) = T(V) slash S$

$T(V) = sum_(i) V^(times.circle i)$\
Выберем некоторый базис ${e_i}_(i=1)^n subset V(KK)$\
$=> forall zeta in T(V) = zeta = zeta_0 + zeta^i e_i + zeta^(i j) e_i times.circle e_j + dots + zeta^(mu_1 dots mu_n) e_mu_1 times.circle dots times.circle e_mu_n + dots$\
${epsilon_p} subset V^(n times n)$\
$e_mu times.circle e_nu |-> epsilon_p$ --- линейное\
$zeta_[56] = -zeta_[65]$\
$zeta_(mu nu) = 1/2 (zeta_(mu nu) - zeta_(nu mu)) + 1/2 (zeta_(mu nu) + zeta_(nu mu))$
// самые долгие 5 минут
\
\
$"Mat"_(n times n) tilde.eq V^* times.circle V$

#pagebreak()

$make M, N, P$ --- ЛП над $K$\ #v(0.2cm)
Тогда $forall$ отображения (билин.) $M times N -> P$\ #v(0.2cm)
а) $exists (T, space g), space g: M times N -> T, space  f = f' apply g, space f'$ --- гомоморфизм (лин. отобр. $f': T -> P$)\ #v(0.2cm)
б) Если $(T, g)$ и $(T', g')$ --- пары со св-вом (а), то $exists! j: T -> T'$ --- изоморфизм, для кот. $j apply g = 'g$\
#rect($T = M tens N$)
#v(0.6cm)
#proof #v(0.2cm)
б) 1) Заменим $(P, space f)$ в пункте (а) на $(T', space g')$, тогда получим единственное отображение $j: T -> T'$, для которого $g' = j apply g$
2) Поменяем местами $T$ и $T' => exists! j': T' -> T$\
$=> g'=j' apply g', quad  j' apply j = j apply j' = id$

/*```
MxN -f-> P
 |       ^
 g       : ∃f'
 |       :
 +------>T
|
(P, f) <-> (T', g')
|
V
MxN -g'->T'
 |
 g
 |
 +
```*/

а) Мы уже знаем $underbracket(M * N, "своб. "K"-модуль"\ KK^((M, N))) = "Span"_K ((M, N)) => forall v in M * N => v = sum_i limits(alpha_i)_(in K) (x_i y_i)$\
Тогда по линейности $M * N => exists! overline(f): M * N -> P$\
$overline(f) (v) = overline(f) (sum_i alpha_i (x_i, y_i)) = sum_i alpha_i f(x_i, y_i)$
// а че версуса антона с трифановым не будет?
// хочешь стрим?  
// ? ты про что //наверное ответ да
```
MxN -f-> P
 |       ^∃!'f
 |       :
 +-------M*N=C
```
Теперь $make f$ --- билинейно, тогда напишем подпр-во $D = <(x+x', y) - (x,y), (x, y+y') - (x, y) - (x, y'), (a x, y) - a(x, y), (x, a y) - a(x, y)>$\
$D subset M * N$\
$overline(f)(D)=0$\
```
MxN -f-> P<- - -∃!h- - +
 |       ^∃!'f         |
 |       :             |
 +-------M*N=C ----> M*N/D=M⊗N
```
$overline(f)=h apply phi$\
$tau in M tens N => h(tau) = sum_(i, j) tau_(i j) f(x_i, y_j)$, потому что $h apply phi(v) = overline(f)(v)=sum_i alpha_i f(x_i, y_i)$\
#proof
```
MxN -f-> P
 |       ^∃!'f
 |       :
 +-------M*N=T=M*N/D
```
\ \
```
M--φ-->A - ассоц K-алг. с ед-ей
|      ^
|      | ∃! 'φ: 'φ(1_K) = 1_A
+-i--->T
```
$V tens V tens 1$\
#v(0.6cm)
// ай
$"Hom" (underbrace(V\, dots\, V, p), U) tilde.eq T^p (V^*)$\
пр-во (линейное) $p$-форм $V ->_p KK$
Задачи:\ #v(0.2cm)
+ Определить значение формы $phi = e^1 and e^2 and e^3 - 3e^1 and e^2 and e^4$\ #v(0.2cm)
  на векторах $x tilde.eq vec(1,1,0,0); y tilde.eq vec(1,2,3,0); z tilde.eq vec(0,0,2,5)$\

  // ЕБАТЬ
  // можно я уже уйду
  #image("image.png")
  // реально можно уйти,

// наконец-то
$phi = {phi^1, phi^2, phi^3}$\
$dim Lambda^k V^(*n)=C_n^k = binom(n, k)$\


$phi = e^1 and e^2 and e^3 - 3e^1 and e^2 and e^4 in Lambda^3 (V^(*4))$\
$f^1, f^2, f^3, f^4$\
$e^1 and e^2 and e^3 (vec(1,1,0,0), vec(1,2,3,0), vec(0,0,2,5))$\
$phi(x, y, z) = mat(delim: "|", 
1, 1, 0;
1, 2, 0;
0, 3, 2) - mat(delim: "|", 
3, 3, 0;
1, 2, 0;
0, 0, 5)=2-15=-13$

$e^1(x) = e^1(x^mu e_mu)$ --- вырезание 1-й компоненты из $x$\

#line(length: 50%)
$make theta$ --- 2-форма и $theta = e^1 and e^2 - 7 e^1 and e^3 + 2 e^2 and e^3$\
$make$ изв ф-лы перехода к нов базису:
- $e'_1=2e_1 + e_2 + e_3$
- $e'_2=e_1+e_2$
- $e'_3=e_3$
Найти форму в новом базисе\
$e^mu (e_nu) = delta^mu_nu$\
$e'^mu (e'_nu) = delta^mu_nu$\
$e'_nu = A^mu_nu e_mu$\
$e'^mu = B^mu_p e^p$\
$B^mu_p e^p (A^mu_nu e_mu) = delta^mu_nu$\
$B^mu_p A^mu_nu delta_mu^p = delta^mu_nu$\
$B^mu_p A^p_nu = delta^mu_nu$\
\ \
$mat(2,1,1;1,1,0;0,0,1)^(-1)$\ \

$mat(1,-1,-1;-1,2,1;0,0,1)=vec(e_1, e_2, e_3)$\
- $e_1 = e'_1 - e'_2-e'_3$
- $e_2=-e'_1+2e'_2+e'_3$
- $e_3=e'_3$

$theta = e^1 and e^2 - 7 e^1 and e^3 + 2 e^2 and e^3$\

#line(length:50%)
$omega^2 in Lambda^2 (RR^(2 n)), omega^2 = sum_(i=1)^n p_i and q_i$,\
где в $RR^(2n)$ выбрана СК $p_1, dots, p_n, q_1, dots, q_n$\
$omega^2 and omega^2 =?$\
$(sum_(i=1)^n p_i and q_i) and (sum_(j=1)^n p_j and q_j)$\
$sum_(i=1)^n sum_(j=1)^n (p_i and p_j and q_i and q_j)$\
$-2 sum_(i=1)^n sum_(j=i+1)^n (p_i and p_j and q_i and q_j)$

#pagebreak()
*/

// `ПО БЕ ДА
// БЕ БЕ ДА
// ДА ДА ДА`

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
== Свёртка индексов:\ \
$ A = display(mat(augment: #(hline: 2, vline: 2),
1, 2,  3, 4;
-4, -3,  -2, -1;
-4, -3,  -2, -1;
5, 6,  7, 8)) = ||a^(i j)_(k l)|| $\ \ 
#align(center)[_i --- локальная строка, j --- локальный столбец, k --- глобальная строка, l --- глобальный стобец_] // я понял по 3 дефиса
\ \
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
*Тензорное произведение:*\ \
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

*Следующий пример:*\ \
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


*Следующий пример:*\ \
Индекс сферху = форма = горизонтальные координаты\ \
Индекс снизу = вектор = вертикальные координаты\ \
$a^1 = (1, 0, 0)$\
$a_2 = (0, 1, 0)^T = display(vec(0, 1, 0))$\ \
$a_3 = (0, 0, 1)^T = display(vec(0, 0, 0))$\ \
$b = a^1 times.circle a_2 times.circle a_3$\ \
$beta_(i k) ^ j = (psi^i) times.circle (zeta_i) times.circle (eta_k)$
\ \ $b = display(mat(augment: #(vline: (3, 6)),
0, 0, 0, 0, 0, 0, 0, 1, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0)) 
$\ \ // имба // полезно

== Транспонирование тензора:\ \
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
== Проверка тензора на симметричность и антисимметричность\ \
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
== Симметризация и антисимметризация тензоров\ \
=== Симметризация\ \
$W in Omega^p_0(KK)$\ \
$U(x_1, dots, x_p) = 1/p! sum_sigma W(x_sigma(1), dots, x_sigma(p)), quad U in sum^p (KK), quad U = "Sym"(W)$\ \
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

== Разложение на тензорное произведение одновалентных форм\ \
$a^(i j)_k = alpha f^i times.circle f^j times.circle e_k$\ \
$(a^(i j)_k) = display(mat(augment: #(vline: (2)),
1, 1, 2, 2 ; 
1, 2, 2, 2)) &= 1 dot f^1 times.circle f^1 times.circle e_1 + 1 dot f^1 times.circle f^2 times.circle e_1 + 1 dot f^2 times.circle f^1 times.circle e_1 + 1 dot f^2 times.circle f^2 times.circle e_1 + \ & + space 2(f^1 times.circle f^1 times.circle e_2 + f^1 times.circle f^2 times.circle e_2 + f^2 times.circle f^1 times.circle e_2 + f^2 times.circle f^1 times.circle e_2) =\ \ &= (f^1 times.circle f^1 + f^1 times.circle f^2 +f^2 times.circle f^1 + f^2 times.circle f^2) times.circle(e_1 + 2e_2) = \ \ & = (f^1+f^2) times.circle (f^1 + f^2) times.circle (e_1 + 2e_2)$
