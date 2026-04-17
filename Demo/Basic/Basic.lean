import PlutusCore.UPLC
import CardanoLedgerApi.V3

namespace Demo.Basic.Basic
open PlutusCore.UPLC.ScriptEncoding
open PlutusCore.UPLC.Term
open PlutusCore.UPLC.CekMachine
open PlutusCore.Data (Data)
open PlutusCore.ByteString (ByteString)
open PlutusCore.List
open CardanoLedgerApi.IsData.Class (toTerm)
open CardanoLedgerApi.V3 (ScriptContext spendingInputs)

set_option pp.rawOnError true
set_option diagnostics true
set_option maxRecDepth 10000000
set_option diagnostics.threshold 4

def parseFlatHexUplc (filename : String) : IO Program := do
  let path := System.FilePath.mk filename
  let content ← IO.FS.readFile path
  let content' := String.trim content
  return flatEncodedScriptFromHex! content'

-- Load the basic script from file at initialization time
-- #import_uplc basic PlutusV3 flat_hex "Demo/Basic/demo.flat"
initialize basic : Program ← parseFlatHexUplc "Demo/Basic/demo.flat"

-- param1 encodes a Pair<ByteArray, ByteArray> as Data.List [Data.B b1, Data.B b2]
-- param2 and param3 are the expected ByteArrays; ctx is ignored by the validator
def scriptInputs (params1 params2 params3 : Data) (ctx : ScriptContext) : List Term :=
  toTerm params1 :: toTerm params2 :: toTerm params3 :: spendingInputs ctx

-- #prep_uplc appliedBasic basic scriptInputs 10000
def appliedBasic (params1 params2 params3 : Data) (ctx : ScriptContext) :=
  cekExecuteProgram basic (scriptInputs params1 params2 params3 ctx) 10000

-- Success condition: param1's first two bytes equal param2 and param3 respectively
def isMatchingParams : Data → Data → Data → Prop
  | .List (.B b1 :: .B b2 :: _), .B p2, .B p3 => b1 = p2 ∧ b2 = p3
  | _, _, _ => False

-- Weaker predicate: only checks second element matches param3 (for counterexample)
def isPartialMatchBasic : Data → Data → Data → Prop
  | .List (.B _ :: .B b2 :: _), .B _, .B p3 => b2 = p3
  | _, _, _ => False

end Demo.Basic.Basic
