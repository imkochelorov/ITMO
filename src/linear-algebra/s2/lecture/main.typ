#import "../../../template.typ": *

#set page(margin: 0.55in, height: 3000pt)
#set par(leading: 0.55em, first-line-indent: 0em)
#set heading(numbering: "1.1.")
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

// спиздить мб оформление с матана?

= Полилинейная и тензорная алгебра

== Перестановки
_см. курс дискретной математики первого семестра_

== Пространство полилинейных форм (пространство ПЛФ)

//=== Определения

$make X(K)$ --- ЛП над $K$, $dim_K X=n, $\
$make X^* (K)$ --- пр-во ЛФ над $X(K)$
\ \
#def полилинейная форма \
ПЛФ называется отображение \
$u: limits(underbrace(X times X times dots times X))_p times limits(underbrace(X^* times X^* times dots times X^*))_q -> K$\
Обладающее следующщими свойствами (полилинейность - _линейность по всем агрументам_):\
1. $u(...space x_1 + x_2 space... ) = u (... space x_1 space ...) + u (... space x_2 space ...)$
2. $u(dots, lambda x, dots) = lambda u(dots, x, dots)$

#nb \ пара $(p, q)$ --- валентность ПЛФ
\ \
#exs 
1. $f in X^*(k)$ --- ПЛФ $(1, 0)$
2. $hat(x) in X^(**)$ --- ПЛФ $(0, 1)$
3. $E_3 quad g(x, space y) = dp(x, y)$ --- ПФЛ $(2, 0)$
4. $E_3 quad omega (x, space y, space z)$ --- ПЛФ $(3, 0)$

#nb \ $make Omega_p^q$ --- мн-во ПЛФ $(p, q)$
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
// its over
// owari da
\ \
#lm\
Знание тензора $u_(i_1 dots i_p)^(j_1 dots j_q)$ в паре базисов пр-в $X$ и $X^*$ эквивалентно заданию самой ПЛФ $u$: $ u <->_({f^j})^({e_i}) u_(i_1 dots i_p)^(j_1 dots j_q) $
#proof
cм. выше. $qed$

== Базис пространства ПЛФ
$Omega_p^q (K)$ --- пространство ПЛФ над полем $K$
\ \
#nb \ $"Mat"_K (2) quad limits(mat(1,0;0,0))^(=e^1)_(=e_11), space limits(mat(0,1;0,0))^(=e_2)_(=e_12), space limits(mat(0,0;1,0))^(=e_3)_(=e_21), space limits(mat(0,0;0,1))^(=e_4)_(=e_22)$
//ебать блять что происходит нахуй 
// тензорочки
\
$(e_11)_(i j)=attach(e, bl: 11, tr: i j)$\ \
// че за хуйня
$attach(e, bl: alpha beta, tr: i j) = delta_alpha^i delta_beta^j = cases(1\, i = alpha\, j = beta, 0\, "иначе")$\
// а можно не надо
//пиздец. +
\ \
$see {attach(W, tl: s_1 s_2 dots s_p space, bl: t_1 t_2 dots t_q space)}$ --- набор ПЛФ в $Omega_p^q (K)$\ \ // это пиздец
//пиздец
$attach(W, tl: s_1 s_2 dots s_p space, bl: t_1 t_2 dots t_q space ) (x_1 dots x_p; y^1 dots y^q)=xi_1^(s_1) xi_2^(s_2) dots xi_p^(s_p) xi_p^(s_p) mu_(t_1)^1 dots mu_t_q^q$
\ \
#nb \ \ $attach(W, tl: s_1 dots s_p space, bl: t_1 dots t_q space, tr: space j_1 dots j_q, br: space  i_1 dots i_p) = delta_(i_1)^(s_1) dots delta_(i_p)^(s_p) delta_(t_1)^(j_1) dots delta_(t_q)^(j_q)$
\ \
#th \ \
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
#nb \ $dim_K Omega_p^q = n^(p+q)$

