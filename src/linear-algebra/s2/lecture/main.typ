#import "../../../template.typ": *

#set page(margin: 0.45in, height: auto)
#set par(leading: 1em, first-line-indent: 0em)
#set text(font: "New Computer Modern")
#set heading(numbering: "1.1.")
#show raw: set text(font: "New Computer Modern Mono")
#show par: set block(spacing: 0.55em)
#show heading: set block(above: .5em, below: 1em)
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
  subtitle: "Лектор: 
  Трифанов Александр Игоревич"
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
#let apply=$space circle.small space$
#let nl=v(0.2cm)
#let sp=0.2cm


#outline(title: "Оглавление", indent: auto)
#pagebreak()

// спойлеры: 1. Полилинеальная и тензорная геометрия, 2. Спектральная теория типов, 3. Евклидова геометрия

= Полилинейная и тензорная алгебра

== Перестановки
_см. курс дискретной математики первого семестра_

== Пространство полилинейных форм (пространство ПЛФ)

$make X(KK)$ --- ЛП над $KK$, $dim_KK X=n, $\
$make X^* (KK)$ --- пр-во ЛФ над $X(KK)$
\ \
#def полилинейная форма \
ПЛФ называется отображение \
$u: limits(underbrace(X times X times dots times X))_p times limits(underbrace(X^* times X^* times dots times X^*))_q -> KK$\
Обладающее следующщими свойствами (полилинейность - _линейность по всем агрументам_):\
1. $u(...space x_1 + x_2 space... ) = u (... space x_1 space ...) + u (... space x_2 space ...)$
2. $u(dots, lambda x, dots) = lambda u(dots, x, dots)$

#nb пара $(p, q)$ --- валентность ПЛФ
\ \
#exs 
1. $f in X^*(KK)$ --- ПЛФ $(1, 0)$
2. $hat(x) in X^(**)$ --- ПЛФ $(0, 1)$
3. $E_3 quad g(x, space y) = dp(x, y)$ --- ПЛФ $(2, 0)$
4. $E_3 quad omega (x, space y, space z)$ --- ПЛФ $(3, 0)$

#nb $make Omega_p^q$ --- мн-во ПЛФ $(p, q)$
\ \
1. Равенство линейных форм
$ u, v in Omega_p^q : u = v <=> u(x_1, space x_2,dots, space x_p; space y^1, y^2, dots, space y^q) = v(x_1, space x_2,dots, space x_p; space y^1, y^2, dots, space y^q) \ forall x_1, space dots,  x_p in X, space  y^1, space  dots, space  y^q in X^* $

2. Сумма линейных форм \
$ omega = u + v <=> omega (x_1, dots, x_p; space y^1,dots, space y^q)=(u+v)(x_1, dots, space x_p; space y^1, dots, space y^q) =\ u(x_1, dots, space x_p; space y^1, dots, space y^q) +v(x_1, dots, space x_p; space y^1, dots, space y^q) \ forall x_1, dots,  x_p in X, space  y^1, dots, space  y^q in X^* $\
$forall u,v,omega in Omega_p^q quad u+(v+omega)=(u+v)+omega $ --- _ассоциативность_\
  $exists Theta in Omega_p^q quad Theta (x_1, dots, x_p;y^1, dots, y^q)=0, quad forall u in Omega_p^q quad u+Theta=u=Theta+u$ -- _существование нейтрального_\
  $forall u in Omega_p^q quad exists (-u): u+(-u)=Theta$ --- _существование обратного_

3. Произведение ПЛФ на скаляр  $ w=lambda u <=> w(x_1,dots, x_p; y^1,dots,y^q)=(lambda u)(x_1,dots, x_p; y^1,dots,y^q) = lambda u(x_1,dots, x_p; y^1,dots,y^q) $ // не наврал?...

#th \ $Omega_p^q = Omega_p^q (KK)$ --- ЛП
\ \
#proof
Проверка аксиом ЛП $qed$

== Тензор ПЛФ

$make {e_i}_(i=1)^n$ --- базис $X(KK), {f^j}_(j=1)^n$ --- базис $X^* (KK)$\
$see u(x_1, space dots, space x_p, space y^1, space dots, space y^q) eq.circle$\ \
$x_1 = sum_(i_1 = 1)^n xi_1^(i_1) e_i_1 quad dots quad x_p=sum_(i_p=1)^n xi_p^(i_p) e_i_p$\ \
$y_1 = sum_(j_1 = 1)^n mu_(j_1)^1 f ^(j_1) quad dots quad y^q = sum_(j_p=1)^n mu_(j_1)^(q) f^(j_q)$\ \
$eq.circle u(sum_(i_1 = 1)^n xi_1^(i_1) e_i_1 dots sum_(i_p=1)^n xi_p^(i_p) e_i_p; sum_(j_1 = 1)^n mu_(j_1)^1 f ^(j_1) dots sum_(j_q = 1)^n mu_(j_q)^q f ^(j_q))$\ \
$=sum_(i_1 = 1)^n dots sum_(i_p = 1)^n sum_(j_1 = 1)^n dots sum_(j_q = 1)^n xi_1^(i_1) dots xi_p^(i_p) mu_(j_1)^1 dots mu_(j_q)^q u(e_i_1 dots e_i_p f^(j_1) dots f^(j_q)) = sum_(i_1 = 1)^n dots sum_(i_p = 1)^n sum_(j_1 = 1)^n dots sum_(j_q = 1)^n xi_1^(i_1) dots xi_p^(i_p) mu_(j_1)^1 dots mu_(j_q)^q u_(i_1 dots i_p)^(j_1 dots j_q).$ \ \ $u_(i_1 dots i_p)^(j_1 dots j_q)$ --- _тензор линейной формы_\ \

#lm
Задание тензора $u_(i_1 dots i_p)^(j_1 dots j_q)$ в паре базисов пр-в $X$ и $X^*$ эквивалентно заданию самой ПЛФ $u$: $ u <->_({e^i})^({f_j}) u_(i_1 dots i_p)^(j_1 dots j_q) $
#proof
cм. выше. $qed$

== Базис пространства ПЛФ
$Omega_p^q (KK)$ --- пространство ПЛФ над полем $KK$
\ \
#nb $"Mat"_KK (2) quad limits(mat(1,0;0,0))^(=e^1)_(=e_11), space limits(mat(0,1;0,0))^(=e_2)_(=e_12), space limits(mat(0,0;1,0))^(=e_3)_(=e_21), space limits(mat(0,0;0,1))^(=e_4)_(=e_22)$

\
$(e_11)_(i j)=attach(e, bl: 11, tr: i j)$\ \

$attach(e, bl: alpha beta, tr: i j) = delta_alpha^i delta_beta^j = cases(1\, i = alpha\, j = beta, 0\, "иначе")$\

\ \
$see {attach(W, tl: s_1 s_2 dots s_p space, bl: t_1 t_2 dots t_q space)}$ --- набор ПЛФ в $Omega_p^q (KK)$, такой, что:\ \ 
$attach(W, tl: s_1 s_2 dots s_p space, bl: t_1 t_2 dots t_q space ) (x_1 dots x_p; y^1 dots y^q)=xi_1^(s_1) xi_2^(s_2) dots xi_p^(s_p) mu_(t_1)^1 dots mu_(t_q)^q$
\ \
#nb $attach(W, tl: s_1 dots s_p space, bl: t_1 dots t_q space, tr: space j_1 dots j_q, br: space  i_1 dots i_p) = delta_(i_1)^(s_1) dots delta_(i_p)^(s_p) delta_(t_1)^(j_1) dots delta_(t_q)^(j_q)$
\ \
#th \
Набор ${attach(W, tl: s_1 s_2 dots s_p space, bl: t_1 t_2 dots t_q space)}$ --- базис в $Omega_p^q (KK)$\ \ 
#proof
_Докажем полноту_\
$make u in Omega_p^q (KK)$\
$see u(x_1 dots x_p; y^1 dots y^q) = xi_1^(i_1) dots xi_p^(i_p) mu_(j_1)^1 dots mu_(j_q)^q u_(i_1 dots i_p)^(j_1 dots j_q)=attach(W, tl: i_1 dots i_p space, bl: j_1 dots j_q space) (x_1  dots x_p; y^1 dots y^q) u_(i_1 dots i_p)^(j_1 dots j_q)$\
$=> u=attach(W, tl: i_1 dots i_p space, bl: j_1 dots j_q space) u_(i_1 dots i_p)^(j_1 dots j_q)$
\ \
_Докажем ЛНЗ_\
$see attach(W, tl: s_1 s_2 dots s_p space, bl: t_1 t_2 dots t_q space) alpha_(s_1 dots s_p)^(t_1 dots t_q) = theta.$ Рассмотрим на поднаборе базисов $(e_i_1 dots e_i_p; f^(j_1) dots f^(j_q))$\ \
$attach(W, tl: s_1 s_2 dots s_p space, bl: t_1 t_2 dots t_q space) (e_i_1 dots e_i_p ; f^(j_1) dots f^(j_q)) alpha_(s_1 dots s_p)^(t_1 dots t_q) = 0$\ \
$delta_(i_1)^(s_1) dots delta_(i_p)^(s_p) delta_(t_1)^(j_1) dots delta_(t_q)^(j_q) alpha_(s_1 dots s_p)^(t_1 dots t_q) = 0 =>
alpha_(s_1 dots s_p)^(t_1 dots t_q) = 0 qed$
\ \
#nb $dim_KK Omega_p^q = n^(p+q)$

