unit model.bancodedados;

interface

uses
  System.Classes;

type

  TbancoDadosInfo = class
  public
    constructor create; virtual;
    destructor Destroy; override;
  private
    Fcnpj: string;
    FnumeArqAtual: integer;
    FquantArq: integer;
    FbancoDados: TmemoryStream;
    FnomeArquivo: string;
    procedure Setcnpj(const Value: string);
    procedure SetnumeArqAtual(const Value: integer);
    procedure SetquantArq(const Value: integer);
    procedure SetbancoDados(const Value: TmemoryStream);
    procedure SetnomeArquivo(const Value: string);
  published
    property cnpj: string read Fcnpj write Setcnpj;
    property quantArq: integer read FquantArq write SetquantArq;
    property numeArqAtual: integer read FnumeArqAtual write SetnumeArqAtual;
    property bancoDados: TmemoryStream read FbancoDados write SetbancoDados;
    property nomeArquivo: string read Fnomearquivo write Setnomearquivo;
  end;

implementation

uses
  System.SysUtils;

{ TbancoDadosInfo }

constructor TbancoDadosInfo.create;
begin
  inherited create;
  bancoDados := TmemoryStream.create;
end;

destructor TbancoDadosInfo.Destroy;
begin
  FreeAndNil(bancoDados);
  inherited;
end;

procedure TbancoDadosInfo.SetbancoDados(const Value: TmemoryStream);
begin
  FbancoDados := Value;
end;

procedure TbancoDadosInfo.Setcnpj(const Value: string);
begin
  Fcnpj := Value;
end;

procedure TbancoDadosInfo.SetnomeArquivo(const Value: string);
begin
  FnomeArquivo := Value;
end;

procedure TbancoDadosInfo.SetnumeArqAtual(const Value: integer);
begin
  FnumeArqAtual := Value;
end;

procedure TbancoDadosInfo.SetquantArq(const Value: integer);
begin
  FquantArq := Value;
end;

end.