= Симметричные и антисимметричные ПЛФ
$see Omega_p^0(K)$\
#def симметрическая форма \ Форма $u in Omega_p^0 (K)$ --- симметрическая, если ее значения не зависят от порядка аргументов
 
$ u(x_sigma(1) x_sigma(2) dots x_sigma(p)) = u(x_1 space x_2 space dots space  x_p) \ forall sigma in S_P italic("(симметрическая группа перестановок)") $
\ \
#ex \ $E_3 (RR) space g(x, y) = dp(x, y) quad g(x, y) = g(y, x)$
\ \
#lm \ $make u$ --- симметричная $=> u_(i_1 dots i_p) = u_(i_sigma(1) dots i_sigma(p))$
\ \
$make Sigma^p$ --- множество симметричных форм
#image("1.png", width: 30%)
\
#lm\  $Sigma^p = Sigma^p (K) <= Omega_p^0 (K)$
\ \
#def антисимметричная форма \ $V in Omega_p^0 (K)$ --- антисимметричная, если $forall sigma in S_p quad v(x_(sigma(1)dots sigma(2))) = (-1)^([sigma] - "чётность") v(x_1 space x_2 dots x_p)$
\ \
#ex\  $E_3, omega(x, y, z) = (x, y, z), omega(x, z, y) = -omega(x, y, z)$
\ \
#lm \ Тензор антисимметричной формы антисимметричен по индексам $ v_(i_sigma(1) dots i_sigma(p)) = (-1)^([sigma]) v_(i_1 dots i_p) $
\
$make Lambda$ --- мн-во антисимм форм
\ \
#lm \
$Lambda^P = Lambda^P (K) <= Omega_p^0 (K)$
\ \
#nb \
$Lambda^p sect Sigma^p = theta$
\ \
#lm\
$v in Lambda^p <=> v$ обнуляется на паре одинаковых аргументов 
\ \
#proof
$arrow.l.double: see v(dots x_i dots x_i dots) = -v(dots x_i dots x_i dots) => v=0$\
$=>: see v(dots x'_1 + x''_i dots x'_j+x''_j dots)=0$\
$v(dots x'_1 dots x'_1 dots) + v(dots x'_1...x''_1 dots + v(dots x''_1 dots x'_1 dots) + v(dots x''_1 dots x''_1 dots) = 0$\
$v(dots x'_1 dots x''_i dots) = -v(dots x''_1 dots x'_1 dots) qed$
\ \
#lm
${x_i}_(i=1)^p$ --- ЛЗ $=> forall v in Lambda^P (K) quad v(x_1 dots x_p)=0$
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


== Базис $Lambda^P$
$dim _k Lambda ^p = space ?$\
$make {attach(W, tl: s_1 dots s_p space)}$ --- базис в $Omega_p^0(K)$\
$see attach(F, tl: s_1 dots s_p)= p!"Alt"(attach(W, tl:s_1 dots s_p))$\
${attach(F, tl: s_1 dots s_p)}$ --- набор в $Lambda^P$ --- ПН, но не ЛНЗ
\ \
#lm Форма $attach(F, tl: s_1 dots s_p)$ --- антисимметрична по своим индексам\
$attach(F, tl: dots s_i dots s_j dots) = - attach(F, tl: dots s_j dots s_i dots)$
\ \
#proof 
$D attach(F, tl: dots s_i dots s_j dots) (dots x_i dots x_j dots) = p!"Alt" attach(W, tl: dots s_i dots s_j dots) (dots x_i dots x_j dots)=p!("Alt" attach(W, tl: dots s_i dots s_j dots))(dots x_i dots x_j dots) =$$=-p! ("Alt" attach(W, tl: dots s_j dots s_i dots))(dots x_i dots x_j dots)=-attach(F, tl: dots s_j dots s_i dots) (dots x_i dots x_j dots)$ // я на практику пойду, увидимся