= Симметричные и антисимметричные ПЛФ
$see Omega_p^0(KK)$\
#def симметрическая форма \ Форма $u in Omega_p^0 (KK)$ --- симметрическая, если ее значения не зависят от порядка аргументов
 
$ u(x_sigma(1), x_sigma(2), dots, x_sigma(p)) = u(x_1,x_2,dots,  x_p) \ forall sigma in S_p italic("(группа перестановок)") $
\ \
#ex \ $E_3 (RR) space g(x, y) = dp(x, y) quad g(x, y) = g(y, x)$
\ \
#lm $make u$ --- симметричная $=> u_(i_1 dots i_p) = u_(i_sigma(1) dots i_sigma(p))$
\ \
$make Sigma^p$ --- множество симметричных форм
#image("1.png", width: 30%)
\
#lm  $Sigma^p = Sigma^p (KK) <= Omega_p^0 (KK)$
\ \
#def антисимметричная форма \ $V in Omega_p^0 (KK)$ --- антисимметричная, если $forall sigma in S_p quad v(x_(sigma(1)), dots, x_sigma(p)) = (-1)^([sigma] - "чётность") v(x_1, x_2, dots, x_p)$
\ \
#ex\  $E_3, omega(x, y, z) = (x, y, z), quad omega(x, z, y) = -omega(x, y, z)$
\ \
#lm Тензор антисимметричной формы антисимметричен по индексам $ v_(i_sigma(1) dots i_sigma(p)) = (-1)^([sigma]) v_(i_1 dots i_p) $
\
$make Lambda$ --- мн-во антисимметричных форм
\ \
#lm
$Lambda^p = Lambda^p (KK) <= Omega_p^0 (KK)$
\ \
#nb
$Lambda^p sect Sigma^p = Theta$
\ \
#lm
$v in Lambda^p <=> v$ обнуляется на паре одинаковых аргументов 
\ \
#proof
$arrow.l.double: see v(dots x_i dots x_i dots) = -v(dots x_i dots x_i dots) => v=0$\
$=>: see v(dots x'_i + x''_i dots x'_i+x''_i dots)=0$\
$v(dots x'_i dots x'_i dots) + v(dots x'_i...x''_i dots) + v(dots x''_i dots x'_i dots) + v(dots x''_i dots x''_i dots) = 0$\
$v(dots x'_i dots x''_i dots) = -v(dots x''_i dots x'_i dots) qed$
\ \
#lm
${x_i}_(i=1)^p$ --- ЛЗ $=> forall v in Lambda^p (KK) quad v(x_1, dots, x_p)=0$
== Симметризация и антисимметризация
$make W in Omega_p^0 (KK), quad KK : "char"  KK = 0 quad (QQ$ и "больше") \ \
\
#lm
Следующая форма является симметричной
$ u(x_1, dots, x_p) = 1/p! sum_(sigma in S_p) W(x_sigma(1), dots, x_sigma(p)) $

#proof
$see u(x_chi(1), dots, x_chi(p)) = 1/p! sum_(sigma in S_p) W(x_(sigma chi(1)), dots, x_(sigma chi(p))) = $\
$angle.l sigma apply chi = phi, quad sigma = phi apply chi^(-1) angle.r$\
$= 1/p! sum_(phi apply chi^(-1)\ phi in S_p) W(x_phi(1), dots, x_phi(p)) = u(x_1, dots, x_p) qed$
\ \ \
#def симметризация\
Процесс изготовления симметрической формы из произвольной\
$ ("Sym" W)(x_1, dots, x_p) = 1/p! sum_(sigma in S_p)W(x_(sigma(1)), dots, x_sigma(p)) $
\ \
#nb Коэффициент $1/p!$ --- нормировка: $W in Sigma^p => "Sym" W = W$
\ \
#nb
$"Sym" "Sym" = "Sym"$\
$"Sym" (u+v)="Sym" u + "Sym" v$\
$"Sym" (lambda u) = lambda "Sym"(u)$
\ \
#lm
Следующая форма является антисимметричной  $ v(x_1, dots, x_p) = 1/p! sum_(sigma in S_p) (-1)^[sigma] W(x_sigma(1), dots, x_sigma(p)) $\
\
#def антисимметризация (альтернирование)\ 
Процесс изготовления антисимметричной формы из произвольной

$ ("Alt" W) (x_1, dots, x_p) = 1/p! sum_(sigma in S_p) 
(-1)^[sigma]W(x_sigma(1), dots, x_sigma(p)) $
\ \
#nb
$"Alt Alt"="Alt"$\
$"Alt"(u+v)="Alt" u + "Alt" v$\
$"Alt"(lambda u) = lambda "Alt"(u)$\
$"Alt Sym" = "Sym Alt"=0$
\ \
#nb 
$"Sym" + "Alt" != id$

$v(p = 2)$ \
$A^((s)) = (A+A^T)/2$\
$A^((a)) = (A-A^T)/2$


== Базис $Lambda^p$
$dim _KK Lambda ^p = space ?$\
$make {attach(W, tl: s_1 dots s_p space)}$ --- базис в $Omega_p^0(KK)$\ \
$see attach(F, tl: s_1 dots s_p)= p!"Alt"(attach(W, tl:s_1 dots s_p))$\ \ 
${attach(F, tl: s_1 dots s_p)}$ --- набор в $Lambda^p$ --- ПН, но не ЛНЗ
\ \
#lm Форма $attach(F, tl: s_1 dots s_p)$ --- антисимметрична по своим индексам\
$attach(F, tl: dots s_i dots s_j dots) = - attach(F, tl: dots s_j dots s_i dots)$
\ \
#proof 
$D attach(F, tl: dots s_i dots s_j dots) (dots x_i dots x_j dots) = p!"Alt" attach(W, tl: dots s_i dots s_j dots) (dots x_i dots x_j dots)=p!("Alt" attach(W, tl: dots s_i dots s_j dots))(dots x_i dots x_j dots) =$$=-p! ("Alt" attach(W, tl: dots s_j dots s_i dots))(dots x_i dots x_j dots)=-attach(F, tl: dots s_j dots s_i dots) (dots x_i dots x_j dots)$

#pagebreak()

#nb
+ $attach(F, tl: dots s_i dots s_j dots), space attach(F, tl: dots s_j dots s_i dots)$ --- ЛЗ
+ $attach(F, tl: dots s_i dots s_j dots) = - attach(F, tl: dots s_j dots s_i dots)$
#see 
${attach(F, tl: s_1 dots s_p) | underbrace(1 <= s_1 < s_2 < s_3 < dots < s_p <= n, arrow(s))}$
\ \
#th
${attach(F, tl: arrow(s))}$ --- базис в $Lambda^p$
\ \ #proof
_ПН_: $make U in Lambda^p$\ \
$U = attach(W, tl: s_1 dots s_p) u_(s_1 dots s_p)$\ \
$"Alt" U = U = "Alt" (attach(W, tl: s_1 dots s_p) u_(s_1 dots s_p))$\
\ $=("Alt" attach(W, tl: s_1 dots s_p)) u_(s_1 dots s_p)$\
\ $=1/p! attach(F, tl: s_1 dots s_p) u_(s_1 dots s_p)=1/p! sum_arrow(s) sum_(sigma in S_p) attach(F, tl: s_sigma_((1)) dots s_sigma_((p))) u_(s_sigma_((1)) dots s_sigma_((p)))$\
\ $=1/p! sum_arrow(s) sum_(sigma in S_p) (-1)^[sigma] attach(F, tl: s_1 dots s_p) (-1)^[sigma] u_(s_sigma_((1)) dots s_sigma_((p))) = 1/p! p! sum_arrow(s) attach(F, tl: s_1 dots s_p) u_(s_sigma_((1)) dots s_sigma_((p)))$\ 
\
_ЛНЗ_: #see $attach(F, tl: arrow(s)) alpha_arrow(s) = theta quad | (e_i_1 dots e_i_p)$\ \
$F(e_i_1, dots, e_i_p) alpha_arrow(s) = 0$\ \
$p! "Alt" attach(W, tl: s_1 dots s_p) (e_i_1, dots, e_i_p) alpha_(s_1, dots, s_p) = 0$\ \
$p! sum_(sigma in S_p) attach(W, tl: s_1 dots s_p) (e_i_sigma_((1)), dots, e_i_sigma_((1))) alpha_(s_1, dots, s_p)$\ \
$p! sum_(sigma in S_p) delta^(s_1)_i_sigma_((1)) delta^(s_2)_i_sigma_((2)) dots delta^(s_p)_i_sigma_((p)) alpha_(s_1, dots, s_p) = 0$\ \
$sum_(sigma in S_p) alpha_(i_sigma_((1)) dots i_sigma_((p))) = 0 quad (arrow(s))$\ \
$alpha_(i_phi_((1)) dots i_phi_((p))) = 0$

