unit controller.registry;

interface

uses Horse, Horse.Jhonson, System.JSON, REST.JSON, REST.Types, Soap.EncdDecd;

type
  Tregistry = class

  private
    function DesConverterBancoDados(LocalArquivo, base64: string): Boolean;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure PostBancoDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure PostBancoDadosCnpj(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure GetBancoDadosCnpj(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure PostArquivo(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  end;

var
  registry: Tregistry;

implementation

uses
  model.bancodedados, System.SysUtils, System.Classes, model.dao.arquivosINI, model.dao.bancoDados,
  controller.confpublic;

{ Tregistry }

destructor Tregistry.Destroy;
begin
  FreeAndNil(arquivosINI);
  FreeAndNil(bancoDados);

  inherited;
end;

constructor Tregistry.Create;
begin
  inherited Create;

  arquivosINI := TarquivosINI.Create;
  arquivosINI.WorkDirectoryAbrir;

  bancoDados := TbancoDados.Create;

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

procedure Tregistry.PostArquivo(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Arquivo: TMemoryStream;
  localArq, cnpj, tipo, nomeArquivo, localArquivSer: string;
begin

  try

    cnpj := Req.Params.Items['cpfcnpj'];
    tipo := Req.Params.Items['tipo'];
    nomeArquivo := Req.Params.Items['nomearquivo'];
    localArquivSer := Req.Params.Items['localarquiv'];

    localArq := workDirBackups + '\' + cnpj + '\'+ localArquivSer;

    ForceDirectories(localArq);

    Arquivo := Req.Body<TMemoryStream>;

    Arquivo.SaveToFile(localArq + '\' + nomeArquivo);

    Res.Status(201);
  finally
    FreeAndNil(Arquivo);
  end;

end;

procedure Tregistry.PostBancoDadosCnpj(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  bd: TMemoryStream;
  localArq, cnpj, tipo, nomeArquivo: string;
  natual, narquivos: integer;
begin

  try

    cnpj := Req.Params.Items['cpfcnpj'];
    tipo := Req.Params.Items['tipo'];
    nomeArquivo := Req.Params.Items['nomearquivo'];

    natual := Req.Params.Items['natual'].ToInteger;
    narquivos := Req.Params.Items['narquivos'].ToInteger;

    localArq := workDirBackups + '\' + cnpj + '\BDs';

    ForceDirectories(localArq);

    bd := Req.Body<TMemoryStream>;

    bd.SaveToFile(localArq + '\' + nomeArquivo);

    Res.Status(201);

  finally
    FreeAndNil(bd);
  end;

end;

end.
