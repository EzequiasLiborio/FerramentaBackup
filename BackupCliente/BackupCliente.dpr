program BackupCliente;

uses
  Vcl.Forms,
  principal in 'principal.pas' {Form1},
  model.bancodedados in '..\model\model.bancodedados.pas',
  utilitarios in '..\controllerCpt\utilitarios.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