\ \
#ex\
$"char" K = 2 quad {0, 1}$\ \
#nb
$!V(dots, x_i, dots, x_j, dots) = -V(dots, x_j, dots, x_i, dots)$\
$"char" K = 0 quad K supset QQ$\ \

*Базис:*\
${attach(F, tl: s_1 dots s_p) | 1 <= s_1 < s_2 dots < s_p <= n}$ \ \
#nb
$dim_K Lambda^p = C_n^p$\
\ #nb 
$&Lambda^0 quad dim_K Lambda^0 = 1 quad K\
&Lambda^1 quad dim_K Lambda^1 = n quad X^*(K)\
&Lambda^2 quad dim_K Lambda^1 = (n(n-1))/2 quad "Mat"^"alt"_n (2)\
&space dots.v \
&Lambda ^n quad dim_k Lambda^n = 1 \
"Базис" &Lambda^n quad {attach(F, tl: 1 2 3 dots n)} => forall U in Lambda^n quad U = alpha dot  attach(F, tl: 1 2 3 dots n)}, alpha in K$\ \
#nb $make p > n => Lambda^p = {theta}$\ \
#def определитель \ 
$see attach(F, tl: 1 2 3 dots n) (x_1 dots x_n) = n! "Alt" attach(W, tl: 1 2 3 dots n) (x_1 dots x_n) = n! 1/n! sum_(sigma in S_n) attach(W, tl: sigma_((1)) dots sigma_((n))) (x_1 dots x_n) (-1)^[sigma]$\
$= sum_(sigma in S_n) (-1)^[sigma] xi_1^(sigma_((1))) xi_2^(sigma_((2))) dots xi_p^(sigma_((n))) eq.delta det {x_1 dots x_n}$ --- _определитель_\ \
#nb
$x_i <-> xi_i$\
$see A = mat(xi_1^1, xi_2^1, dots, xi_n^1; xi_1^2, xi_2^2, dots, xi_n^2; dots.v, dots.v, dots.down, dots.v; xi_1^n, xi_2^n, dots, xi_n^n) quad 
det {x_1 dots x_n} equiv det A$

\
\
\- Понятно?\
\- \*молчание\* \
\- Понятно. Всем понятно? \
\- \*нервный смешок\* \
\- Нет, не всем...\
\- \*смех погромче\*\
\- Ну ладно. На экзамене станет понятно.

#pagebreak()

= Произведение ПЛФ

