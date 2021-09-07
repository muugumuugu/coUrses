# ./ lecture 31
---

---
## open sets
---
### imp prop of open intervals

property
  :  
- \(a<b\in \mathbb{R} :\forall x \in (a,b),\exists r>0,\)<br>
\(\ni(x-r,x+r) \subseteq (a,b) \)
- \( \)

proof
  :  
- for any point within the interval there exists a non empty open interval arounnd it within the parent interval .
- given \(x \in (a,b) \)<br> set \(r= \min \{b-x,x-a\}>0\)
- claim \((x-r.x+r) \subseteq(a,b)\)
- let \( y \in (x-r,x+r) \ni x-r<y<x+r\) <br> since \( r \le b-x, \)\(\Rightarrow x+r\le b\)<br> similarly \( r \le x-a, \)\(\Rightarrow x-r\ge a\)<br> \(\therefore (x-r,x+r) \subseteq (a,b)\)

complete extension to unions
  :  
- taking any **(countable or uncountable)** collection \(\{(a _{\alpha}, b _{\alpha}):\alpha \in \Omega\}\) of open intervals indexed by alpha.
- claim that if \(x \in \bigcup_{\alpha \in \Omega}{(a_\alpha,b_\alpha)}\), then \( \exists r >0 \ni (x-r,x+r)\subseteq \bigcup_{\alpha \in \Omega} (a_\alpha,b_\alpha) \)
- proof
    - let \(x \in \bigcup_{\alpha \in \Omega}{(a_\alpha,b_\alpha)}\)\(\Rightarrow \exists \alpha_0 \in  \Omega \ni x \in (a_{\alpha_0},b_{\alpha_0})\)
    -  \( \therefore \exists r >0 \ni (x-r,x+r) \subseteq (a_{\alpha_0},b_{\alpha_0})\subseteq  \bigcup_{\alpha \in \Omega}({a_\alpha,b_\alpha)}\)

extension to finite intersections
  : 
- taking any **(finite)** collection \(\{(a _{i}, b _{i}): i = \mathit{1,2,3} \dots n\}\) of open intervals indexed by \(i\).
- let \(x  \in \bigcap\limits_{i=1}^{n}{(a_i,b_i)}\)\(\Rightarrow \forall i=\mathit{1,2,3}\dots n\), \(x \in (a_i,b_i)\)
- \(\therefore \exists r_i>0: i=\mathit{1,2,3,\dots n} \ni (x-r_i,x+r_i)\subseteq (a_i,b_i)\)
- set \(r=\min{\{r_1,r_2,\dots r_n\}} \ni r\le r_i \forall i=\mathit{1,2,3,\dots n}\) and by **finiteness**, \(r>0\)
- claim that \((x-r,x+r)\subseteq\bigcap\limits_{i=1}^n{(a_i,b_i)}\)
- proof
    - let \(y \in (x-r,x+r) \ni x-r<y<x+r \)
    -  \(\Rightarrow \forall i = \mathit{1,2,3,\dots n}\), \(a_i<x-r_i<x-r<y<x+r<x+r_i<b_i \)
    -  i.e  \(y \in (a_i,b_i)\forall i=\mathit{1,2,3,\dots n} \therefore y \in (x-r,x+r) \Rightarrow  y \in \bigcap\limits_{i=1}^n{(a_i,b_i)}\)
    - \(\therefore (x-r,x+r) \in  \bigcap\limits_{i=1}^n{(a_i,b_i)}\)
---
### defining open sets extending from open intervals

def
  : a set \(\mathcal{O}\subseteq \mathbb{R}\) is open in \(\mathbb{R}\) if \(\forall x \in \mathcal{O}\) \( \exists r>0 \ni (x-r,x+r) \subseteq \mathcal{O}\)
---
### continuity

theorem
  : A function \(f\) is continous if for every open set in its Image , the pre-image of that interval is open its Domain.

claim in \(\mathbb{R}\)
  : 
- \(f : \mathbb{R} \to \mathbb{R} \\) is continous if
