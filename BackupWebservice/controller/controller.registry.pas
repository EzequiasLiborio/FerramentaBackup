unit controller.registry;

interface

uses Horse, Horse.Jhonson, System.JSON, REST.JSON, REST.Types, Soap.EncdDecd;

type
  Tregistry = class

  private
    function DesConverterBancoDados(LocalArquivo, base64: string): Boolean;

  public
    procedure PostBancoDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure PostBancoDadosCnpj(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure GetBancoDadosCnpj(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  end;

var
  registry: Tregistry;

implementation

uses
  model.bancodedados, System.SysUtils, System.Classes;

{ Tregistry }

procedure Tregistry.GetBancoDadosCnpj(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send('240421');
end;

function Tregistry.DesConverterBancoDados(LocalArquivo, base64: string): Boolean;
var
  bd: TMemoryStream;
  input: TStringStream;
begin

  Result := False;

  bd := TMemoryStream.Create;
  input := TStringStream.Create(base64, TEncoding.ASCII);
  try

    Soap.EncdDecd.decodeStream(input, bd);

    ForceDirectories(LocalArquivo);

    bd.Position := 0;
    bd.SaveToFile(LocalArquivo);

    Result := True;

  finally
    FreeAndNil(bd);
    FreeAndNil(input);
  end;

end;

procedure Tregistry.PostBancoDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  bancoDadosInfo: TbancoDadosInfo;
  lBody: TJSONObject;
  localArq: string;
begin

  try
    bancoDadosInfo := TbancoDadosInfo.Create;

    lBody := TJSONObject.Create;

    lBody := Req.Body<TJSONObject>;

    bancoDadosInfo := TJson.JsonToObject<TbancoDadosInfo>(lBody);

    with bancoDadosInfo do
    begin
      localArq := 'C:\Diversos\' + cnpj + '\';

      DesConverterBancoDados(localArq + '\' + nomeArquivo, base64str);

    end;

    Res.Status(201);
  finally
    FreeAndNil(bancoDadosInfo);
  end;

end;

procedure Tregistry.PostBancoDadosCnpj(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  bd: TMemoryStream;
  localArq, cnpj, tipo, nomeArquivo: string;
  natual, narquivos: integer;
begin

  try

    cnpj := Req.Params.Items['cnpj'];
    tipo := Req.Params.Items['tipo'];
    nomeArquivo := Req.Params.Items['nomearquivo'];

    natual := Req.Params.Items['natual'].ToInteger;
    narquivos := Req.Params.Items['narquivos'].ToInteger;

    localArq := 'C:\Diversos\' + cnpj + '\';

    ForceDirectories(localArq);

    bd := Req.Body<TMemoryStream>;

    bd.SaveToFile(localArq + '\' + nomeArquivo);

    Res.Status(201);

  finally
    // freeAndNil(bd);
  end;

end;

end.
