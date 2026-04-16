import PlutusCore.UPLC

namespace Demo.Basic
open PlutusCore.UPLC.ScriptEncoding
open PlutusCore.UPLC.Term
open PlutusCore.UPLC.CekMachine
open PlutusCore.Data (Data)
open PlutusCore.ByteString (ByteString)
open PlutusCore.List

#import_uplc oraclePrice PlutusV3 flat_hex "Demo/demo.flat"

def hello := "world"

end Demo.Basic
