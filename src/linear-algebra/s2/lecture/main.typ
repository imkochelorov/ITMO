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
    "ikochelorov"
  ),
  date: "зима/весна 2024",
  subtitle: "Лектор: 
  Трифанов Александр Игоревич"
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
#let apply=$space circle.small space$

// спойлеры: 1. Полилинеальная и тензорная геометрия, 2. Спектральная теория типов, 3. Евклидова геометрия

= Полилинейная и тензорная алгебра

== Перестановки
_см. курс дискретной математики первого семестра_

== Пространство полилинейных форм (пространство ПЛФ)

$make X(K)$ --- ЛП над $K$, $dim_K X=n, $\
$make X^* (K)$ --- пр-во ЛФ над $X(K)$
\ \
#def полилинейная форма \
ПЛФ называется отображение \
$u: limits(underbrace(X times X times dots times X))_p times limits(underbrace(X^* times X^* times dots times X^*))_q -> K$\
Обладающее следующщими свойствами (полилинейность - _линейность по всем агрументам_):\
1. $u(...space x_1 + x_2 space... ) = u (... space x_1 space ...) + u (... space x_2 space ...)$
2. $u(dots, lambda x, dots) = lambda u(dots, x, dots)$

#nb пара $(p, q)$ --- валентность ПЛФ
\ \
#exs 
1. $f in X^*(k)$ --- ПЛФ $(1, 0)$
2. $hat(x) in X^(**)$ --- ПЛФ $(0, 1)$
3. $E_3 quad g(x, space y) = dp(x, y)$ --- ПФЛ $(2, 0)$
4. $E_3 quad omega (x, space y, space z)$ --- ПЛФ $(3, 0)$

#nb $make Omega_p^q$ --- мн-во ПЛФ $(p, q)$
\ \
1. Равенство линейных форм
$ u, v in Omega_p^q : u = v <=> u(x_1, space x_2, space dots, space y^1, space y^2, space dots, space y^q) = v(x_1, space x_2, space dots, space y^1, space y^2, space dots, space y^q) \ forall x_1, space dots,  x_p in X, space  y^1, space  dots, space  y^q in X^* $

2. Сумма линейных форм \
$ omega = u + v <=> omega(x_1, space dots, space x_p, space y^1, space dots, space y^q)=(u+v)(x_1, space dots, space x_p, space y^1, space dots, space y^q) =\ u(x_1, space dots, space x_p, space y^1, space dots, space y^q) +v(x_1, space dots, space x_p, space y^1, space dots, space y^q) $\
$forall u, space  v, space  omega quad u+(v+omega)=(u+v)+omega $ --- _ассоциативность_\
  $exists theta in Omega_p^q quad theta(x_1, dots, x_p,y^1 dots y^q)=0, quad forall u quad u+theta=u=theta+u$ -- _существование нейтрального_\
  $forall u quad exists (-u): u+(-u)=theta$ --- _существование обратного_

3. Произведение ПЛФ на скаляр  $ w=lambda u <=> w(x_1, space dots, space x_p, space y^1, space dots, space y^q)=(lambda u)(x_1, space dots, space x_p, space y^1, space dots, space y^q) = lambda u(x_1, space dots, space x_p, space y^1, space dots, space y^q) $ // не наврал?...

#th \ $Omega_p^q = Omega_p^q (K)$ --- ЛП
\ \
#proof
Проверка аксиом ЛП $qed$

== Тензор ПЛФ

$make {e_i}_(i=1)^n$ --- базис $X(K), {f^j}_(j=1)^n$ --- базис $X^* (K)$\
$see (x_1, space dots, space x_p, space y^1, space dots, space y^q) eq.circle$\ \
$x_1 = sum_(i_1 = 1)^n xi_1^(i_1) e_i_1 quad dots quad x_p=sum_(i_p=1)^n xi_1^(i_p) e_i_p$\ \
$y_1 = sum_(i_1 = 1)^n mu_(j_1)^1 f ^(j_1) quad dots y^q = sum_(i_p=1)^n mu_(j_1)^(q) f^(j_q)$\ \
$eq.circle u(sum_(i_1 = 1)^n xi_1^(i_1) e_i_1 dots =sum_(i_p=1)^n xi_1^(i_p) e_i_p; sum_(j_1 = 1)^n mu_(j_1)^1 f ^(j_1) dots sum_(j_q = 1)^n mu_(j_q)^1 f ^(j_q))$\ \
$=sum_(i_1 = 1)^n dots sum_(i_p = 1)^n sum_(j_1 = 1)^n dots sum_(j_q = 1)^n xi_1^(i_1) dots xi_p^(i_p) mu_(j_1)^1 dots mu_(j_q)^q quad u(e_i_1 dots e_i_p f^(j_1) dots f^(j_q)) dots f^(j_q) = u_(i_1 dots i_p)^(j_1 dots j_q)$ --- _тензор линейной формы (сумма произведений координат)_\ \
$=xi_1^(i_1) dots xi_p^(i_p) mu_(j_1)^1 dots mu_(j_q)^q u_(i_1 dots i_p)^(j_1 dots j_q)$