== Определения
$make U in Omega_(p_1)^ q_1 (K) quad V in Omega_(p_2)^q_2(K)$ \
#def произведение ПЛФ \ $U$ и $V$ --- ПЛФ $quad$ форма $W = U dot V$ --- _произведение ПЛФ_:\
$W(x_1, dots, x_p, x_(p_1+1), dots, x_(p_1 + p_2) , y^1, dots, y^q, dots y^(q_1 + q_2) )$ // че
\ $= U(x_1, dots, x_p; y^1, dots, y^(q_1)) dot V(x_(p_1 + 1), dots, x_(p_1 + p_2); y ^(q_1+1), dots, y^(q_1 + q_2)$
\ \
#nb
$W$ --- ПЛФ $(p_1 + p_2, q_1 + q_2)$\
#lm
$U <-> u_(i_1, dots, i_p_1)^(j_1, dots j_q_1), quad V <-> v_(i_(p_1+1), dots, i_(p_1 + p_2))^(j_(q_1 + 1), dots, j_(q_1 + q_2))$\ \
$U V <-> u_(i_1, dots, i_p_1)^(j_1, dots j_q_1) v_(i_(p_1+1), dots, i_(p_1 + p_2))^(j_(q_1 + 1), dots, j_(q_1 + q_2)) = w_(i_1, dots, i_(p_1 + p_2))^(j_1, dots, j_(q_1 + q_2)) <-> W$
\ \
*Свойства:*\
1. $U dot V != V dot U$\
  #ex\ $&f, g in X^*(K)$ \ $ x, y in X(K)$\
  $(f dot g)(x, y) = f(x) dot g(y) != (g dot f)(x, y) = g(x) dot f(y)$\ \
2. $U in Omega_(p_1)^(q_1) (K)quad V in Omega_(p_2)^q_2(K) quad U dot V in Omega_(p_1 + p_2)^(q_1 + q_2) <-> $ внешнее произведение \ \
3. $U in Omega_(p_1)^(q_1) (K) quad theta in Omega_(p_2)^(q_2) (K) quad U dot theta = theta dot U = theta in Omega_(p_1+p_2)^(q_1+q_2) (K)$ \ \
4. $forall U, V, W: (U dot V) dot W = U dot (V dot W)$ \ \
5. $U dot (V + W) = U dot V + U dot W$ \ \
6. $forall alpha in K quad U dot (alpha V) = (alpha U) dot V = alpha dot (U dot V)$ \ \
7. $make {attach(W, tl: s_1 dots s_p)}$ --- базис $Omega_p^0 (K)$\ \
  $make {f^j}$ --- базис $X^* (K) =>$\ \
  $attach(W, tl: s_1 dots s_p) = f^(s_1) dot f^(s_2) dot dots dot f^(s_p)$\ \
  $see attach(W, tl: s_1 dots s_p) (x_1 dots x_p) = xi_1^(s_1) xi_2^(s_2) dots xi_p^(s_p)$\ \
  $= <{e_i} "- базис, сопр. " {f^j}> = f^(s_1) (x_1) dot dots f^(s_p) (x_p)$\ \
  $= (f^(s_1) dot f^(s_2) dot dots dot f^(s_p))(x_1, x_2, dots, x_p)$
\ \
#nb \
${attach(W, tl: s_1 dots s_p, bl: t_1 dots t_q)}$ --- базис $Omega_p^q (K) quad $ $quad {attach(W, tl: s_1 dots s_p, bl: t_1 dots t_q)} (x_1 dots x_p y^1 dots y^q) = xi_1^(s_1) dots xi_p^(s_p) eta^1_(t_1) dots eta^q_(t_q)$\
 \
${f_j}$ --- базис $X^* (K),$\ \
${hat(e)_m}$ --- базис $X^(**) (K)quad quad  => quad quad  attach(W, tl: s_1 dots s_p, bl: t_1 dots t_q) = f^(s_1) dot dots dot f^(s_p) hat(e)_(t_1) dot dots dot hat(e)_t_q$\
\ \
_Пространство, в котором эта операция является внутренней:_\
#def внешняя алгебра полилинейных форм \  
#see $Omega = Omega_0^0 plus.dot Omega_0^1 plus.dot Omega_1^0 plus.dot Omega_1^1 plus.dot dots = limits(plus.circle.big)_(i=0)^(infinity) limits(plus.circle.big)_(j=0)^(infinity) Omega_i^j$\
$omega in Omega quad  quad &omega_1 = V_1 + W_1 \ &omega_2 = V_2 + W_2  quad quad omega_1 +omega_2 = (V_1 + V_2) dot (W_1 + W_2)$

$(Omega, +, dot)$ --- _внешняя алгебра ПЛФ_
\ \
== Алгебра Грассмана

*Вступление:*\
$make &U in Lambda^p, quad V in Lambda^q$ \
$space quest &U dot V in Lambda^(p+q) space quad  space$ неправда.\
$make &U dot V = W$\
$W(x_1, dots, x_p, space space x_(p+1), dots, x_(p+q)) = U(x_1, dots, x_p) dot V(x_(p+1), dots, x_(p + q))$
\ \
#def антисимметричное произведение ПЛФ\
$U and V = "Alt"(U dot V) dot (p + q)!/(p! dot q!) $ --- _антисимметричное произведение ПЛФ_
\ \
#lm 
$"Sym"("Sym" U dot V) = "Sym"(U dot "Sym" V) = "Sym"(U dot V)$\
$"Alt"("Alt" U dot V) = "Alt"(U dot "Alt" V) = "Alt"(U dot V)$
\ \
*Доказательство* _(для альтернирования)_*:*\
$"Alt"("Alt" U dot V)(x_1, dots, x_p, space x_(p+1), dots, x_(p+q))="Alt" [1/p! sum_(sigma in S_p) (-1)^[sigma] U dot V] (x_sigma_((1)) x_sigma_((p)) x_(p+1) dots x_(p+q))$\ \
$=1/p! sum_(sigma in S_p) (-1)^[sigma] ["Alt" (U dot V)] (x_sigma_((1)),  x_sigma_((p)),  x_(p+1), dots, x_(p+q))$\ \
$=1/p! sum_(sigma in S_p) (-1)^[sigma] (-1)^[sigma] ["Alt" (U dot V)] (x_1, dots ,x_p, space  x_(p+1), dots, x_(p+q))$ \ \
$= 1/p! dot  p! ("Alt" U dot V)(x_1, dots ,x_p, space  x_(p+1), dots, x_(p+q))$
\ \ \
*Свойства внешнего произведения:*\ #v(0.15cm)
$make U in Omega_p^0 quad V in Omega_q^0$\
1. Суперкоммутативность:\
  $U and V = (-1)^(p dot q)space V and U$
  #v(0.2cm)#proof
  $(U and V) (x_1, dots ,x_p, space  x_(p+1), dots, x_(p+q))= (p+q)!/(p!q!) "Alt" (U dot V) (x_1, dots ,x_p, space  x_(p+1), dots, x_(p+q))$\ #v(0.15cm)
  $=(-1)^(p dot q) (p+q)!/(p! q!) "Alt" (V dot U) (x_(p+1), dots, x_(p+q), space x_1, dots ,x_p)$
  #v(0.2cm)#nb
  $f and g = -g and f quad forall f, g in X^* (K)$\
  $v and omega^((2m)) = omega^((2m)) and v$\

2. Ассоциативность:\
  $U and (V and W) = (U and V) and W$
  #v(0.2cm)#proof _очевидно_ (доказательство оставлено читателям в качестве простого, но обязательного упражнения)
3. $U and (alpha V) = (alpha U) and V = alpha(U and V) quad quad forall alpha in K$
4. $U and (V + W) = U and V + U and W$
5. ${attach(F, tl: s_1 dots s_p)}$ --- базис $Lambda^p => attach(F, tl: s_1 dots s_p) = f^(s_1) and f^(s_2) and dots and f^(s_p)$
  #v(0.2cm)#proof
  $attach(F, tl: s_1 dots s_p) = p! "Alt"(attach(W, tl: s_1dots s_p))= p! "Alt" (f^(s_1) dot f^(s_2) dot dots dot f^(s_p))$\ #v(0.15cm)
  $=p! (1 (p-1)!)/(p!) dot f^(s_1) and "Alt"(f^(s_2) dot dots f^(s_p)) = (p-1)! dot f^(s_1) and "Alt"(f^(s_2) dot dots dot f^(s_p)) = dots$\ #v(0.15cm)
  $= f^(s_1) and f^(s_2) and dots f^(s_p)$
6. $U in Lambda^p, space v in Lambda^q$\ #v(0.15cm)
  $u and v = 0 quad quad p + q > n$\ #v(0.15cm)
  #see $Lambda in limits(plus.big)_(j=0)^n Lambda^j quad dim_K Lambda^j = C_n^j$\ #v(0.15cm)
  $dim_K Lambda = 2^n$

#quote([Всё, что было до этого --- детский сад. Ну может начальная школа], attribution: "Трифанов Александр Игоревич", block: true)
// там на задних рядах люди плачут
// о чем
// о детском садике ну может о начальной школе
// :(
$(Lambda, +, and)$ --- алгебра Грассмана
\ \
#def градуированная алгебра\ #v(0.1cm)
$Lambda$ --- _градуированная алгебра_, если:\ #v(0.15cm)
$U in Lambda^P, V in Lambda^q => U dot V in Lambda^(p+q)$\
$Lambda^p Lambda^q subset Lambda^(p+q)$
\ \
#ex \ \А\л\г\е\б\р\а \м\н\о\г\о\ч\л\е\н\о\в

// а всех остальных уже отчислили?
// ?
// сколько там людей из 34-37
// хз
// но всего сидит 15 ровно

#pagebreak()

= Определитель
$see dim_K Lambda^n=1 => {attach(F, tl: 12 dots n)}$ --- базис $Lambda^n$
\ \
#def определитель\
Определитель набора векторов ${x_i}^n_(i = 1)$ --- "число" \
$det{x_1 dots x_n} &= attach(F, tl: 12dots n)(x_1 x_2 dots x_n) \ &= n! "Alt" attach(W, tl: 12dots n)(x_1 x_2 dots x_n) \ & = n! dot 1/(n!) limits(sum)_(sigma in S_n) (-1)^[sigma] attach(W, tl: 12dots n)(x_sigma(1) x_sigma(2) dots x_sigma(n)) \ & = sum_(sigma in S_n) (-1)^[sigma] xi^1_sigma(1) xi^2_sigma(2) dots xi^n_sigma(n)$
\ \
#nb 
Альтернативная форма:\ #v(0.2cm)
$C := [x_1 x_2 dots x_n] = mat(delim: "[",
xi_1^1, xi_2^1, dots, xi_n^1;
xi_1^2, xi_2^2, dots, xi_n^2;
dots.v, dots.v, dots.down, dots.v;
xi_1^n, xi_2^n, dots, xi_n^n)$
\ #v(0.2cm)
$det C := det {x_1 dots x_n}$

== Определитель как форма объёма
$make {x_i}^n_(i = 1)$ --- набор в $X(K)$\ #v(0.2cm)
#def параллелепипед, построенный на векторах набора ${x_i}^n_(i = 1)$\ #v(0.2cm)
Множество следующего вида: $T_n{x_1 dots x_n} = {sum_(i = 1)^n lambda^i x_i | lambda^i in [0, space 1] space forall i}$\ #v(0.2cm)
$make omega$ --- форма объёма в $X(K) space(K=RR)$\ #v(0.2cm)
_Свойства:_ \
+ $"codom" omega in RR$

+ $omega T{dots x'_i + x''_i dots} = omega T {dots x'_i} + omega T {dots x''_i dots}$\
  $omega T { dots lambda x_i dots} = lambda omega T {dots x_i dots}$
+ $omega T {x_1 dots x_n} = 0 <=> {x_i}_(i = 1)^n$ --- ЛЗ

$=> omega in Lambda^n => omega tilde det$\
_Вычисление определителя --- вычисление объёма параллелепипеда, построенного на векторах набора_

== Свойства определителя
#nb
$det{x_1 dots x_n} = limits(sum)_(sigma in S_n) (-1)^[sigma] xi^1_sigma(1) xi^2_sigma(2) dots xi^n_sigma(n) = mat(delim: "|", 
xi_1^1, dots, xi_1^n;
xi_2^1, dots, xi_2^n;
dots.v, dots.down, dots.v;
xi_n^1, dots, xi_n^n)$\
\
*1.* \ $det C^T = det C$\ #v(0.2cm)
#proof #v(0.2cm)
$sum_(sigma in S_n) (-1)^[sigma] xi^1_sigma(1) xi^2_sigma(2) dots xi^n_sigma(n) = det C\
= sum_(sigma in S_n) (-1)^[sigma] xi^sigma(1)_1 xi^sigma(2)_2 dots xi^sigma(n)_n eq.delta det C^T$\

$display(mat(
sum_(sigma) attach(W, tl: 1 2 dots n) (x_sigma(1) dots x_sigma(n)) = xi_sigma(1)^1 dots xi_sigma(n)^n;
sum_(sigma) attach(W, tl: sigma(1) sigma(2) dots sigma(n)) (x_1 dots x_n) = xi^sigma(1)_1 dots xi^sigma(n)_n))$

*2.* \ 
$det {dots x'_i + x''_i dots} = det{dots x'_i dots} + det{dots x''_i dots } $\ 
$det{dots lambda x_i dots} = lambda det{dots x_i dots} $ \
$det{lambda C} = lambda^n det C $\
$det(C_1 + C_2) eq.not det C_1 + det C_2$\
*3.*\
$det {dots x_i dots x_j dots} = det{dots x_i dots x_j + lambda x_i}$\
*4.*\
$det{dots x_i dots x_j dots} = - det{dots x_j dots x_i dots}$ \
*5.*\
_Рекуррентная формула_\ #v(0.2cm)
$det C = sum_(i= 1)^n (-1)^(i + j) xi_j^i M ^i _j$ --- разложение по $j$-му столбцу\ #v(0.2cm)
$det C = sum_(j= 1)^n (-1)^(i + j) xi_j^i M ^i _j$ --- разложение по $i$-ой строке
#v(0.2cm)
#proof #v(0.2cm)
#columns(2, gutter: 6cm)[
$det C &= attach(F, tl: 1 2 dots n)(x_1 x_2 dots x_n) = \ &= f^1 and f^2 and dots and f^n (x_1 x_2 dots x_n)$\ #v(0.2cm)
$= f^1 and f^2 and dots and f^m and dots and f^n (x_1 dots x_m dots x_n)$\ #v(0.2cm)
$= < x_m = sum_(i=1)^n xi_m^i e_i; f^j (e_i) = delta_i^j >$\
$= f^1 and dots and f^m and dots and f^n (x_1 dots sum_(i 
 = 1)^n xi_m^i e _i dots x_n)$\ #v(0.2cm)
$=sum_(i=1)^n f^1 and dots and f^m and dots and f^n (x_1 dots limits(underline(e_i))_(m arrow.t.curve) dots x_n)$\ #v(0.2cm)
$=sum_(i=1)^n xi_m^i (-1)^(i + m) f^1 and dots and f^(m - 1) and f^(m + 1) and dots and f^n (x_1 dots x_(m-1) x_(m+1) dots x_n))$\ #v(0.2cm)
$=sum_(i=1)^n xi_m^i (-1)^(i + m) M_m^i quad quad quad quad quad quad quad quad quad quad quad quad quad quad quad quad quad quad quad quad quad  eq.circle$\
#colbreak()
$f and g = f dot g - g dot f$\ #v(0.2cm)
$f and g and h &= f dot g dot h + h dot f dot g + g dot h dot f - \
&- f dot h dot g - g dot f dot h - h dot g dot f$
#align(center)[#image("2.png", width: 60%)]]

