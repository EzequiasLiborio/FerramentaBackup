program WS_Backup;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  Horse,
  Horse.Jhonson,
  Horse.OctetStream,
  controller.registry in 'controller\controller.registry.pas',
  model.bancodedados in '..\model\model.bancodedados.pas';

var
  app: THorse;
  registry: Tregistry;

begin

  registry := Tregistry.Create;
  app := THorse.Create(9000);

  app.Use(Jhonson());
  app.Use(OctetStream);

  app.Post('/arquivo/bancodados', registry.PostBancoDados);

  app.Post('/arquivo/bancodados/:cnpj', registry.PostBancoDadosCnpj);

  app.Start;

end.