\ \
#lm
Знание тензора $u_(i_1 dots i_p)^(j_1 dots j_q)$ в паре базисов пр-в $X$ и $X^*$ эквивалентно заданию самой ПЛФ $u$: $ u <->_({f^j})^({e_i}) u_(i_1 dots i_p)^(j_1 dots j_q) $
#proof
cм. выше. $qed$

== Базис пространства ПЛФ
$Omega_p^q (K)$ --- пространство ПЛФ над полем $K$
\ \
#nb $"Mat"_K (2) quad limits(mat(1,0;0,0))^(=e^1)_(=e_11), space limits(mat(0,1;0,0))^(=e_2)_(=e_12), space limits(mat(0,0;1,0))^(=e_3)_(=e_21), space limits(mat(0,0;0,1))^(=e_4)_(=e_22)$

\
$(e_11)_(i j)=attach(e, bl: 11, tr: i j)$\ \

$attach(e, bl: alpha beta, tr: i j) = delta_alpha^i delta_beta^j = cases(1\, i = alpha\, j = beta, 0\, "иначе")$\

\ \
$see {attach(W, tl: s_1 s_2 dots s_p space, bl: t_1 t_2 dots t_q space)}$ --- набор ПЛФ в $Omega_p^q (K)$\ \ 
$attach(W, tl: s_1 s_2 dots s_p space, bl: t_1 t_2 dots t_q space ) (x_1 dots x_p; y^1 dots y^q)=xi_1^(s_1) xi_2^(s_2) dots xi_p^(s_p) xi_p^(s_p) mu_(t_1)^1 dots mu_t_q^q$
\ \
#nb $attach(W, tl: s_1 dots s_p space, bl: t_1 dots t_q space, tr: space j_1 dots j_q, br: space  i_1 dots i_p) = delta_(i_1)^(s_1) dots delta_(i_p)^(s_p) delta_(t_1)^(j_1) dots delta_(t_q)^(j_q)$
\ \
#th \
Набор ${attach(W, tl: s_1 s_2 dots s_p space, bl: t_1 t_2 dots t_q space)}$ --- базис в $Omega_p^q (K)$\ \ 
#proof
_Докажем полноту_\
$exists u in Omega_p^q (K)$\
$see u(x_1 dots x_p, y^1 dots y^q=xi_1^(i_1) dots xi_p^(i_p) mu_(j_1)^1 dots mu_(j_q)^q u_(i_1 dots i_p)^(j_1 dots j_q)=attach(W, tl: i_1 dots i_p space, bl: j_1 dots j_q space) (x_1  dots x_p y^1 dots y^q) u_(i_1 dots i_p)^(j_1 dots j_q)$\
$=> u=attach(W, tl: i_1 dots i_p space, bl: j_1 dots j_q space) u_(i_1 dots i_p)^(j_1 dots j_q)$
\ \
_Докажем ЛНЗ_\
$see attach(W, tl: s_1 s_2 dots s_p space, bl: t_1 t_2 dots t_q space) alpha_(s_1 dots s_p)^(t_1 dots t_q) = theta | (e_i_1 dots e_i_p, f^(j_1) dots f^(j_q))$\ \
$attach(W, tl: s_1 s_2 dots s_p space, bl: t_1 t_2 dots t_q space) (e_i_1 dots e_i_p f^(j_1) f^(j_q)) alpha_(s_1 dots s_p)^(t_1 dots t_q) = 0$\ \
$delta_(i_1)^(s_1) delta_(i_p)^(s_p) delta_(t_1)^(j_1) delta_(t_q)^(j_q) alpha_(s_1 dots s_p)^(t_1 dots t_q) = 0$\
$alpha_(i_1 dots i_p)^(j_1 dots j_q) = 0 => alpha = 0 qed$
\ \
#nb $dim_K Omega_p^q = n^(p+q)$

= Симметричные и антисимметричные ПЛФ
$see Omega_p^0(K)$\
#def симметрическая форма \ Форма $u in Omega_p^0 (K)$ --- симметрическая, если ее значения не зависят от порядка аргументов
 
$ u(x_sigma(1) x_sigma(2) dots x_sigma(p)) = u(x_1 space x_2 space dots space  x_p) \ forall sigma in S_P italic("(симметрическая группа перестановок)") $
\ \
#ex \ $E_3 (RR) space g(x, y) = dp(x, y) quad g(x, y) = g(y, x)$
\ \
#lm $make u$ --- симметричная $=> u_(i_1 dots i_p) = u_(i_sigma(1) dots i_sigma(p))$
\ \
$make Sigma^p$ --- множество симметричных форм
#image("1.png", width: 30%)
\
#lm  $Sigma^p = Sigma^p (K) <= Omega_p^0 (K)$
\ \
#def антисимметричная форма \ $V in Omega_p^0 (K)$ --- антисимметричная, если $forall sigma in S_p quad v(x_(sigma(1)dots sigma(2))) = (-1)^([sigma] - "чётность") v(x_1 space x_2 dots x_p)$
\ \
#ex\  $E_3, omega(x, y, z) = (x, y, z), omega(x, z, y) = -omega(x, y, z)$
\ \
#lm Тензор антисимметричной формы антисимметричен по индексам $ v_(i_sigma(1) dots i_sigma(p)) = (-1)^([sigma]) v_(i_1 dots i_p) $
\
$make Lambda$ --- мн-во антисимм форм
\ \
#lm
$Lambda^p = Lambda^p (K) <= Omega_p^0 (K)$
\ \
#nb
$Lambda^p sect Sigma^p = theta$
\ \
#lm
$v in Lambda^p <=> v$ обнуляется на паре одинаковых аргументов 
\ \
#proof
$arrow.l.double: see v(dots x_i dots x_i dots) = -v(dots x_i dots x_i dots) => v=0$\
$=>: see v(dots x'_1 + x''_i dots x'_j+x''_j dots)=0$\
$v(dots x'_1 dots x'_1 dots) + v(dots x'_1...x''_1 dots + v(dots x''_1 dots x'_1 dots) + v(dots x''_1 dots x''_1 dots) = 0$\
$v(dots x'_1 dots x''_i dots) = -v(dots x''_1 dots x'_1 dots) qed$
\ \
#lm
${x_i}_(i=1)^p$ --- ЛЗ $=> forall v in Lambda^p (K) quad v(x_1 dots x_p)=0$
== Симметризация и антисимметризация
$make W in Omega_p^0 (K), quad K : "char"  K = 0 quad (QQ$ и "больше") \ \
\
#lm
Следующая форма является симметричной
$ u(x_1 dots x_p) = 1/p! sum_(sigma in s_p) W(x_sigma(1) dots x_sigma(p)) $

#proof
$see u(x_chi(1) dots x_chi(p)) = 1/p! sum_(sigma in s_p) W(x_(sigma chi(1)) dots x_(sigma xi(p))) = $\
$angle.l sigma apply chi = phi, quad sigma = phi apply chi^(-1) angle.r$\
$= 1/p! sum_(phi apply chi^(-1)\ phi in s_p) W(x_phi(1) dots x_phi(p)) = u(x_1 dots x_p) qed$
\ \ \
#def симметризация\
Процесс изготовления симметрической формы из произвольной\
$ ("Sym" W)(x_1 dots x_p) = 1/p! sum_(sigma in S_P)W(x_(sigma(1)) dots x_sigma(p)) $
\ \
#nb Коэффициент $1/p!$ --- нормировка: $W in Sigma^p => "Sym" W = W$
\ \
#nb
$"Sym" "Sym" = "Sym"$\
$"Sym" (u+v)="Sym" u + "Sym" v$\
$"Sym" (lambda u) = lambda "Sym"(u)$
\ \
#lm
Следующая форма является антисимметричной  $ v(x_1 dots x_p) = 1/p! sum_(sigma in S_p) (-1)^[sigma] W(x_sigma(1) dots x_sigma(p)) $\
\
#def антисимметризация (альтернирование)\ 
Процесс изготовления антисимметричной формы из произвольной

$ ("Alt" W) (x_1 dots x_p) = 1/p! sum_(sigma in S_p) 
(-1)^[sigma]W(x_sigma(1) dots x_sigma(p)) $
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
$dim _k Lambda ^p = space ?$\
$make {attach(W, tl: s_1 dots s_p space)}$ --- базис в $Omega_p^0(K)$\ \
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
\ $= U(x_1, dots, x_p; y^1, dots, y^(p_1)) dot V(x_(p_1 + 1), dots, x_(p_1 + p_2); y ^(q_1), dots, y^(q_1 + q_2)$
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
#ex \ \А\л\г\е\б\р\а \м\н\о\г\о\ч\л\е\н\о\в // \w\t\f why tho
