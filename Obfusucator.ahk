/*
;-------------------------------
  AHK Source Code Encryptor v3.5  By FeiYue

  1. This tool can encrypt the AHK script into a self decode script.
     Then you can use Ahk2Exe to compile the script into a program,
     combined with mpress.exe or upx.exe packers.
     Note: To encrypt, or To compile, or To run the script,
     you must have a AutoHotkey.exe in the script directory.

  2. When you want to use the directory relative to the script, don't use
     A_ScriptFullPath, A_ScriptDir, but use A_ScriptFullPath2, A_ScriptDir2.

  3. When you want to Reload your own script, if the Reload command is fail,
     You can use Reload() function instead (it's added when encrypted).

;-------------------------------
*/

#SingleInstance force
ListLines 0
Version := "3.5"

fs:="
(`

; You can compile and set icons by using Ahk2Exe.exe.
; If AutoHotkey.exe wants to change its name to abc.exe,
; please modify Ahk:=A_ScriptDir "\abc.exe"

Ahk:=A_ScriptDir "\AutoHotkey.exe"

#NoTrayIcon
#SingleInstance off
ScriptGuard1()
ScriptGuard1()  ; By TAC109
{
  For i,ahk in ["#1", ">AUTOHOTKEY SCRIPT<"]
  if (rc:=DllCall("FindResource", "Ptr",0, "Str",ahk, "Ptr",10, "Ptr"))
  && (sz:=DllCall("SizeofResource", "Ptr",0, "Ptr",rc, "Uint"))
  && (pt:=DllCall("LoadResource", "Ptr",0, "Ptr",rc, "Ptr"))
  && (pt:=DllCall("LockResource", "Ptr",pt, "Ptr"))
  && (DllCall("VirtualProtect", "Ptr",pt, "Ptr",sz, "UInt",0x40, "UInt*",&rc))
    DllCall("RtlZeroMemory", "Ptr",pt, "UInt",sz)
}

if !(A_IsAdmin || DllCall("GetCommandLine","str")~=" /restart(?!\S)")
{
  Try
  {
    q:=Chr(34)
    if (A_IsCompiled)
      Run "*RunAs " q A_ScriptFullPath q " /restart"
    else
      Run "*RunAs " q A_AhkPath q " /restart " q A_ScriptFullPath q
  }
  ExitApp
}

s:=""
Exec(s, Ahk)
ExitApp

Exec(str, Ahk:="", args:="") {
  static MyFunc:="", base
  if (!MyFunc)
  {
    x32:="5557565381ec1c0200008bbc24300200008b1f8b433c01d866813b4d5a0f85b6"
    . "0b00008138504500000f85aa0b00008b7704668178180b01b988000000ba7800"
    . "00008b6f0c897424348b77080f45d1897424508b7710897424308b3410c78424"
    . "8c0000000000000001de89f08b4e188b761c8b50208b4024897424388944243c"
    . "31c085c98d34137512e9120b0000669083c00139c10f84050b00008b148601da"
    . "813a4765745075e8817a04726f634175df8b74243c8d04430fb704308b742438"
    . "8d04838b343085f689b4248c0000000f84cb0a0000b86500000001dec78424b2"
    . "0000005772697466898424ba0000008d8424b2000000c78424b6000000654669"
    . "6c891c2489442404ffd683ec08894424448d8424d2000000c78424d200000047"
    . "6c6f62c78424d6000000616c416cc78424da0000006c6f630089442404891c24"
    . "ffd683ec0889442458b865650000c78424bc000000476c6f6266898424c40000"
    . "008d8424bc000000c78424c0000000616c4672c68424c600000000891c248944"
    . "2404ffd683ec0889442454b873410000c7842429010000437265616689842435"
    . "0100008d842429010000c784242d01000074655072c78424310100006f636573"
    . "c68424370100000089442404891c24ffd683ec088944245c8d84246a010000c7"
    . "84246a01000043726561c784246e01000074654e61c78424720100006d656450"
    . "c784247601000069706541c684247a0100000089442404891c24ffd683ec0889"
    . "4424608d84247b010000c784247b010000436f6e6ec784247f0100006563744e"
    . "c7842483010000616d6564c784248701000050697065c684248b010000008944"
    . "2404891c24ffd683ec08894424688d8424de000000c78424de000000436c6f73"
    . "c78424e20000006548616ec78424e6000000646c650089442404891c24ffd683"
    . "ec08894424408d8424b4010000c78424b401000051756572c78424b801000079"
    . "506572c78424bc010000666f726dc78424c0010000616e6365c78424c4010000"
    . "436f756ec78424c80100007465720089442404891c24ffd683ec08894424648d"
    . "8424a0000000c78424a00000006c737472c78424a400000063617441c68424a8"
    . "0000000089442404891c24ffd683ec08894424388d8424a9000000c78424a900"
    . "00006c737472c78424ad0000006c656e41c68424b10000000089442404891c24"
    . "ffd683ec088944243c8d8424ea000000c78424ea00000043726561c78424ee00"
    . "000074654669c78424f20000006c65410089442404891c24ffd683ec08894424"
    . "6cb867410000c784248c01000043726561668984249c0100008d84248c010000"
    . "c784249001000074654669c78424940100006c654d61c7842498010000707069"
    . "6ec684249e0100000089442404891c24ffd683ec0889442470b865000000c784"
    . "241b0100004d61705666898424270100008d84241b010000c784241f01000069"
    . "65774fc78424230100006646696c891c2489442404ffd683ec08894424788d84"
    . "245a010000c784245a010000556e6d61c784245e01000070566965c784246201"
    . "0000774f6646c7842466010000696c650089442404891c24ffd683ec08894424"
    . "7c8d8424f6000000c78424f600000047657446c78424fa000000696c6553c784"
    . "24fe000000697a650089442404891c24ffd683ec0889442474b870000000c784"
    . "2492000000536c656566898424960000008d842492000000891c2489442404ff"
    . "d683ec08894424488d842402010000c784240201000045786974c78424060100"
    . "0050726f63c784240a0100006573730089442404891c24ffd683ec088944244c"
    . "8d84240e010000c784240e01000043726561c784241201000074655468c78424"
    . "1601000072656164c684241a0100000089442404891c24ffd683ec088b542434"
    . "85d20f84a1060000e8000000005a8d8a78ecffffeb158d76008dbc2700000000"
    . "83ea0139ca0f8427060000803ab875f0817a016666666675e7c7470400000000"
    . "89542408c744241400000000c744241000000000897c240cc744240400000000"
    . "c7042400000000ffd083ec188d84248c000000c744241000000000c744240800"
    . "000000896c2404c70424000000008944240cff54244483ec148b84248c000000"
    . "85c0894424480f85f60500008b442434890424ff54243c83ec043de27f00000f"
    . "8f370600008b4424308d0485040000003dff7f00008944244c0f868505000089"
    . "84248c00000089442404c7042400000000ff54245883ec0885c089c30f840406"
    . "00008d842498000000c784249f0100005c5c2e5cc78424a301000070697065c7"
    . "8424a70100005c41484bc78424ab01000031323334c78424af01000035363738"
    . "c68424b301000000890424ff54246483ec048b8424980000008db4249f010000"
    . "8934248984248c000000ff54243c83ec048d14068d7c06f88b8c248c00000090"
    . "89c883ea01c1e90483e00f83c041880239fa75ec8b442434bf20220000898c24"
    . "8c000000c60322c64301006689bc24cf000000c78424c700000022202f66c784"
    . "24cb0000006f726365c68424d10000000089442404891c24ff54243883ec088d"
    . "bc24c7000000891c24897c2404ff54243883ec0889742404891c24ff54243883"
    . "ec08897c2404c68424c900000000891c24ff54243883ec08891c24ff54243c83"
    . "ec0489c78b4c2450890c24ff54243c01c783ec0481ffff7f00000f8e4b040000"
    . "8b7c2460c744241c00000000c744241800000000c744241400000000c7442410"
    . "00000000c744240cff000000c744240800000000c744240402000000893424ff"
    . "d783ec2089442438c744241c00000000c744241800000000c744241400000000"
    . "c744241000000000c744240cff000000c744240800000000c744240402000000"
    . "893424ffd783ec2089c7837c2438ff0f843b04000083f8ff0f84320400008d8c"
    . "24cc0100008d942410020000c784248c0000004400000089c88db42600000000"
    . "c6000083c00139d075f68d842438010000c78424cc01000044000000894c2420"
    . "c744241c00000000c74424180000000089442424c744241400000000c7442410"
    . "00000000c744240c00000000c744240800000000895c2404c7042400000000ff"
    . "54245c83ec2885c00f845e0300008b8424380100008b74244089042489f0ffd0"
    . "83ec048b84243c01000089042489f0ffd083ec048b4c243085c9741d31c06690"
    . "8b54850089148383c00139c175f28b44244c83e804894424488b442448c70403"
    . "000000008b442434c744241800000000c744241400000000c744241003000000"
    . "c744240c00000000c744240803000000c744240400000080890424ff54246c83"
    . "ec1c83f8ff89c5894424340f847a010000c744240400000000890424ff542474"
    . "83ec0889c6c744241400000000c744241000000000c744240c00000000c74424"
    . "0802000000c744240400000000892c24ff54247083ec1885c08944243c0f841a"
    . "010000c744241000000000c744240c00000000c744240800000000c744240404"
    . "000000890424ff54247883ec1485c089c10f84d800000089f0ba5917b7d1c784"
    . "24480100006f000000f7e2c784244c01000071000000c7842450010000750000"
    . "00c784245401000077000000c1ea0d69c210270000c1e80285c089c5743aba6f"
    . "00000031c0eb1589f68dbc270000000089c283e2038b94944801000069d28300"
    . "000003148189c683c00183e60339c58994b44801000075d88b74243031d285f6"
    . "74438b7424308d76008dbc270000000089d083e00369ac844801000083000000"
    . "01d589ac84480100008b0493d1c029e8d1c029e88984248c00000089049383c2"
    . "0139d675cb890c24ff54247c83ec048b44243c890424ff54244083ec048b4424"
    . "34890424ff54244083ec048b7424388b6c2468c74424040000000089342489e8"
    . "ffd083ec088934248b74244089f0ffd083ec0489e8c744240400000000893c24"
    . "ffd083ec088d84248c000000c744241000000000895c2404893c248944240c8b"
    . "44244c89442408ff54244483ec1489f0893c24ffd083ec0431c08b54243085d2"
    . "741c8b5424308d76008dbc2700000000c704830000000083c00139c275f2891c"
    . "24ff54245483ec0431c081c41c0200005b5e5f5dc2040089f68dbc2700000000"
    . "b8feffffff81c41c0200005b5e5f5dc2040081c41c020000b8fdffffff5b5e5f"
    . "5dc20400c784248c00000000800000b800800000e96dfaffff81c41c020000b8"
    . "ffffffff5b5e5f5dc204008b442450891c2489442404ff54243883ec08e99efb"
    . "ffffb8fcffffffeb9cc70424e8030000ff54244883ec04c7042400000000ff54"
    . "244c31c083ec04e979ffffff8b4424388b74244089042489f0ffd083ec0489f0"
    . "893c24ffd083ec04891c24ff542454b8f8ffffff83ec04e949ffffffb8fbffff"
    . "ffe93fffffffb8faffffffe935ffffff8b4424388b74244089042489f0ffd083"
    . "ec0489f0893c24ffd083ec04891c24ff542454b8f9ffffff83ec04e905ffffff"
    x64:="4157415641554154555756534881ec280300004c8b39b8ffffffff4989c9418b"
    . "573c4c01fa6641813f4d5a0f852f0a0000813a504500000f85230a000066817a"
    . "180b01b978000000b888000000498b7110498b79084d8b7118498b5920480f44"
    . "c148897424608b040231d2c78424dc000000000000004c01f8448b50208b4818"
    . "8b701c8b68244d01fa85c97511e9e20900004883c20139d10f86d6090000418b"
    . "04924c01f881384765745075e5817804726f634175dc498d04570fb70428498d"
    . "0487448b2c304585ed4489ac24dc0000000f849d09000041b86500000048b857"
    . "7269746546696c4d01fd6644898424280100004c894c2458488d942420010000"
    . "4c89f9488984242001000041ffd5488944245048b8476c6f62616c416c488d94"
    . "24500100004c89f94889842450010000c78424580100006c6f630041ffd541b9"
    . "65650000488944247048b8476c6f62616c46726644898c2438010000488d9424"
    . "300100004c89f94889842430010000c684243a0100000041ffd541ba73410000"
    . "488944246848b843726561746550726644899424cc010000488d9424c0010000"
    . "4c89f948898424c0010000c78424c80100006f636573c68424ce0100000041ff"
    . "d5488944247848b84372656174654e61488d9424f001000048898424f0010000"
    . "48b86d656450697065414c89f948898424f8010000c68424000200000041ffd5"
    . "488984248000000048b8436f6e6e6563744e488d942410020000488984241002"
    . "000048b8616d6564506970654c89f94889842418020000c68424200200000041"
    . "ffd5488984249000000048b8436c6f736548616e488d9424600100004c89f948"
    . "89842460010000c7842468010000646c650041ffd54889c648b8517565727950"
    . "6572488d942470020000488984247002000048b8666f726d616e63654c89f948"
    . "8984247802000048b8436f756e74657200488984248002000041ffd548898424"
    . "8800000048b86c73747263617441488d9424000100004c89f948898424000100"
    . "00c68424080100000041ffd54889c548b86c7374726c656e41488d9424100100"
    . "004c89f94889842410010000c68424180100000041ffd54989c448b843726561"
    . "74654669488d9424700100004c89f94889842470010000c78424780100006c65"
    . "410041ffd5488984249800000048b8437265617465466941bb67410000488984"
    . "243002000048b86c654d617070696e6644899c2440020000488d942430020000"
    . "4c89f94889842438020000c68424420200000041ffd548898424b000000048b8"
    . "4d6170566965774f488d9424b001000048898424b0010000b8650000004c89f9"
    . "c78424b80100006646696c66898424bc01000041ffd548898424c000000048b8"
    . "556e6d6170566965488d9424d001000048898424d001000048b8774f6646696c"
    . "65004c89f948898424d801000041ffd548898424c800000048b847657446696c"
    . "6553488d9424800100004c89f94889842480010000c7842488010000697a6500"
    . "41ffd548898424b8000000b870000000488d9424e00000004c89f9c78424e000"
    . "0000536c656566898424e400000041ffd548898424a000000048b84578697450"
    . "726f63488d9424900100004c89f94889842490010000c7842498010000657373"
    . "0041ffd548898424a800000048b84372656174655468c78424a8010000726561"
    . "6448898424a0010000c68424ac01000000488d9424a00100004c89f941ffd548"
    . "85ff4c8b4c24580f84b9050000e8000000004158498d9078ecffffeb100f1f00"
    . "4983e8014939d00f846e050000418038b875ed418178016666666675e349c741"
    . "080000000031d231c948c744242800000000c744242000000000ffd0488d8424"
    . "dc0000004531c04c89f231c948c74424200000000048898424a00000004989c1"
    . "488b442450ffd08b9424dc000000b8fcffffff85d20f85e50400004889f941ff"
    . "d43de27f00000f8f540500008d049d040000003dff7f0000898424a80000000f"
    . "86dd040000898424dc00000089c231c9488b442470ffd04885c04989c50f8445"
    . "05000048b85c5c2e5c70697065488d8c24f0000000c784246002000035363738"
    . "488984245002000048b85c41484b31323334c684246402000000488984245802"
    . "0000488b842488000000ffd08b8424f0000000898424dc000000488d84245002"
    . "00004889c1488944245841ffd48b8c24dc0000008d50ff448d48f70f1f440000"
    . "89c84189d083ea0183e00fc1e90483c0414439ca428884045002000075e24c8d"
    . "bc2440010000898c24dc00000048b822202f666f726365b92022000041c64500"
    . "2241c64501004889fa66898c244801000048898424400100004c89e9c684244a"
    . "01000000ffd54c89fa4c89e9ffd5488b5424584c89e9ffd54c89fa4c89e9c684"
    . "244201000000ffd54c89e941ffd44189c7488b4c246041ffd44101c74181ffff"
    . "7f00000f8eae0300004c8b6424584531c041b9ff000000ba020000004c8bbc24"
    . "8000000048c744243800000000c744243000000000c7442428000000004c89e1"
    . "c74424200000000041ffd74889c54531c04c89e148c744243800000000c74424"
    . "300000000041b9ff000000c744242800000000c744242000000000ba02000000"
    . "41ffd74883fdff4989c40f847a0300004883f8ff0f8470030000488d8c24b002"
    . "0000c78424dc00000068000000488d51684889c8c600004883c0014839d075f4"
    . "488d84249002000048894c24404531c94531c031c9c78424b002000068000000"
    . "488944244848c7442438000000004c89ea48c744243000000000c74424280000"
    . "0000c744242000000000488b442478ffd085c00f84cc020000488b8c24900200"
    . "00ffd6488b8c2498020000ffd631c04885db742431d2662e0f1f840000000000"
    . "418b0c8641894c85008d42014839c34889c277ec48c1e00241c7440500000000"
    . "004531c94889f948c744243000000000c74424280000000041b803000000c744"
    . "242003000000ba00000080488b842498000000ffd04883f8ff4889c70f846701"
    . "000031d24889c1488b8424b8000000ffd04531c931d24189c648c74424280000"
    . "0000c74424200000000041b8020000004889f9488b8424b0000000ffd04885c0"
    . "4989c70f841b0100004531c94531c04889c148c744242000000000ba04000000"
    . "488b8424c0000000ffd04885c04989c30f84e9000000ba5917b7d14489f0c784"
    . "24e00100006f000000f7e2c78424e401000071000000c78424e8010000750000"
    . "00c78424ec01000077000000c1ea0d4469c21027000041c1e8024585c074404c"
    . "89d9b86f00000031d2eb110f1f44000089d083e0038b8484e001000069c08300"
    . "000003014189d183c2014183e1034883c1044139d04289848ce001000075d131"
    . "c031d24885db744a0f1f8400000000004189d04183e00342698c84e001000083"
    . "00000001d142898c84e00100004d8d448500418b00d1c029c8d1c029c8898424"
    . "dc0000004189008d42014839c34889c277be4c89d9488b8424c8000000ffd04c"
    . "89f9ffd64889f9ffd6488bbc249000000031d24889e94889f8ffd04889e9ffd6"
    . "31d24c89e14889f8ffd04c89ea4c8b8c24a0000000448b8424a80000004c89e1"
    . "48c744242000000000488b442450ffd04c89e1ffd631d231c04885db74166690"
    . "41c7449500000000008d50014839d34889d077ec4c89e9488b442468ffd031c0"
    . "4881c4280300005b5e5f5d415c415d415e415fc3b8feffffffebe5b8fdffffff"
    . "ebdec78424dc00000000800000ba00800000e917fbffff488b5424604c89e9ff"
    . "d5e943fcffffb9e8030000488b8424a0000000ffd0488b8424a800000031c9ff"
    . "d031c0eb9b4889e9ffd64c89e1ffd64c89e9488b442468ffd0b8f8ffffffeb80"
    . "b8fbffffffe976ffffff4889e9ffd64c89e1ffd64c89e9488b442468ffd0b8f9"
    . "ffffffe958ffffffb8faffffffe94effffff9090909090909090909090909090"
    hex:="b866666666" (A_PtrSize=8 ? x64 : x32)
    MyFunc:=Buffer(len:=StrLen(hex)//2)
    Loop len
      NumPut("uchar", "0x" SubStr(hex,2*A_Index-1,2), MyFunc, A_Index-1)
    DllCall("VirtualProtect", "Ptr",MyFunc, "Ptr",len, "uint",0x40, "Ptr*",0)
    base:=DllCall("GetModuleHandle", "Str","Kernel32", "Ptr")
    if FileExist(A_ScriptFullPath)
      EnvSet "My_ScriptFullPath", A_ScriptFullPath
  }
  if (A_IsCompiled)
    Try
      FileInstall "AutoHotkey.exe", Ahk
  Ahk:=!FileExist(Ahk) ? A_AhkPath : Ahk
  if !FileExist(Ahk)
  {
    MsgBox "Can't Find: " Ahk, "Error", 4096
    return
  }
  q:=Chr(34)
  For k,v in A_Args
    args.=" " q v q
  s:=RegExReplace(str,"\s"), RegExReplace(s,"u",,&size)
  str:=Buffer((size+1)*4), s:=SubStr(s,InStr(s,"u")+1)
  Loop Parse, s, "u"
    NumPut("uint", A_LoopField, str, (A_Index-1)*4)
  Param:=Buffer(40)
  , StrPut(v:=Ahk, p1:=StrPtr(Ahk), "CP0")
  , StrPut(v:=args, p2:=StrPtr(args), "CP0")
  For k,v in [base, p1, p2, str.Ptr, size]
    NumPut("Ptr", v, Param, A_PtrSize*(k-1))
  r:=DllCall(MyFunc, "Ptr",Param)
  return r
}

)"

if A_Args.Length
{
  Encrypt(A_Args[1])
  ExitApp
}
_Gui:=Gui("+AlwaysOnTop")
_Gui.BackColor:="DDEEFF"
_Gui.SetFont "cRed s28"
_Gui.Add "Text",, "Drag the AHK script here to Encrypt`n`n"
_Gui.Title:="AHK Source Code Encryptor v" Version "  -  By FeiYue"
_Gui.Show
_Gui.OnEvent("Close", GuiClose)
_Gui.OnEvent("DropFiles", GuiDropFiles)
OnMessage(0x201, LButton_Down)
return

LButton_Down(*) {
  SendMessage 0xA1, 2
}

GuiClose(*) {
  ExitApp
}

GuiDropFiles(GuiObj, GuiCtrlObj, FileArray, *) {
  GuiObj.Opt("+OwnDialogs")
  For i,file in FileArray
  {
    r:=MsgBox("Do you want to encrypt this file ?`n`n" file, "Tip", 4100)
    if (r="Yes")
    {
      Encrypt(file)
      MsgBox "Encryption is completed !", "Tip", 4096
    }
  }
}

Encrypt(file) {
  global fs
  Ahk:=RegExReplace(file,"[^\\]+$") "AutoHotkey.exe"
  if !FileExist(Ahk)
  {
    MsgBox "`nCan't Find:`n`n" Ahk "`n`t", "Error", 4096
    Exit
  }
  q:=Chr(34)
  s:=FileRead(file)
  s:=RegExReplace(Encode(s, Ahk), ".{1,60}", "s.=" q "$0" q "`n")
  s:=RegExReplace(fs, "i)\n[^\n]*Exec\([^\n]+\s+ExitApp", "`n" s "$0")
  f:=RegExReplace(file,"\.[^.\\]+$") . "-encoded.ahk"
  Try FileDelete f
  FileAppend RegExReplace(s,"\R","`r`n"), f, "UTF-8"
}

