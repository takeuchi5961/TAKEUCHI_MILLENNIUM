-- src/riemann_gap_test.lean
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith

def gap (σ : ℝ) : ℝ := Real.abs (2*σ - 1)

example (σ : ℝ) : gap σ = 0 ↔ σ = 1/2 := by
  unfold gap
  apply Iff.intro
  · intro h
    have : 2*σ - 1 = 0 := Real.abs_eq_zero.mp h
    linarith
  · intro h
    rw [h]
    simp

example (σ : ℝ) (h : σ ≠ 1/2) : gap σ > 0 := by
  unfold gap
  apply Real.abs_pos.mpr
  linarith

example (σ : ℝ) : σ = 1 - σ ↔ σ = 1/2 := by
  apply Iff.intro
  · intro h
    linarith
  · intro h
    linarith

example (σ : ℝ) : gap σ = gap (1 - σ) := by
  unfold gap
  simp [Real.abs_sub, Real.abs_neg]

def complete_contraction (σ : ℝ) : Prop := gap σ = 0

example (σ : ℝ) : complete_contraction σ ↔ σ = 1/2 := by
  unfold complete_contraction
  simp [gap]
  apply Iff.intro
  · intro h
    have : 2*σ - 1 = 0 := Real.abs_eq_zero.mp h
    linarith
  · intro h
    rw [h]
    simp
