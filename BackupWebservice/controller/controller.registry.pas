unit controller.registry;

interface

uses Horse, Horse.Jhonson;

type
  Tregistry = class

  private

  public
    procedure PostBancoDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure PostBancoDadosCnpj(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  end;

var
  registry: Tregistry;

implementation

uses
  model.bancodedados, System.SysUtils, System.Classes;

{ Tregistry }

procedure Tregistry.PostBancoDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  bancoDadosInfo: TbancoDadosInfo;
  localArq: string;
begin
  try
    bancoDadosInfo := TbancoDadosInfo.create;

    bancoDadosInfo := Req.Body<TbancoDadosInfo>;

    with bancoDadosInfo do
    begin
      localArq := 'C:\Diversos\' + cnpj + '\';

      ForceDirectories(localArq);

      bancoDados.SaveToFile(localArq + nomearquivo);

    end;

    Res.Status(201);
  finally
    freeAndNil(bancoDadosInfo);
  end;

end;

procedure Tregistry.PostBancoDadosCnpj(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  bd: TMemoryStream;
  localArq, cnpj: string;
begin

  try

    // bd := TMemoryStream.create;

    cnpj := Req.Params.Items['cnpj'];

    localArq := 'C:\Diversos\' + cnpj + '\';

    ForceDirectories(localArq);

    bd := Req.Body<TMemoryStream>;

    bd.SaveToFile(localArq + '\bancodados.gdx');

    Res.Status(201);

  finally
   // freeAndNil(bd);
  end;

end;

end.