Encode(s, Ahk) {
  static MyFunc:=""
  if (!MyFunc)
  {
    x32:="5557565383ec108b7c24308b4c24248b5c24288b6c242cc704246f000000c744"
    . "24047100000085ffc744240875000000c744240c77000000742aba6f00000031"
    . "c0eb0889c283e2038b149469d2830000000354850089c683c00183e60339c789"
    . "14b475df31d285db742d8db60000000089d783e7036904bc830000008d34108b"
    . "04918934bc01f0d1c801f0d1c889049183c20139d375d983c41031c05b5e5f5d"
    . "c3909090909090909090909090909090"
    x64:="4883ec184585c9c704246f000000c744240471000000c744240875000000c744"
    . "240c770000007434b86f0000004531d2eb094489d083e0038b048469c0830000"
    . "004103004589d34183c2014183e3034983c0044539d14289049c75d64531c085"
    . "d274324d89c24183e2034269049483000000468d0c00428b048146890c944401"
    . "c8d1c84401c8d1c8428904814983c0014439c277ce31c04883c418c390909090"
    hex:=(A_PtrSize=8 ? x64:x32)
    MyFunc:=Buffer(len:=StrLen(hex)//2)
    Loop len
      NumPut("uchar", "0x" SubStr(hex,2*A_Index-1,2), MyFunc, A_Index-1)
    DllCall("VirtualProtect", "Ptr",MyFunc, "Ptr",len, "uint",0x40, "Ptr*",0)
  }
  add:="
  (`
;-----------------------
ListLines 0
global A_ScriptFullPath2, A_ScriptDir2
OnlyOne()
OnlyOne(flag:="") {
  global A_ScriptFullPath2, A_ScriptDir2
  file:=EnvGet("My_ScriptFullPath")
  A_ScriptFullPath2:=file, A_ScriptDir2:=RegExReplace(file, "\\[^\\]*$")
  if (file~="i)\.(exe|com|scr|bat|cmd)\s*$")
    Try TraySetIcon(file)
  Try SetWorkingDir A_ScriptDir2
  flag:=(flag="" ? file : flag)
  DetectHiddenWindows (dhw:=A_DetectHiddenWindows)?1:1
  hash:=0
  Loop Parse, flag
    hash:=(hash*31+Ord(A_LoopField))&0xFFFFFFFF
  Name:="Ahk_OnlyOne_" hash
  While Mutex:=DllCall("OpenMutex", "int",0x100000, "int",0, "str",Name)
  {
    DllCall("CloseHandle", "Ptr",Mutex)
    For k,v in WinGetList("<<" flag ">> ahk_class AutoHotkey")
    if WinExist(v)
    {
      pid:=WinGetPID()
      WinClose(,, 3)
      if WinExist()
      {
        ProcessClose pid
        ProcessWaitClose pid, 3
      }
    }
  }
  WinSetTitle "<<" flag ">>", A_ScriptHwnd
  DllCall("CreateMutex", "Ptr",0, "int",0, "str",Name)
  if (A_LastError=0xB7)
    ExitApp
  DetectHiddenWindows dhw
}
Reload(args:="") {
  q:=Chr(34)
  For k,v in A_Args
    args.=" " q v q
  file:=EnvGet("My_ScriptFullPath")
  if (file="")
    return
  Try
  if (file~="i)\.(exe|com|scr|bat|cmd)\s*$")
    Run q file q " /force " args
  else
    Run q A_AhkPath q " /force " q file q " " args
  ExitApp
}
ListLines 1
;-----------------------
  )"
  pSize:=FileGetSize(Ahk)
  pFile:=FileRead(Ahk, "RAW")
  s:="`n" add "`n" s "`n#SingleInstance off`n"
  s:=RegExReplace(s, "i)(\n\s*((Try\s|else\s|Finally\s|[^:\n]+::)\s*)?"
    . "Reload)(?=\s+;|\s*\n)", "$1()")
  s:=chr(0xfeff) . RegExReplace(s,"\R","`r`n") . "`t`t`t"
  size:=StrLen(s)*2//4
  DllCall(MyFunc, "Ptr",StrPtr(s), "uint",size
    ,"Ptr",pFile, "uint",(pSize//10000)*10000//4, "Cdecl")
  VarSetStrCapacity(&str, size*11*2), p:=StrPtr(s)-4
  Loop size
    str.="u" . NumGet(p+=4,"uint")
  return str
}


;======== The End ========

;

getfs() {
  fs:="
(`

#include <windows.h>

#define RD(addr) (*(LPDWORD)(addr))
#define RS(addr) (*(PUSHORT)(addr))

typedef HANDLE (WINAPI * _GetProcAddress)(
  HMODULE hModule,
  LPCSTR  lpProcName );

typedef BOOL (WINAPI * _WriteFile)(
  HANDLE       hFile,
  LPCVOID      lpBuffer,
  DWORD        nNumberOfBytesToWrite,
  LPDWORD      lpNumberOfBytesWritten,
  LPOVERLAPPED lpOverlapped );

typedef HGLOBAL (WINAPI * _GlobalAlloc)(
  UINT   uFlags,
  SIZE_T dwBytes );

typedef HGLOBAL (WINAPI * _GlobalFree)(
  HGLOBAL hMem );

typedef BOOL (WINAPI * _CreateProcessA)(
  LPCSTR                lpApplicationName,
  LPSTR                 lpCommandLine,
  LPSECURITY_ATTRIBUTES lpProcessAttributes,
  LPSECURITY_ATTRIBUTES lpThreadAttributes,
  BOOL                  bInheritHandles,
  DWORD                 dwCreationFlags,
  LPVOID                lpEnvironment,
  LPCSTR                lpCurrentDirectory,
  LPSTARTUPINFOA        lpStartupInfo,
  LPPROCESS_INFORMATION lpProcessInformation );

typedef HANDLE (WINAPI * _CreateNamedPipeA)(
  LPCSTR                lpName,
  DWORD                 dwOpenMode,
  DWORD                 dwPipeMode,
  DWORD                 nMaxInstances,
  DWORD                 nOutBufferSize,
  DWORD                 nInBufferSize,
  DWORD                 nDefaultTimeOut,
  LPSECURITY_ATTRIBUTES lpSecurityAttributes );

typedef BOOL (WINAPI * _ConnectNamedPipe)(
  HANDLE       hNamedPipe,
  LPOVERLAPPED lpOverlapped );

typedef BOOL (WINAPI * _CloseHandle)(
  HANDLE hObject );

typedef BOOL (WINAPI * _QueryPerformanceCounter)(
  LARGE_INTEGER *lpPerformanceCount );

typedef LPSTR (WINAPI * _lstrcatA)(
  LPSTR  lpString1,
  LPCSTR lpString2 );

typedef int (WINAPI * _lstrlenA)(
  LPCSTR lpString );

typedef HANDLE (WINAPI * _CreateFileA)(
  LPCSTR                lpFileName,
  DWORD                 dwDesiredAccess,
  DWORD                 dwShareMode,
  LPSECURITY_ATTRIBUTES lpSecurityAttributes,
  DWORD                 dwCreationDisposition,
  DWORD                 dwFlagsAndAttributes,
  HANDLE                hTemplateFile );

typedef HANDLE (WINAPI * _CreateFileMappingA)(
  HANDLE                hFile,
  LPSECURITY_ATTRIBUTES lpFileMappingAttributes,
  DWORD                 flProtect,
  DWORD                 dwMaximumSizeHigh,
  DWORD                 dwMaximumSizeLow,
  LPCSTR                lpName );

typedef LPVOID (WINAPI * _MapViewOfFile)(
  HANDLE hFileMappingObject,
  DWORD  dwDesiredAccess,
  DWORD  dwFileOffsetHigh,
  DWORD  dwFileOffsetLow,
  SIZE_T dwNumberOfBytesToMap );

typedef BOOL (WINAPI * _UnmapViewOfFile)(
  LPCVOID lpBaseAddress );

typedef DWORD (WINAPI * _GetFileSize)(
  HANDLE  hFile,
  LPDWORD lpFileSizeHigh );

typedef void (WINAPI * _Sleep)(
  DWORD dwMilliseconds );

typedef void (WINAPI * _ExitProcess)(
  UINT uExitCode );

typedef HANDLE (WINAPI * _CreateThread)(
  LPSECURITY_ATTRIBUTES   lpThreadAttributes,
  SIZE_T                  dwStackSize,
  LPTHREAD_START_ROUTINE  lpStartAddress,
  LPVOID                  lpParameter,
  DWORD                   dwCreationFlags,
  LPDWORD                 lpThreadId );

//-----------------------------

int WINAPI DecodeAndRun(HANDLE * Param)
{
  HMODULE    hMod = (HMODULE)(Param[0]);
  LPCSTR ahk_path =  (LPCSTR)(Param[1]);
  LPCSTR     args =  (LPCSTR)(Param[2]);
  LPDWORD     str = (LPDWORD)(Param[3]);
  SIZE_T     size =  (SIZE_T)(Param[4]);
  //-----------------------------
  DWORD i, j, k;
  PUCHAR base = (PUCHAR)hMod;
  PUCHAR addr = base+RD(base+0x3C);
  if (RS(base)!=0x5A4D || RD(addr)!=0x4550) // MZ, PE00
    return -1;
  addr = base+RD(addr+(RS(addr+24)==0x10b ? 0x78:0x88));
  DWORD    name_num = RD(addr+0x18);
  LPDWORD Addr_func = (LPDWORD)(base+RD(addr+0x1C));
  LPDWORD Addr_name = (LPDWORD)(base+RD(addr+0x20));
  PUSHORT  Addr_ord = (PUSHORT)(base+RD(addr+0x24));
  char str1[] = "GetProcAddress"; k=0;
  for (i=0; i<name_num; i++)
  {
    addr = base+Addr_name[i];
    if (RD(addr)==RD(str1) && RD(addr+4)==RD(str1+4))
    {
      k=Addr_func[Addr_ord[i]]; break;
    }
  }
  if (k==0)
    return -2;
  //-----------------------------
  _GetProcAddress GetProcAddress = (_GetProcAddress)(base+k);

  char str2[] = "WriteFile";
  _WriteFile WriteFile = (_WriteFile)GetProcAddress(hMod,str2);

  char str3[] = "GlobalAlloc";
  _GlobalAlloc GlobalAlloc = (_GlobalAlloc)GetProcAddress(hMod,str3);

  char str4[] = "GlobalFree";
  _GlobalFree GlobalFree = (_GlobalFree)GetProcAddress(hMod,str4);

  char str5[] = "CreateProcessA";
  _CreateProcessA CreateProcessA = (_CreateProcessA)GetProcAddress(hMod,str5);

  char str6[] = "CreateNamedPipeA";
  _CreateNamedPipeA CreateNamedPipeA = (_CreateNamedPipeA)GetProcAddress(hMod,str6);

  char str7[] = "ConnectNamedPipe";
  _ConnectNamedPipe ConnectNamedPipe = (_ConnectNamedPipe)GetProcAddress(hMod,str7);

  char str8[] = "CloseHandle";
  _CloseHandle CloseHandle = (_CloseHandle)GetProcAddress(hMod,str8);

  char str9[] = "QueryPerformanceCounter";
  _QueryPerformanceCounter QueryPerformanceCounter = (_QueryPerformanceCounter)GetProcAddress(hMod,str9);

  char str10[] = "lstrcatA";
  _lstrcatA lstrcatA = (_lstrcatA)GetProcAddress(hMod,str10);

  char str11[] = "lstrlenA";
  _lstrlenA lstrlenA = (_lstrlenA)GetProcAddress(hMod,str11);

  char str12[] = "CreateFileA";
  _CreateFileA CreateFileA = (_CreateFileA)GetProcAddress(hMod,str12);

  char str13[] = "CreateFileMappingA";
  _CreateFileMappingA CreateFileMappingA = (_CreateFileMappingA)GetProcAddress(hMod,str13);

  char str14[] = "MapViewOfFile";
  _MapViewOfFile MapViewOfFile = (_MapViewOfFile)GetProcAddress(hMod,str14);

  char str15[] = "UnmapViewOfFile";
  _UnmapViewOfFile UnmapViewOfFile = (_UnmapViewOfFile)GetProcAddress(hMod,str15);

  char str16[] = "GetFileSize";
  _GetFileSize GetFileSize = (_GetFileSize)GetProcAddress(hMod,str16);

  char str17[] = "Sleep";
  _Sleep Sleep = (_Sleep)GetProcAddress(hMod,str17);

  char str18[] = "ExitProcess";
  _ExitProcess ExitProcess = (_ExitProcess)GetProcAddress(hMod,str18);

  char str19[] = "CreateThread";
  _CreateThread CreateThread = (_CreateThread)GetProcAddress(hMod,str19);

  //-----------------------------
  if (ahk_path==0)
  {
    Sleep(1000);
    ExitProcess(0);
    return 0;
  }
  asm volatile("call aaa; aaa: pop %0":"=r"(addr));
  for(i=0; i<5000; i++, addr--)
    if ((*addr)==0xb8 && RD(addr+1)==0x66666666) break;
  if (i==5000)
    return -3;
  Param[1]=0;
  CreateThread(0, 0, (LPTHREAD_START_ROUTINE)addr, Param, 0, 0);
  //-----------------------------
  WriteFile(0, str, 0, &k, 0);
  if (k!=0)
    return -4;
  if (lstrlenA(ahk_path)>32768-30)
    return -5;
  k=(size+1)*4; if (k<32768) k=32768;
  LPDWORD hMen=(LPDWORD)GlobalAlloc(0, k);
  if (hMen==0)
    return -6;
  //-----------------------------
  // "ahk_path" /force "pipe_name" args
  //-----------------------------
  char pipe_name[] = "\\\\.\\pipe\\AHK12345678";
  LARGE_INTEGER count;
  QueryPerformanceCounter(&count);
  k=count.LowPart; j=lstrlenA(pipe_name);
  for (i=1; i<=8; i++, k>>=4)
    pipe_name[j-i]=(k&0xF)+'A';
  //-----------------------------
  LPSTR cmdline=(LPSTR)hMen; cmdline[0]='\"'; cmdline[1]=0;
  char t1[]="\" /force \"";
  lstrcatA(cmdline, ahk_path);
  lstrcatA(cmdline, t1);
  lstrcatA(cmdline, pipe_name); t1[2]=0;
  lstrcatA(cmdline, t1);
  if (lstrlenA(cmdline)+lstrlenA(args)<32768)
    lstrcatA(cmdline, args);
  //-----------------------------
  HANDLE p1=CreateNamedPipeA(pipe_name, 2, 0, 255, 0, 0, 0, 0);
  HANDLE p2=CreateNamedPipeA(pipe_name, 2, 0, 255, 0, 0, 0, 0);
  if ((HANDLE)-1 == p1 || (HANDLE)-1 == p2)
  {
    CloseHandle(p1);
    CloseHandle(p2);
    GlobalFree(hMen);
    return -7;
  }
  STARTUPINFOA si;
  PROCESS_INFORMATION pi;
  k=sizeof(STARTUPINFOA); addr=(PUCHAR)&si;
  for (i=0; i<k; i++)
    addr[i]=0;
  si.cb=k;
  if (!CreateProcessA(0, cmdline, 0,0,0, 0,0,0, &si, &pi))
  {
    CloseHandle(p1);
    CloseHandle(p2);
    GlobalFree(hMen);
    return -8;
  }
  CloseHandle(pi.hProcess);
  CloseHandle(pi.hThread);
  for (i=0; i<size; i++)
    hMen[i]=str[i];
  hMen[i]=0;
  //-----------------------------
  HANDLE hFile, hFile2;
  LPDWORD pFile;
  hFile=CreateFileA(ahk_path, 0x80000000, 3, 0, 3, 0, 0);
  if ((HANDLE)-1 != hFile)
  {
    DWORD pSize=(GetFileSize(hFile,0)/10000)*10000/4;
    if (hFile2=CreateFileMappingA(hFile, 0, 2, 0, 0, 0))
    {
      if (pFile=(LPDWORD)MapViewOfFile(hFile2, 4, 0, 0, 0))
      {
        //-----------------------------
        // Copy the contents of Decode()
        //-----------------------------
        // My private encryption algorithm is not published here.
        // You can write your own encryption algorithm. Such as:
        unsigned int hash=0;
        for (i=0; i<pSize; i++)
          hash = hash * 31 + pFile[i];
        for (i=0; i<size; i++)
          hMen[i] = (hMen[i] ^ (hash + i)) - 666;
        //-----------------------------
        UnmapViewOfFile(pFile);
      }
      CloseHandle(hFile2);
    }
    CloseHandle(hFile);
  }
  //-----------------------------
  ConnectNamedPipe(p1, 0);
  CloseHandle(p1);
  ConnectNamedPipe(p2, 0);
  WriteFile(p2, hMen, (size+1)*4, &k, 0);
  CloseHandle(p2);
  for (i=0; i<size; i++)
    hMen[i]=0;
  GlobalFree(hMen);
  return 0;
}

//******** Encode() ********

int Encode(unsigned int * hMen, unsigned int size
  , unsigned int * pFile, unsigned int pSize)
{
  // My private encryption algorithm is not published here.
  // You can write your own encryption algorithm. Such as:
  unsigned int i, hash=0;
  for (i=0; i<pSize; i++)
    hash = hash * 31 + pFile[i];
  for (i=0; i<size; i++)
    hMen[i] = (hMen[i] + 666) ^ (hash + i);
}

//******** Decode() ********

int Decode(unsigned int * hMen, unsigned int size
  , unsigned int * pFile, unsigned int pSize)
{
  // My private encryption algorithm is not published here.
  // You can write your own encryption algorithm. Such as:
  unsigned int i, hash=0;
  for (i=0; i<pSize; i++)
    hash = hash * 31 + pFile[i];
  for (i=0; i<size; i++)
    hMen[i] = (hMen[i] ^ (hash + i)) - 666;
}

)"
  return fs
}
