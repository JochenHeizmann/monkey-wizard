Strict

Private

Import wizard.android
Import wizard.app
Import wizard.command
Import wizard.dir
Import wizard.file

Public

Class AndroidAntKey Implements Command
    Method Run:Void(app:App)
        Local file := app.TargetFile("ant.properties")
        Local fields := [
            "key.store", "key.store.password",
            "key.alias", "key.alias.password"]

        For Local i := 1 To fields.Length()
            Local name := fields[i - 1]
            If Not file.Contains(name + "=")
                file.Append(name + "=" + GetArgument(app, i, name) + "~n")
            End
        End
    End

    Private

    Method GetArgument:String(app:App, idx:Int, name:String)
        If app.GetAdditionArguments().Length() < idx
            app.LogError(idx + " argument " + name + " is missing")
            Return ""
        End

        Return app.GetAdditionArguments()[idx - 1]
    End
End
