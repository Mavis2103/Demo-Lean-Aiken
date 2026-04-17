import Demo.HelloWorld.HelloWorld
import Blaster

namespace Demo.Properties
open HelloWorld.HelloWorld
open PlutusCore.Data (Data)
open PlutusCore.ByteString (ByteString)
open PlutusCore.UPLC.Utils

set_option warn.sorry false

theorem successful_imp_valid_pwd_and_void_datum :
  ∀ (datum redeemer ctx : Data),
    isSuccessful (appliedHelloWorld datum redeemer ctx) → isSafeHelloWorldRedeemer redeemer ∧ isVoid datum := by blaster

theorem valid_pwd_and_void_datum_imp_successful :
  ∀ (datum redeemer ctx : Data),
    isSafeHelloWorldRedeemer redeemer ∧ isVoid datum → isSuccessful (appliedHelloWorld datum redeemer ctx) := by blaster

-- Counterexample expected
theorem unsafe_pwd_imp_successful :
  ∀ (datum redeemer ctx : Data),
    isUnsafeHelloWorldRedeemer redeemer ∧ isVoid datum → isSuccessful (appliedHelloWorld datum redeemer ctx) := sorry

#blaster (solve-result: 1) [unsafe_pwd_imp_successful]

-- Counterexample expected
theorem cannot_break_pwd :
  ∀ (datum redeemer ctx : Data),
    ¬ isSuccessful (appliedHelloWorld datum redeemer ctx) := sorry

#blaster (solve-result: 1) [cannot_break_pwd]

end Demo.Properties