#def алгебраическое дополнение\
Алгебраическим дополнением элемента $xi_m^i$ называется "число": $ A_m^i = (-1)^(i+m) M_m^i $

#nb #v(0.2cm) $det C = sum_(i=1)^n xi_m^i A_m^i$
\ \
#th (_Лапласа_)\
_Определитель матрицы равен сумме произведений миноров матрицы на их алгебраических дополнениях_\ #v(0.2cm) 
$det C = sum_(i_1 dots i_p) (-1)^(i_1 + dots + i_p + j_1 + dots j_p) M_(j_1 dots j_p)^(i_1 dots i_p) L_(j_1 dots j_p)^(i_1 dots i_p)$
\ \
#ex\   #v(0.2cm)
$mat(delim: "|", 1,2,3,4;3,4,2,1;1,-1,2,1;0,1,2,3) = mat(delim: "|", 3,4;1,-1) dot (-1)^(2+3+1+2) mat(delim: "|", 3,4;2,3) + mat(delim: "|", 3,2;1,2) dot (-1)^(2+3+1+3) dot mat(delim: "|", 2,4;1,3) + dots$ ("_кому интересно, дома досчитаете_")\
 \ #proof #v(0.2cm) 
Продолжаем "доказательство" предыдущего свойства \
#v(0.2cm) 
$eq.circle sum_(i=1)^n xi_m^i (-1)^(i+m) sum_(j=1)^n xi_l^j (-1)^(j+l) M_(m l)^(i j) = sum_(i, j =1)^n underbracket(xi_m^i xi_l^j, L_(m l)^(i j)) (-1)^(i + m + j + l) M_(m l)^(i j)$

#nb #v(0.2cm) 
$det "diag" {lambda_1 dots lambda_n} = product_(i=1)^n lambda_i$\
$det "diag" {C_1 C_2 dots C_m} = product_(i=1)^m det C_i$\
$det mat(delim: "[", C_1, *, dots, *; 0, C_2, dots, *; dots.v, dots.v, dots.down, dots.v; 0, dots, dots, C_m) = product_(i=1)^m det C_i$

#nb
$sum_(i=1)^n xi^i a_i = b$ --- система Крамера\
$=> xi^i = Delta_i/Delta$, где $Delta = det {a_i dots a_n}, Delta_i = det {a_1 dots limits(b)_(i arrow.t.curve) dots a_n}$
#proof
$Delta_i = det {a_1 dots b dots a_n} = det {a_1 dots sum_(i=1)^n xi^i a_i dots a_n} = det {a_1 dots xi^i a_i dots a_n} = xi^i Delta$ 

= Ранг матрицы

$make {x_i}_(i = 1)^n$ --- набор в $X(K)$\ #v(0.2cm)
$det{x_1 dots x_n} = 0 => {x_i}_(i=1)^n$ --- ЛЗ\ #v(0.2cm)
Сколько ЛНЗ векторов в наборе ${x_i}_(i = 1)^n ?$
\ \
#lm ${x_i}_(i = 1)^m$ --- ЛЗ $arrow.l.double forall V in Lambda^M space V (x_1 dots x_m)= 0$
\ \ 
#proof
От противного: $make {x_i}_(i=1)^m$ --- ЛНЗ (при #sym.arrow.t этом условии)\
$x_1 x_2 dots x_m$\
$arrow.b space arrow.b space space arrow.b$\
$e_1 e_2 quad e_m e_(m+1) dots e_n$ --- базис $X(K)$\ #v(0.2cm)
$make {f^j}_(j=1)^n$ --- базис, сопряженный к ${e_i}_(i=1)^n$: $f^j (e_i) = delta_i^j$\ #v(0.2cm)
$see f^1 and f^2 and dots and f^m (x_1 x_2 dots x_m) = sum_(sigma in S_m) (-1)^[sigma] f^sigma(1) dot f^sigma(2) dot dots dot f^sigma(m) (x_1 x_2 dots x_m) tilde$\ #v(0.2cm)
$tilde C dot sum_(sigma in S_m) (-1)^[sigma] xi_1^sigma(1) xi_2^sigma(2) dots x_m^sigma(m) $\ #v(0.2cm)
$= C dot delta_1^sigma(1) delta_2^sigma(2) dots delta_m^sigma(m) = C != 0$\ #v(0.2cm)
Нашли $m$-форму, которая не обнуляется. Противоречие\
$attach(F, tl: 1 2 dots m) = m! ("Alt" attach(W, tl: 1 2 dots m)) = m! 1/m! sum$

#nb
Если хотя бы одна $m$-форма отлична от нуля, то набор ${x_i}_(i=1)^m$ --- ЛНЗ\
\
$V in Lambda^m quad make {attach(F, tl: s_1 dots s_m)}$ --- базис $Lambda^m$

#nb
Для проверки ЛЗ достаточно проверить базисные формы\
${x_i}_(i=1)^n: forall s_1 dots s_p, 1 <= s_1 < s_2 < dots < s_m <= n quad attach(F, tl: s_1 dots s_p) (x_1 dots x_m) = 0 => {x_i}_(i=1)^m$ --- ЛЗ\ \
$see C = mat(delim: "[",
xi_1^1, xi_2^1, dots, xi_m^1;
xi_2^1, xi_2^2, dots, xi_m^2;
dots.v, dots.v, dots.down, dots.v;
xi_1^n, xi_2^n, dots, xi_m^n) <--$ сколько ЛНЗ\
$attach(F, tl: s_1) quad attach(F, tl: s_1 s_2) quad attach(F, tl: s_1 s_2 s_3)$ // wtf is that
\ \
#def ранг матрицы\
Рангом матрицы $C$ называется её наибольший порядок отличного от нуля минора\
$"rg" (C) quad "rank"(C) quad "rk"(C)$
\ \
#ex\
#columns(2)[
#image("3.png", width: 60%)
#colbreak()\ \
$B = mat(delim: "[",
b_1, *, *, dots, *;
0, b_2, *, dots, *;
dots.v, dots.v, dots.v, dots.down, dots.v;
0, 0, 0, dots, b_c)$

+ $b_1 != 0 => "rank" C >= 1$ #v(0.2cm)
+ $b_1 b_2 != 0 => "rank" C >= 2$
$dots.v$\ #v(0.2cm)
$l. space product_(i=1)^l b_i != 0 => "rank" C >= l$\ #v(0.2cm)
$l+1. space V space attach(L, tr: i_1 dots i_(l+1), br: j_1 dots j_(l+1)) => "rank" C = l$
]
\ \
#def базисные столбцы (строки)\
Базисными столбцами (строками) матрицы $C$ называются столбцы (строки), входящие в базисный минор
\ \
#lm
Любая строка (столбец) матрицы $C$ является линейной комбинацией базисных строк (столбцов)
#proof
Очевидно. #emoji.face.cool
\ \
#th (_о ранге_)\
Ранг матрицы равен кол-ву ЛНЗ строк или столбцов матрицы

