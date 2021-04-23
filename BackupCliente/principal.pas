unit principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, Vcl.StdCtrls, REST.JSON;

type
  TForm1 = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    edtUrl: TEdit;
    Label1: TLabel;
    btnEnviar: TButton;
    edtArquivo: TEdit;
    Label2: TLabel;
    btnArq: TButton;
    Button1: TButton;
    procedure btnArqClick(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure InicioRestClient;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses model.bancodedados;
{ TForm1 }

procedure TForm1.btnArqClick(Sender: TObject);
var
  openDlg: TOpenDialog;
begin

  openDlg := TOpenDialog.Create(nil);

  try

    if edtArquivo.Text = EmptyStr then
      openDlg.InitialDir := GetCurrentDir
    else
      openDlg.InitialDir := ExtractFileDir(edtArquivo.Text);

    openDlg.DefaultExt := '*';
    openDlg.Filter := '*';

    if openDlg.Execute then
      edtArquivo.Text := openDlg.FileName;

  finally

    openDlg.Free;
  end;

end;

procedure TForm1.btnEnviarClick(Sender: TObject);
var
  bd: TFileStream;
begin

  try

    bd := TFileStream.Create(edtArquivo.Text, fmOpenRead);
    bd.Position := 0;

    self.InicioRestClient;
    RESTClient1.ContentType := 'application/octet-stream';
    RESTRequest1.Resource := '/arquivo/bancodados/:cnpj'; // 07614740000167';
    RESTRequest1.Params.AddItem.('cnpj', '07614740000167');
    RESTRequest1.Method := TRESTRequestMethod.rmPOST;
    RESTRequest1.AddBody(bd, ctAPPLICATION_OCTET_STREAM);

    RESTRequest1.Execute;

  finally
    FreeAndNil(bd);
  end;

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  bancoDadosInfo: TbancoDadosInfo;
begin

  bancoDadosInfo := TbancoDadosInfo.Create;

  with bancoDadosInfo do
  begin
    cnpj := '0761474000167';
    numeArqAtual := 1;
    quantArq := 1;
    nomeArquivo := ExtractFileName(edtArquivo.Text);
    bancoDados.LoadFromFile(edtArquivo.Text);
  end;

  self.InicioRestClient;

  RESTRequest1.Resource := '/arquivo/bancodados';
  RESTRequest1.Method := TRESTRequestMethod.rmPOST;
  RESTRequest1.Params.AddBody<TbancoDadosInfo>(bancoDadosInfo);

  RESTRequest1.Execute;

end;

procedure TForm1.InicioRestClient;
begin

  RESTClient1.ResetToDefaults;
  RESTRequest1.ResetToDefaults;
  RESTResponse1.ResetToDefaults;
  RESTClient1.BaseURL := 'http://' + Trim(edtUrl.Text) + ':9000';

end;

end.
