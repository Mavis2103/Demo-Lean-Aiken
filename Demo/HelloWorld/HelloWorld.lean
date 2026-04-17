import PlutusCore.UPLC

namespace Demo.HelloWorld.HelloWorld
open PlutusCore.UPLC.ScriptEncoding
open PlutusCore.UPLC.Term
open PlutusCore.UPLC.CekMachine
open PlutusCore.Data (Data)

#import_uplc helloWorld PlutusV1 flat_hex "Demo/HelloWorld/demo.flat"

def scriptInputs (datum redeemer ctx : Data) : List Term :=
  [ Term.Const $ Const.Data datum, Term.Const $ Const.Data redeemer, Term.Const $ Const.Data ctx]

def appliedHelloWorld (datum redeemer ctx : Data) :=
  cekExecuteProgram helloWorld.script (scriptInputs datum redeemer ctx) 10000

def isVoid : Data → Prop
| .Constr 0 [] => True
| _ => False

def isSafeHelloWorldRedeemer : Data → Prop
| .Constr 0 [.B "Hello CTF!" ] => True
| _ => False

def isUnsafeHelloWorldRedeemer : Data → Prop
| .Constr _ [.B "Hello CTF!" ] => True
| _ => False

end Demo.HelloWorld.HelloWorld