\ \ 
*Свойства ранга:*\
// стоп а где пункт 1 был
// "пока не будем"
1. ```py pass```
2. 
== Теорема Крамера и Кронекера-Капелли
$make sum_(i=1)^n xi^1 a_1 = b$ --- СЛАУ\
$A = [a_1 a_2 dots a_n], xi = vec(delim: "[", xi_1, xi_2, dots.v, xi_m)$\
В матричной форме $A xi = b quad (*)$\
#th (_Крамер_)\
$(*)$ совместна и определена $<=> det A != 0$
#proof
$=>: {a_1 a_2 dots a_n}$ --- базис $K^n => {a_i}_(i=1)^n$ --- ЛНЗ $=> det {a_1 dots a_n} != 0$\
$arrow.l.double: det {a_1 dots a_n} = det A != 0 => {a_i}_(i=1)^n$ --- ЛНЗ $=> max +$ ЛНЗ $=>$ базис $=>$ $exists$ решение $forall b$\
$xi^i = Delta_i/Delta$\
\
#th (_Кронекера-Капелли_)\
$see A xi = b quad (*)$\
$A, [A | b]$ --- расширенная матрицы\
Система $(*)$ совместна $<=> "rank" A = "rank" [A | b]$\
#proof
$=>: (*)$ совместна $=> b in angle.l a_1 dots a_n angle.r =>$ добавление столбца $b$ не меняет ранга $A$\
$=> "rank" A = "rank" [A | B]$\
$arrow.l.double: "rank" [A | b] = "rank" A => b in angle.l a_1 dots a_n angle.r =>$ совместна

== Вычисление ранга
#lm Гауссовы (элементарные) преобразования не меняют ранг матрицы
1. Сложение строк (не меняет определитель)\
2. Умножение строки на число $eq.not 0$ (определитель умножается на $lambda$)
3. Перестановка строк (меняет только знак определителя)
\ 
*Приведение к верхнему треугольному виду*\ #v(0.2cm)
$mat(delim: "[",
a_1^1, a_2^1, dots, a_n^1;
dots.v, dots.v, dots.down, dots.v;
a_1^n, a_2^n, dots, a_n^n) tilde mat(delim: "[",
tilde(a)_1^1, tilde(a)_2^1, dots, tilde(a)_n^1;
0, tilde(a)_2^2, dots, tilde(a)_n^2;
dots.v, dots.v, dots.down, dots.v;
0, 0, dots, ?)$\
$"rank" A$ --- кол-во отличных от нуля строк

#pagebreak()

= Тензорное произведение

$make X(K), space Y(K)$ --- ЛП над $K$ #nl
$dim_K X = n$ #nl
$dim_K Y = m$ #nl
$make Z(K)$ --- ЛП над $K$ #nl
$make b: X times Y -> Z$ --- билинейное отображение #nl
$forall x_1, x_2, x in X(K) quad y_1, y_2, y in Y(K) quad forall lambda in K$
- $b(x_1 + x_2, y) = b(x_1, y) + b(x_2, y)$

- $b(x, y_1 + y_2) = b(x, y_1) + b(x, y_2)$
- $b(lambda x, y) = lambda b(x, y) = b(x, lambda y)$
#nl
#nb
$x in X(K) quad exists {e_i}_(i=1)^n$ --- базис $X(K)$ #nl
$display(y in Y(K) quad exists {g_j}_(j=1)^m)$ --- базис $Y(K)$ #nl 
$x = display(sum_(i=1)^n xi^i e_i quad y = sum_(j=1)^m eta^j g_j)$ #nl
$b(x, y) = sum_(i=1)^n sum_(j=1)^n xi^i eta^j b(e_i, g_j) = sum_(i=1)^n sum_(j=1)^n xi^i eta^j h_(i j), quad h_(i j) in Z(K)$
#nl #nl #nl
#nb
$b(x_1, y_1) + b(x_2, y_2) = b(?, ?)$
#nl#nl#nl // может следать переменную для длины и писать типа #v(3 f")?
//ниасилил // 3*sp?
#lm
Следующие условия эквивалентны:
+ ${b(e_i, g_j)}_(i=1dots n)^(j=1dots m)$ --- базис $Z(K)$

+ $forall z in Z(K) quad exists! z = sum_(i=1)^n b(e_i, y_i), quad y_i in Y(K)$
+ $forall z in Z(K) quad exists! z = sum_(j=1)^m b(x_j, g_j), quad x_j in X(K)$
#proof
$(1) <=> (2)$:\
${b(e_i, g_j)}$ --- базис $Z(K) => forall z quad z eq^! sum_(i=1)^n sum_(j=1)^m zeta^(i j) b(e_i, g_j) = sum_(i=1)^n b(e_i, sum_(j=1)^m zeta^(i j) g_j) = sum_(i=1)^n b(e_i, y_i)$
$(1) <=> (3)$ аналогично.
#v(3*sp)
#def тензорное произведение #nl
$X(K), space Y(K)$ --- линейные пространства #nl
$times.circle: X times Y --> X times.circle Y$ --- билинейное отображение, такое что:#nl
Если ${e_i}^n_(i = 1)$ --- базис $X(K)$ и ${g_j}_(j = 1)^m$ --- базис $Y(K)  quad => {e_i times.circle g_j}_(i = 1 dots n)^(j = 1 dots m)$ --- базис $T = X times.circle Y$
#nl
$T(K)= X(K) times.circle Y(K)$ --- _тензорное произведение_
#v(0.6cm)
#nb #nl
$x in X(K), space y in Y(K)$#nl
$x times.circle y = (sum_(i=1)^n xi^i e_i) times.circle (sum_(j=1)^m eta^j g _j) = sum_(i = 1)^n sum_(j = 1)^m limits(xi^i eta^j)_(" координаты тензора" z " ") limits((e_i times.circle j_j))_(" базис" T=X times.circle Y " ")$
#v(0.6cm)
#def разложимый (факторизуемый) элемент #nl
Элемент $z in T$ называется разложимым, если $exists x in X(K), y in Y(K)$, что $z = x times.circle y$, иначе $z$ называется неразложимым
#v(0.6cm)
#ex #nl
Неразложимый: $z = x_1 times.circle y_1 + x_2 times.circle y_2$ #nl
Разложимый: $z = x_1 times.circle y_1 + x_1 times.circle y_2 = x_1 times.circle (y_1 + y_2)$\
#v(0.6cm)
#nb #nl
Общий вид элемента $Z(K)$: #nl
$z = sum_(i=1)^n sum_(j=1)^m zeta^(i j) e_i times.circle g_j$
#v(0.6cm)
#ex #nl
$n=3, space m=2$#nl
$[zeta^(i j)] = mat(delim: "[", 1, 2; 3, 1; 4, 2)$#nl
$z=e_1 times.circle g_1 + 2 e_1 times.circle g_2 + 3 e_2 times.circle g_1 + e_2 times.circle g_2 + 4 e_3 times.circle g_1 + 2 e_3 times.circle g_2$
#v(0.6cm)
#nb #nl
// ты хоть что-нибудь понимаешь? //? //ну я чё-то выпадаю из темы // я еще не вошел
$dim_K T = dim_K X dot dim_K Y$
#v(0.6cm)
#th (_основная теорема тензорной алгебры_)#nl
Для любого билинейного отображения $b: X times Y -> Z
$#nl
$exists! $ билинейное отбражение $tilde(b): X times.circle Y -> Z$ такое, что следующая диаграмма коммутативна
#nl
$X times Y -->^times.circle X times.circle Y$\
$#h(0.6cm)b arrow.br Z arrow.bl tilde(b)$
#nl
#see $b space = space tilde(b) space circle.small space times.circle$
#v(0.6cm)
#proof #nl
$tilde(b)(e_i times.circle g_j) = b(e_i, space g_j)$ и продолжим по линейности
#v(0.6cm)
#lm #nl
$X times.circle Y tilde.eq Y times.circle X$ #nl
$X times.circle (Y times.circle Z) tilde.eq (X times.circle Y) times.circle Z$
#v(0.6cm)
#nb #nl
Обобщение теоремы: #nl
$make X_1 dots X_p$ --- ЛП над $K$ #nl
Для любого $p$-линейного отображения $omega space exists! space tilde(omega)$ --- линейное, такое что следующая диаграмма коммутативна:

