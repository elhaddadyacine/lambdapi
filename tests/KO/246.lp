symbol const Type : TYPE
symbol injective eta : Type ⇒ TYPE

// function type
symbol const Ar : Type ⇒ Type ⇒ Type
set infix right 6 ">" ≔ Ar
rule eta (&a > &b) → eta &a ⇒ eta &b

definition fst : ∀ (A B : Type), eta (A > B > A) ≔
  λ A B a b, a

definition snd : ∀ (A B : Type), eta (A > B > B) ≔
  λ A B a b, a
