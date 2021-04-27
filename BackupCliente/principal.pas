unit principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, Vcl.StdCtrls, System.JSON, REST.JSON, Soap.EncdDecd, FireDAC.Stan.Def,
  FireDAC.VCLUI.Wait, FireDAC.Phys.IBWrapper, FireDAC.Stan.Intf, FireDAC.Phys, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, System.SysUtils;

type
  TForm1 = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    edtUrl: TEdit;
    Label1: TLabel;
    btnEnviar: TButton;
    edtLocalBD: TEdit;
    Label2: TLabel;
    btnBancoDados: TButton;
    mmResponse: TMemo;
    edtCNPJ: TEdit;
    Label3: TLabel;
    cbxTipoBD: TComboBox;
    Label4: TLabel;
    edtFerramentaBD: TEdit;
    btnFerramentaBD: TButton;
    Label5: TLabel;
    Label6: TLabel;
    edtPorta: TEdit;
    edtUsuarioBD: TEdit;
    Label7: TLabel;
    edtSenhaBD: TEdit;
    Label8: TLabel;
    procedure btnBancoDadosClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnFerramentaBDClick(Sender: TObject);
    procedure FDIBBackupError(ASender, AInitiator: TObject; var AException: Exception);
    procedure btnEnviarClick(Sender: TObject);
    procedure FDIBBackupProgress(ASender: TFDPhysDriverService; const AMessage: string);
  private
    procedure InicioRestClient;
    function ConverterBancoDados(LocalArquivo: string): AnsiString;
    procedure bancodedados(tipo, nomeArquivo, natual, narquivos, localArq: string);
    function openDialog(localinicial: string): string;
    function BackupBD: string;
    function ZipArquivo(LocalArquivo: string): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses model.bancodedados, utilitarios, System.Zip;
{ TForm1 }

function TForm1.openDialog(localinicial: string): string;
var
  openDlg: TOpenDialog;
begin

  openDlg := TOpenDialog.Create(nil);
  Result := '';

  try

    if localinicial = EmptyStr then
      openDlg.InitialDir := GetCurrentDir
    else
      openDlg.InitialDir := ExtractFileDir(localinicial);

    openDlg.DefaultExt := '*';
    openDlg.Filter := '*';

    if openDlg.Execute then
      Result := openDlg.FileName;

  finally
    freeAndNil(openDlg);
  end;

end;

procedure TForm1.btnBancoDadosClick(Sender: TObject);
begin
  edtLocalBD.Text := openDialog(edtLocalBD.Text);
end;

procedure TForm1.btnFerramentaBDClick(Sender: TObject);
begin
  edtFerramentaBD.Text := openDialog(edtFerramentaBD.Text);
end;

procedure TForm1.btnEnviarClick(Sender: TObject);
var
  localBdBackup, localZip: string;

begin

  mmResponse.Clear;

  localBdBackup := BackupBD;

  if localBdBackup <> EmptyStr then
  begin

    localZip := ZipArquivo(localBdBackup);

    bancodedados('zip', ExtractNome(localZip), '1', '1', localZip);

  end;

end;

function TForm1.ZipArquivo(LocalArquivo: string): string;
var
  Zip: Tzipfile;
begin

  Zip := Tzipfile.Create;
  Result := '';
  Result := ExtractFileDir(LocalArquivo) + '\' + ExtractNome(LocalArquivo) + '.zip';

  try

    try

      Zip.Open(Result, zmWrite);
      Zip.add(LocalArquivo);

      Zip.Close;

    except
      on E: Exception do
        Result := '';
    end;
  finally
    freeAndNil(Zip);
  end;

end;

procedure TForm1.bancodedados(tipo, nomeArquivo, natual, narquivos, localArq: string);
var
  bd: TFileStream;
begin
  // mmResponse.Clear;

  try

    bd := TFileStream.Create(localArq, fmOpenRead);

    bd.Position := 0;

    self.InicioRestClient;
    RESTClient1.ContentType := 'application/octet-stream';
    RESTRequest1.Resource := '/arquivo/bancodados/{cnpj}/{tipo}/{nomearquivo}/{natual}/{narquivos}';
    RESTRequest1.Method := TRESTRequestMethod.rmPOST;
    RESTRequest1.AddBody(bd, ctAPPLICATION_OCTET_STREAM);

    with RESTRequest1.Params do
    begin

      with AddItem do
      begin
        ContentType := ctAPPLICATION_OCTET_STREAM;
        name := 'cnpj';
        Value := edtCNPJ.Text;
        Kind := pkURLSEGMENT;
      end;

      with AddItem do
      begin
        ContentType := ctAPPLICATION_OCTET_STREAM;
        name := 'tipo';
        Value := tipo;
        Kind := pkURLSEGMENT;
      end;

      with AddItem do
      begin
        ContentType := ctAPPLICATION_OCTET_STREAM;
        name := 'nomearquivo';
        Value := nomeArquivo;
        Kind := pkURLSEGMENT;
      end;

      with AddItem do
      begin
        ContentType := ctAPPLICATION_OCTET_STREAM;
        name := 'natual';
        Value := natual;
        Kind := pkURLSEGMENT;
      end;

      with AddItem do
      begin
        ContentType := ctAPPLICATION_OCTET_STREAM;
        name := 'narquivos';
        Value := narquivos;
        Kind := pkURLSEGMENT;
      end;

    end;

    RESTRequest1.Execute;

  finally
    mmResponse.Lines.add(RESTRequest1.Response.StatusCode.ToString + '  ' +
      RESTRequest1.Response.StatusText);
    mmResponse.Lines.add(RESTRequest1.Response.ErrorMessage);
    mmResponse.Lines.AddStrings(RESTRequest1.Response.Headers);

    RESTRequest1.ClearBody;

    freeAndNil(bd);
  end;