$x_1 times dots times x_p -->^times.circle x_1 times.circle dots times.circle x_p$\
$#h(1.2cm)omega arrow.br quad z quad arrow.bl tilde(omega)$

// можешь пока закидывать скриншоты лекции как диаграммы, я потом с этим что-нибудь сделаю
// чем тебе это не нравится?

#v(0.6cm)
#nb #nl
$make X^*(K), space Y(K)$ #nl
$see X^* times Y -> X^* times.circle Y$ #nl
$(alpha, space y) |-> alpha(*) y in "Hom"_K (X, Y)$ #nl
$make x in X quad x|-> alpha(x)y$#nl
#rect($X^* times.circle Y tilde.eq "Hom"_K (X, Y)$)
$X^* tilde.eq "Hom" (X, K)$
#v(0.6cm)
#nb #nl
$X^* (K), Y^* (K)$#nl
$X^* times Y^* -> X^* times.circle Y^*$#nl
$(alpha, beta) |-> alpha times.circle beta in "Hom"_K (X, Y; K)$\
#rect($X^* times.circle Y^* tilde.eq "Hom" (X, Y; K)$)
$alpha times.circle beta <-> omega in Omega_0^2 (K) quad omega(x, y) = alpha(x) dot beta(y)$
#v(0.6cm)
$X times Y -> X times.circle Y tilde.eq "Hom"(X^* Y^*; ???)$ #nl//?
$(x, y) -> x times.circle y$ #nl
$(x times.circle y) (alpha, beta) = alpha(x) dot beta(y)$\
$alpha in X^*$\
$beta in Y^*$\
$x times.circle y <-> omega in Omega_0^2 (K)$\

= Пространство тензоров

#def пространство тезноров#nl
$make X(K)$ --- ЛП над $K$ #nl
$limits(underbrace(X^* times.circle X^* times.circle dots times.circle X^*))_p times.circle limits(underbrace(X times.circle X times.circle dots times.circle X))_q$
#v(0.6cm)
#nb #nl
Обозначение $T_q^p (K) (Omega_p^q)$\
#v(0.6cm)
#ex\
$T_0^1 (K) = X^*$ #nl
$T_1^0 (K) = X$ #nl
$T_1^1 = X^* times.circle X tilde.eq "End"_K (X)$
#v(0.6cm)
#def тензор ранга $(p, q)$#nl
Тензором ранга $(p, q)$ называется элемент пространства тензоров $T_q^p (K)$ #nl
#v(0.6cm)
#ex #nl
#let tens = $op(times.circle)$
$alpha^1 tens alpha^2 tens dots tens alpha^P tens y_1 tens y_2 tens dots tens y_q in T^p_q (K)$
#v(0.6cm)
== Операции с тензорами
+ Транспонирование #nl
  $t_(i j): T^p_q -> T^p_q$ #nl
  $dots tens x_i tens dots tens x_j tens dots |-> dots tens x_j tens dots tens x_i tens dots$#nl
  $t^(i j): T^p_q -> T^p_q$#nl
  $dots tens alpha^i tens dots tens alpha^j tens dots |-> dots tens alpha^j tens dots tens alpha^i tens dots$#nl
  
+ Свёртка #nl
  $hat(c)_j^i: T^p_q -> T^(p-1)_(q-1)$ #nl
  $dots tens alpha^i tens dots tens x_j tens dots |-> dots tens alpha^i(x_j) in K tens dots$#nl

+ $make T$ --- пр-во вех тензоров (всех рангов) #nl
  $u =  alpha^1 tens alpha^2 tens dots tens alpha^(p_1) tens x_1 tens dots tens x_(q_1) $#nl
  $v =  beta^1 tens beta^2 tens dots tens beta^(p_2) tens y_1 tens dots tens y_(q_2) $#nl
  $u tens v =  alpha^1 tens dots tens alpha^(p_1) tens beta^1 tens dots tens beta^(p_2) tens x_1 tens dots tens x_(q_1) tens y_1 tens dots tens y_(q_2)$#nl
#v(0.6cm)
#lm #nl
$Omega_p^q (K) tilde.eq T_q^p (K)$ #nl
#v(0.6cm)
#proof
$make omega in T_q^p (K) => omega =  alpha^1 tens dots tens alpha^p tens y_1 tens dots tens y_q$ #nl
$#h(0.25cm) make W in Omega_p^q (K)$ #nl
$x_1, dots, x_p in X; quad beta^1, dots, beta^q in X^*$\ #nl
$W(x_1, x_2, dots, x_p, beta^1, beta^2, dots, beta^q) eq.circle alpha^1 (x_1) alpha^2 (x_2) dots alpha^p (x_p) beta^1 (y_1) beta^2 (y_2) dots beta^q (y_q)$
#v(0.6cm)
#nb
Базис $T^p_q (K)$: $f^(i_1) tens f^(i_2) tens dots tens f^(i_p) tens e_(j_1) tens e_(j_2) tens dots tens e_(j_q)$\ #nl
Базис $Omega_p^q (K)$: $f^(i_1) dot f^(i_2) dot dots dot f^(i_p) dot hat(e)_(j_1) dot hat(e)_(j_2) dot dots dot hat(e)_(j_q)$\
#v(0.6cm)
#ex\ #nl
$hat(c)^i_j: X^* tens X -> K$\ #nl
$#h(0.65cm)alpha tens x |-> alpha(x)$ #nl
// бля
// я даже если перестаю конспектить и просто пытаюсь понять не догоняю
// ебать че происходит
// это были последние строчки этого конспекта...
$see T^0_p (K)$\ #nl
$x_1 tens x_2 tens dots tens x_p$\ #nl
$"char" K = 0$\ #nl
$"Sym": T^0_p (K) -> Sigma_p (K)$\ #nl
$"Sym" (x_1 tens x_2 tens dots tens x_p) = 1/p! sum_(sigma in S_p) x_sigma(1) tens x_sigma(2) tens dots tens x_sigma(p)$\ #nl
$"Alt": T_p^0 (K) -> Lambda_p (K)$\ #nl
$"Alt" (x_1 tens x_2 tens dots tens x_p) = 1/p! sum_(sigma in S_p) (-1)^[sigma] x_sigma(1) tens x_sigma(2) tens dots tens x_sigma(p)$\
#nl #nb
$make omega in T^p_q (K)$\ #nl
$v = underbracket(tilde(v)_(i_1 i_2 dots i_p)^(j_1 j_2 dots j_q), "коорд.тензора"\ omega "в базисах" {e_i}_(i=1)^n\ и {f^j}_(j=1)^n) space f^(i_1) tens f^(i_2) tens dots tens f^(i_p) tens hat(e)_(j_1) tens dots tens hat(e)_(j_q)$\ #nl #nl
$v = tilde(v)_(i_1 i_2 dots i_p)^(j_1 j_2 dots j_q) quad attach(W, tl: i_1 dots i_p, bl: j_1 dots j_q)$\ #nl #nl
$(1, 2, 3)^T <-> 1 + 2 t + 3 t^2$\ #nl
#v(0.2cm)
== Тензорная алгебра
$make X(K)$ --- ЛП над $K$\ #nl
$see T^p_q (K) = (limits(times.circle.big)_(i=1)^p X^*) tens (limits(times.circle.big)_(j=1)^q X)$\ #nl
$see T(K) = limits(plus.big)_(p=0)^infinity limits(plus.big)_(q=0)^infinity T^p_q (K)$\ #nl
#v(0.4cm)
#ex\ #nl
$make X, Y$ --- ЛП\ #nl
$#h(0.4cm)X plus.circle Y$ --- ЛП\ #nl
$#h(0.4cm) (x_1, y_1) + (x_2, y_2) = (x_1 + x_2, y_1 + y_2)$\ #nl
$#h(0.4cm) lambda(x, y) = (lambda x, lambda y)$\ #nl
$(T, +, tens, lambda)$ --- тензорная алгебра\
$omega_01 in T^0_1, v_01 in T^0_1 => omega_01 tens v_01 in T^0_2$\
$x tens (y+z)=x tens y + x tens z$\
$(Lambda, +, and, lambda)$ --- алгебра антисимм. тензоров\
$(Sigma, +, or, lambda)$ --- алгебра симметр. тензоров\
// допишешь? мне еще до итмо добраться надо
// welp

#pagebreak()

// я пришедший без ручек и листочков


//no way Lev Tsvey
// и ушёл
// :(
// Лев привет

= Определитель линейного оператора

$make X(K), space Y(K)$ --- ЛП над $K$\
$see phi: X(K) -> Y(K)$ --- линейное\
$forall space x_1, space x_2, space x in X(K)$\
$phi(X_1 + x_2) = phi(x_1) + phi(x_2)$\
$phi(lambda x) = lambda phi(x)$\ \
#nb
$phi in "Hom"_K (X, Y)$\
$"Hom"_K (X, X) =: "End"_K (X)$\

