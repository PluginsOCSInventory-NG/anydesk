Dim myVar

Dim WshShell

Set WshShell = Wscript.CreateObject("WScript.Shell")

appdata = WshShell.ExpandEnvironmentStrings("%APPDATA%")

SETTINGS_FILE = appdata + "\AnyDesk\system.conf"

Dim Settings
Set Settings = LoadSettings(SETTINGS_FILE)

ADID = Settings("ad.anynet.id")
ADVersion = Settings("ad.anynet.cur_version")

Wscript.Echo _
	"<ANYDESK>" & VbCrLf &_
	"<ADID>" & ADID & "</ADID>" & VbCrLf &_
	"<VERSION>" & ADVersion & "</VERSION>" & VbCrLf &_
	"</ANYDESK>"

Public Function LoadSettings(strFile)

    Set LoadSettings = CreateObject("Scripting.Dictionary")

    Dim strLine, a
    With CreateObject("Scripting.FileSystemObject")
        If Not .FileExists(strFile) Then Exit Function
        With .OpenTextFile(strFile)
            Do Until .AtEndOfStream
                strLine = Trim(.ReadLine())
                If InStr(strLine, "=") > 0 Then
                    a = Split(strLine, "=")
                    LoadSettings.Add a(0), a(1)
                End If
            Loop
        End With
    End With

End Function