end;

function TForm1.ConverterBancoDados(LocalArquivo: string): AnsiString;
var
  bd: TMemoryStream;
  Output: TStringStream;
begin

  Result := '';

  bd := TMemoryStream.Create;
  Output := TStringStream.Create('', TEncoding.ASCII);

  try

    bd.LoadFromFile(LocalArquivo);
    bd.Position := 0;

    Soap.EncdDecd.EncodeStream(bd, Output);

    Result := Output.DataString;

  finally
    freeAndNil(bd);
    freeAndNil(Output);
  end;

end;

function TForm1.BackupBD: string;
var
  FDIBBackup: TFDIBBackup;
  FB: TFDPhysFBDriverLink;
  localBackup: string;
begin

  FDIBBackup := TFDIBBackup.Create(nil);
  localBackup := '';

  try

    try

      case cbxTipoBD.ItemIndex of
        0:
          begin

            FB := TFDPhysFBDriverLink.Create(nil);
            FB.Release;
            FB.VendorLib := edtFerramentaBD.Text;

            FDIBBackup.DriverLink := FB;
            localBackup := ExtractFileDir(Application.ExeName) + '\' + ExtractNome(edtLocalBD.Text)
              + FormatDateTime('ddmmyyyhhnnsszzz', now) + '.fbk';

          end;

      end;

      Result := localBackup;

      with FDIBBackup do
      begin

        OnError := FDIBBackupError;
        OnProgress := FDIBBackupProgress;

        UserName := edtUsuarioBD.Text;
        Password := edtSenhaBD.Text;
        host := 'localhost';
        Protocol := ipTCPIP;
        Verbose := True;
        database := edtLocalBD.Text;
        BackupFiles.add(localBackup);
        backup;

      end;

    except
      on E: Exception do
      begin
        MessageDlg('Erro ao gerar backup! - linha:' + sLineBreak + ' - ' + E.Message,
          TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);

        Result := '';
      end;
    end;

  finally
    freeAndNil(FDIBBackup);
    freeAndNil(FB);
  end;

end;

procedure TForm1.FDIBBackupProgress(ASender: TFDPhysDriverService; const AMessage: string);
begin
  mmResponse.Lines.add(AMessage);
end;

procedure TForm1.FDIBBackupError(ASender, AInitiator: TObject; var AException: Exception);
begin
  ShowMessage(AException.Message);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  bancoDadosInfo: TbancoDadosInfo;
  JSONObject: TJSONObject;

begin

  try

    mmResponse.Clear;
    RESTRequest1.ClearBody;

    bancoDadosInfo := TbancoDadosInfo.Create;

    with bancoDadosInfo do
    begin
      cnpj := '0761474000167';
      numeArqAtual := 1;
      quantArq := 1;
      nomeArquivo := ExtractFileName(edtLocalBD.Text);

      base64str := ConverterBancoDados(edtLocalBD.Text);

    end;

    self.InicioRestClient;

    RESTClient1.ContentType := 'application/json';
    RESTRequest1.Resource := '/arquivo/bancodados';
    RESTRequest1.Method := TRESTRequestMethod.rmPOST;

    JSONObject := TJson.ObjectToJsonObject(bancoDadosInfo);

    RESTRequest1.AddBody<TbancoDadosInfo>(bancoDadosInfo);

    RESTRequest1.Execute;

  finally

    mmResponse.Lines.add(RESTRequest1.Response.StatusCode.ToString + '  ' +
      RESTRequest1.Response.StatusText);
    mmResponse.Lines.add(RESTRequest1.Response.ErrorMessage);
    mmResponse.Lines.AddStrings(RESTRequest1.Response.Headers);

    RESTRequest1.ClearBody;

    freeAndNil(bancoDadosInfo);
    freeAndNil(JSONObject);

  end;

end;

procedure TForm1.InicioRestClient;
begin

  RESTClient1.ResetToDefaults;
  RESTRequest1.ResetToDefaults;
  RESTResponse1.ResetToDefaults;
  RESTClient1.BaseURL := 'http://' + Trim(edtUrl.Text) + ':9000';

end;

end.