// пиздец заебался болеть

== Тензорное произведение операторов
#def тензорное произведение линейных операторов\
$make phi in "End"_K (X), space psi in"End"(Y)$\
$chi: phi times.circle psi$ --- _тензорное произведение линейных операторов_, если\ 
$chi: X tens Y -> X tens Y$\
$chi(x tens y) |-> (chi tens psi) (x tens y) = phi(x) tens psi(y)$\ \
#lm 
$chi in "End"_(X tens Y)$\ \
#proof 
- $chi(x tens (y_1 + y_2)) = chi(x tens y_1 + x tens y_2)$\ 
  $chi(x tens (y_1 + y_2)) = phi(x) tens psi(y_1 + y_2) = phi(x) tens (psi(y)_1 + psi(y_2))=phi(x)tens psi(y_1) + psi(x) tens psi(y_2)=$\
  $=chi(x tens y_1 + chi(x tens y_2))$\
$chi(lambda x tens y) = chi ((lambda x) tens y) = phi(lambda x) tens psi(y) = lambda[phi(x) tens psi(y)] = lambda dot chi(x tens y)$
\ \
== Матрица линейного оператора
$make {e_i}^n_(i = 1)$ --- базис X
$make phi in "End"_K (X)$\
$e_i = sum_(j=1)^n a_i^j e_j$\ \
#def матрица линейного оператора\
Набор $A_phi = norm(a_i^j)$ --- матрица линейного оператора в базисе $(e_i)_(i=1)^n$\ #v(0.5cm)
$A_phi = limits(display(mat(delim: "[", 
a_1^1, a_2^1, dots, a_n^1;
a_1^2, a_2^2, dots, a_n^2;
dots.v, dots.v, dots.down, dots.v;
a_1^n, a_2^n, dots, a_n^n)))_(arrow.t quad quad  arrow.t quad quad quad space arrow.t\ phi e_1 space phi e_2 space dots space space phi e_n)$\
#v(0.5cm)
$make {g_l}^m_(l=1)$ --- базис $Y(K)$\
$make psi in "End"_K (Y)$\
$make B_psi = ||b_l^k||$ --- матрица $psi$ в базисе ${g_l}_(l=1)^m$
\ \
#nb
#grid(
  columns: (95pt, 1fr),
  [${e_i}_(i=1)^n$ --- базис $X$\
${g_j}_(j=1)^m$ --- базис $Y$\ ],
[#v(0.35cm)
#align(left)[
$=> {e_i tens g_j}_(i=1 dots n)^(j=1 dots m)$ --- базис $X tens Y$\
]]) #v(0.2cm)
$(phi tens psi)(e_i tens g_j) = phi(e_i) tens psi(g_j) = (sum_(k=1)^n a_i^k e_k) tens (sum_(l=1)^m) b_j^l g_l = sum_(k=1)^n sum_(l=1)^m a_i^k b_j^l (e_k tens g_l)$\
$C_(phi tens psi) = norm(a_i^k tens b_j^l)_(i,k=1 dots n)^(j,l=1 dots m)$ --- матрица тензорного произведения.\
В кронекеровской форме:\
$display(mat(delim: "[",
a_1^1 B_psi, a_2^1 B_psi, dots;
a_2^1 B_psi, a_2^2 B_psi, dots;
dots.v, dots.v, dots.down))$
\ \
== Тензорная степень
$make X(k)$ --- ЛП над $K$\
$phi in "End"_K (X)$\
$see T_p (K) = limits(times.circle.big)_(i=1)^n X := underbrace(X tens X tens dots tens X, p)$ // крокодильчик
\ \
#nb Элементы (разложимые) имеют вид:\
$x_1 tens x_2 tens dots x_p$
\ \
#def тензорная степень\
Тензорная степень оператора $phi$ --- линейное отображение вида:\
$ phi^(tens p): limits(times.circle.big)_(i=1)^p X -> limits(times.circle.big)_(i=1)^p X $
$ phi ^(tens p) (x_1 tens x_2 tens dots tens_p) = phi x_1 tens phi x_2 tens dots tens phi x_p $
\
== Внешняя степен#text(fill: rgb(80%, 80%, 80%))[ь] оператора //(ь)??? а ты посмотри что на доске // ахаха, степен //пиздец

$see Lambda^p := underbrace(X and X and dots and X, p) = limits(and.big)_(i=1)^p X$\ #v(0.5cm)
$dim_K X = n quad => quad dim_K Lambda^p = C_n^p$
\ \
#nb Элементы $Lambda^p$ имеют вид:\
$ x_1 and x_2 and dots x_p $
\
#def определитель набора векторов\ 
Определителем набора векторов ${x_i}_(i=1)^n$ называется величина такая, что в базисе ${e_i}_(i=1)^n$ имеет место
\
$ x_1 and x_2 and dots and x_n = det [x_1 x_2 dots x_n] e_1 and e_2 and dots and e_n $

#lm
$det {x_1 dots x_n} = det [x_1 dots x_n]$\ \
#proof
$x_1 and x_2 and dots and x_n = xi_1^(i_1) e_i_1 and xi_2^(i_2) e_i_2 and dots and xi_n^(i_n) e_i_n = xi_1^(i_1) xi_2^(i_2) dots xi_n^(i_n) e_i_1 and e_i_2 and dots and e_i_n$
\
$=display( sum_(sigma in S_n) (-1)^[sigma] xi_1^sigma(1)  xi_2^sigma(2) dots  xi_3^sigma(3) e_1 and e_2 and dots and e_n) = det {x_1 dots x_n}e_1 and e_2 and dots and e_n $
\ \
#nb
$det [x_1 dots x_n]$ зависит от базиса\
$make z in Lambda^n => z = alpha dot e_1 and e_2 and dots and e_n$
#image("4.png", width: 20%)
// да, кста, лев
// сюда картинки на изи через контроол-в закидываются
// переименовывать только
${e'_j}_(j=1)^n <-^T {e_i}_(i=1)^n, e'_j = sum_(i=1)^n tau^i_j e_i$\ 
$e'_1 and e'_2 and dots and e'_n = tau_1^(i_1) e_i_1 and tau_2^(i_2) e_i_2 and dots and tau_n^(i_n) e_i_n = tau_1^(i_1) tau_2^(i_2) dots tau_n^(i_n) e_i_1 and e_i_2 and dots and e_i_n=$\
$=sum_(sigma in S_n) tau_1^sigma(1) tau_2^sigma(2) dots tau_n^sigma(n) e_1 and e_2 and dots and e_n$
\ \ 
\ 
#def внешняя степень оператора\
Внешняя степень оператора $phi$ --- лиphiйное отображение вида:
$ t phi(and p): and.big_(i=1)^p X -> and.big_(i=1)^p X $\
$ phi^(and p) (x_1 and x_2 and dots and x_p) = phi x_1 and phi x_2 and dots and phi x_p $
\
#def определитель линейного оператора\
Определитель линейного оператора $phi$ --- величина $det phi$, такая, что:
$ phi(e_1 and e_2 and dots and e_n) = phi e_1 and phi e_2 and dots and phi e_n = det phi e_1 and e_2 and dots and e_n $
\
#lm
$phi, psi in "End"_K (X) => det (phi apply psi) = det (phi) dot det (psi)$ \ \
#proof
$(phi apply psi) (e_1 and e_2 and dots and e_n) = (phi apply psi) e_1 and (phi apply psi) e_2 and dots and (phi apply psi) e_n = phi(psi(e_1)) and phi(psi(e_2)) and dots and phi(psi(e_n))=$\
$=phi^(and n) (psi e_1 and psi e_2 and dots and psi e_n = det phi dot (psi e_1 and psi e_2 and dots and psi e_n)= det psi dot psi^(and n) (e_1 and e_2 and dots and e_n)=$\
$=det phi dot det psi (e_1 and e_2 and dots and e_n)$
\ \
#nb
Определитель $det phi$ равен определителью матрицы $A_phi$ соответствующего оператора в базисе ${e_i}_(i=1)^n$
\ \
#lm
$det phi$ сто пудов не зависит от базиса // сто пудов это тяжело
\ \
#proof 
$make z in Lambda^n quad => quad phi^(and n) z = det phi dot z $\
если $z = underbracket(alpha space underbracket(e_1 and e_2 and dots and e_n, "верно"), "верно")$
\ \
*ДЗ:* \
// выучить ебаные команды 
$tilde(A)phi - S A_phi T quad quad det S = (det T)^(-1)$