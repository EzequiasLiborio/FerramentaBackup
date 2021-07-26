unit model.dao.bancoDados;

interface

uses FireDAC.Phys.FB, FireDAC.Stan.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client;

type
  TbancoDados = class

  public
    constructor Create; virtual;
    destructor Destroy; override;

    function DataValidade(cpfcnpj, ferramenta: string): string;
  private
    physFB: TFDPhysFBDriverLink;
    fdcMLPS: TFDConnection;
  end;

var
  bancoDados: TbancoDados;

implementation

uses System.SysUtils, controller.confpublic;

{ TbancoDados }

constructor TbancoDados.Create;
begin
  inherited Create;

  physFB := TFDPhysFBDriverLink.Create(nil);
  physFB.Release;
  physFB.VendorLib := workDirFB;

  fdcMLPS := TFDConnection.Create(nil);

  with fdcMLPS do
  begin

    Close;
    Params.Database := '';
    Connected := False;

    Params.Database := workDirBD;
    Params.DriverID := 'FB';
    Params.UserName := 'sysdba';
    Params.Password := 'masterkey';
    Params.Add('CharacterSet=UTF8');
    Connected := True;

  end;

end;

function TbancoDados.DataValidade(cpfcnpj, ferramenta: string): string;
var
  QueryAux: TFDQuery;
  dtA: Integer;
  nAno, nMes, nDia: word;
begin

  QueryAux := TFDQuery.Create(nil);

  try

    QueryAux.Connection := fdcMLPS;

    result := '';

    DecodeDate(now, nAno, nMes, nDia);

    dtA := (FormatFloat('0000', nAno) + FormatFloat('00', nMes) + FormatFloat('00', nDia)).toInteger;

    with QueryAux do
    begin

      Close;
      sql.Clear;

      sql.Add('select v.* from validacoes v, clientes c');
      sql.Add('where id_cliente_val = id_cliente       ');
      sql.Add('  and CPFCNPJ = :CPFCNPJ                ');
      sql.Add('  and id_ferramenta_val = :id_ferramenta');

      ParamByName('id_ferramenta').AsString := ferramenta;
      ParamByName('CPFCNPJ').AsString := cpfcnpj;

      open;

      if not eof then
        result := FloatToStr(FieldByName('datavencimento').AsFloat * dtA)
      else
        result := FloatToStr(dtA * dtA)

    end;

  finally
    FreeAndNil(QueryAux);
  end;

end;

destructor TbancoDados.Destroy;
begin
  FreeAndNil(physFB);
  FreeAndNil(fdcMLPS);

  inherited;
end;

end.
