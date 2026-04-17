import Demo.Basic.Basic
import Blaster
import CardanoLedgerApi.V3

namespace Demo.Properties
open Basic.Basic
open PlutusCore.Data (Data)
open PlutusCore.ByteString (ByteString)
open PlutusCore.UPLC.Utils
open CardanoLedgerApi.V3 (ScriptContext spendingInputs)

set_option warn.sorry false

-- theorem successful_imp_valid_params :
--   ∀ (params1 params2 params3 : Data) (ctx : ScriptContext),
--      isSuccessful (appliedBasic.prop params1 params2 params3 ctx) →
--      isMatchingParams params1 params2 params3 := by blaster
theorem successful_imp_valid_params :
  ∀ (params1 params2 params3 : Data) (ctx : ScriptContext),
     isSuccessful (appliedBasic params1 params2 params3 ctx) →
     isMatchingParams params1 params2 params3 := by blaster

-- theorem matching_params_imp_successful :
--   ∀ (param1 param2 param3 ctx : Data),
--     isMatchingParams param1 param2 param3 →
--     isSuccessful (appliedBasic param1 param2 param3 ctx) := by blaster

-- -- Counterexample expected: partial match (only second element) does not guarantee success
-- theorem partial_match_imp_successful :
--   ∀ (param1 param2 param3 ctx : Data),
--     isPartialMatchBasic param1 param2 param3 →
--     isSuccessful (appliedBasic param1 param2 param3 ctx) := sorry

-- #blaster (solve-result: 1) [partial_match_imp_successful]

-- -- Counterexample expected: the validator can succeed, so it cannot always fail
-- theorem always_fails :
--   ∀ (param1 param2 param3 ctx : Data),
--     ¬ isSuccessful (appliedBasic param1 param2 param3 ctx) := sorry

-- #blaster (solve-result: 1) [always_fails]

end Demo.Properties
