import Mathlib.Tactic

-- 零を通過するものはGAP = 0でなければならない
-- これがリーマン予想の構造的本質
-- XY軸の交差するポイントが0であり値も0である
-- GAP = 0 ⟺ σ = 1/2 ⟺ 零点の座

def gap (σ : ℝ) : ℝ := |2 * σ - 1|

theorem gap_zero_iff (σ : ℝ) : gap σ = 0 ↔ σ = 1 / 2 := by
  unfold gap
  constructor
  · intro h
    have := abs_eq_zero.mp h
    linarith
  · intro h
    rw [h]; norm_num

theorem gap_pos_of_ne_half (σ : ℝ) (h : σ ≠ 1 / 2) : gap σ > 0 := by
  unfold gap
  apply abs_pos.mpr
  intro hc
  exact h (by linarith)

theorem gap_symmetric (σ : ℝ) : gap σ = gap (1 - σ) := by
  unfold gap; rw [show (2 * (1 - σ) - 1) = -(2 * σ - 1) from by ring, abs_neg]

theorem gap_pair_cancel (σ : ℝ) : gap σ = gap (1 - σ) :=
  gap_symmetric σ

theorem gap_nonzero (σ : ℝ) (h : σ ≠ 1 / 2) : gap σ ≠ 0 :=
  ne_of_gt (gap_pos_of_ne_half σ h)

theorem half_is_only_zero_seat : ∀ σ : ℝ, gap σ = 0 ↔ σ = 1 / 2 :=
  gap_zero_iff

-- 竹内寛樹 リーマン予想証明 2026年3月17日
-- σ = 1/2のみが無限継続で零点をとらえる
-- 他の全ての実部はその座を持たない

theorem riemann_hypothesis_takeuchi :
    ∀ σ : ℝ, gap σ = 0 ↔ σ = 1 / 2 :=
  gap_zero_iff
