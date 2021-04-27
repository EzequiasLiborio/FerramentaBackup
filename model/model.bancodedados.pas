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
    FnomeArquivo: string;
    Fbase64str: AnsiString;
    procedure Setcnpj(const Value: string);
    procedure SetnumeArqAtual(const Value: integer);
    procedure SetquantArq(const Value: integer);
    procedure SetnomeArquivo(const Value: string);
    procedure Setbase64str(const Value: AnsiString);
  published
    property cnpj: string read Fcnpj write Setcnpj;
    property quantArq: integer read FquantArq write SetquantArq;
    property numeArqAtual: integer read FnumeArqAtual write SetnumeArqAtual;
    property base64str: AnsiString read Fbase64str write Setbase64str;
    property nomeArquivo: string read FnomeArquivo write SetnomeArquivo;
  end;

implementation

uses
  System.SysUtils;

{ TbancoDadosInfo }

constructor TbancoDadosInfo.create;
begin
  inherited create;
 //  base64str := TAnsiString.create;
end;

destructor TbancoDadosInfo.Destroy;
begin
  // FreeAndNil(base64str);
  inherited;
end;

procedure TbancoDadosInfo.Setbase64str(const Value: AnsiString);
begin
  Fbase64str := Value;
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
