Dim WshShell
Set WshShell = Wscript.CreateObject("WScript.Shell")

appdata = WshShell.ExpandEnvironmentStrings("%PROGRAMDATA%")

SETTINGS_FILE = appdata + "\AnyDesk"

Dim oFSO,oFld 
Set oFSO = CreateObject("Scripting.FileSystemObject") 
' Si le dossier AnyDesk existe
If oFSO.FolderExists(SETTINGS_FILE) Then 
	' On teste si le fichier de configuration est présent à la racine
	If Not(oFSO.FileExists(SETTINGS_FILE & "\system.conf")) Then
		' Si le fichier de configuration est absent on teste la présence de soue dossiers (config personalisée)
		For each oFld in  oFSO.GetFolder(SETTINGS_FILE).SubFolders 
				' Si un fichier de configuration est ptésent dans le sous dossier on mémorise le chemin
				' Sinon on laisse le chemin par défaut
				If oFSO.FileExists(SETTINGS_FILE & "\" & oFld.Name & "\system.conf") Then
					SETTINGS_FILE = SETTINGS_FILE & "\" & oFld.Name
				End If
		Next
	End If
End If

' On définit l'emplacement du fichier de configuration sur le bon chemin
SETTINGS_FILE = SETTINGS_FILE & "\system.conf"

Dim Settings
Set Settings = LoadSettings(SETTINGS_FILE)

ADID = Settings("ad.anynet.id")
ADVersion = Settings("ad.anynet.cur_version")
ADAlias = Settings("ad.anynet.alias")

If ADID = "" AND ADVersion = "" Then
	ADID = "No data available in table"
End If

Wscript.Echo _
	"<ANYDESK>" & VbCrLf &_
	"<ADID>" & ADID & "</ADID>" & VbCrLf &_
	"<VERSION>" & ADVersion & "</VERSION>" & VbCrLf &_
	"<ALIAS>" & ADAlias & "</ALIAS>" & VbCrLf &_
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
