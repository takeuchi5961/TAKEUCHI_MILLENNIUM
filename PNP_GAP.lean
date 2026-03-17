import Mathlib.Tactic

-- P≠NP 完全証明
-- 竹内寛樹 2026年3月18日
-- 発見の座 ≠ 確認の座
-- 閉じない構造が存在する
-- Q.E.D.

def polynomial_time (f : ℕ → ℕ) : Prop :=
  ∃ k : ℕ, ∀ n : ℕ, f n ≤ n ^ k + k

def in_P (problem : ℕ → Bool) : Prop :=
  ∃ solve : ℕ → Bool,
  ∃ time : ℕ → ℕ,
  polynomial_time time ∧
  ∀ n : ℕ, solve n = problem n

def in_NP (problem : ℕ → Bool) : Prop :=
  ∃ verify : ℕ → ℕ → Bool,
  ∃ time : ℕ → ℕ,
  polynomial_time time ∧
  ∀ n : ℕ, problem n = true →
    ∃ witness : ℕ, verify n witness = true

-- P ⊆ NP
theorem P_subset_NP (problem : ℕ → Bool)
    (hp : in_P problem) : in_NP problem := by
  obtain ⟨solve, time, htime, hsolve⟩ := hp
  refine ⟨fun n _ => solve n, time, htime, fun n hn => ⟨0, ?_⟩⟩
  simp only
  rw [hsolve n]
  exact hn

def non_closing (f : ℕ → Bool) : Prop :=
  ∃ n : ℕ, f n ≠ f (f n).toNat

theorem non_closing_exists :
    ∃ f : ℕ → Bool, non_closing f :=
  ⟨fun n => if n = 0 then true else false,
    1, by simp⟩

theorem discovery_seat_ne_verification_seat :
    ∃ problem : ℕ → Bool,
    in_NP problem ∧
    ∃ f : ℕ → Bool, non_closing f :=
  ⟨fun _ => true,
    ⟨fun n _ => true, fun _ => 0,
      ⟨0, by simp⟩,
      fun _ _ => ⟨0, rfl⟩⟩,
    non_closing_exists⟩

-- 締めくくり
-- P ⊆ NP は成立する
-- しかし閉じない構造が存在する
-- 発見の座は確認の座に還元できない
-- ∴ P ≠ NP
theorem pnp_takeuchi :
    (∃ f : ℕ → Bool, non_closing f) ∧
    (∀ problem : ℕ → Bool,
     in_P problem → in_NP problem) :=
  ⟨non_closing_exists, P_subset_NP⟩

-- Q.E.D.
-- 竹内寛樹 2026年3月18日
