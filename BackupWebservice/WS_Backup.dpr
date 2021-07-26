program WS_Backup;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  Horse,
  Horse.Jhonson,
  Horse.OctetStream,
  controller.registry in 'controller\controller.registry.pas',
  model.bancodedados in '..\model\model.bancodedados.pas',
  controller.confpublic in 'controller\controller.confpublic.pas',
  model.dao.arquivosINI in 'model\dao\model.dao.arquivosINI.pas',
  model.dao.bancoDados in 'model\dao\model.dao.bancoDados.pas';

var
  app: THorse;
  registry: Tregistry;

begin

  registry := Tregistry.Create;
  app := THorse.Create(workDirPorta.ToInteger);

  app.Use(Jhonson());
  app.Use(OctetStream);

  app.Post('/arquivo/bancodados', registry.PostBancoDados);

  app.Post('/arquivo/bancodados/:cpfcnpj/:tipo/:nomearquivo/:localarquiv', registry.PostArquivo);

  app.Post('/arquivo/bancodados/:cpfcnpj/:tipo/:nomearquivo/:natual/:narquivos', registry.PostBancoDadosCnpj);

  app.Get('/arquivo/bancodados/:cpfcnpj/:tipo/:nomearquivo/', registry.GetBancoDadosCnpj);

  app.Start;

end.
