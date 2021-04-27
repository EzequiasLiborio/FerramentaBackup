object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 572
  ClientWidth = 924
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 68
    Width = 19
    Height = 13
    Caption = 'URL'
  end
  object Label2: TLabel
    Left = 24
    Top = 117
    Width = 79
    Height = 13
    Caption = 'Banco de dados '
  end
  object Label3: TLabel
    Left = 24
    Top = 21
    Width = 28
    Height = 13
    Caption = 'CNPJ '
  end
  object Label4: TLabel
    Left = 480
    Top = 117
    Width = 102
    Height = 13
    Caption = 'Tipo banco de dados '
  end
  object Label5: TLabel
    Left = 376
    Top = 167
    Width = 160
    Height = 13
    Caption = 'Local ferramenta banco de dados'
  end
  object Label6: TLabel
    Left = 416
    Top = 117
    Width = 26
    Height = 13
    Caption = 'Porta'
  end
  object Label7: TLabel
    Left = 24
    Top = 167
    Width = 36
    Height = 13
    Caption = 'Usu'#225'rio'
  end
  object Label8: TLabel
    Left = 196
    Top = 167
    Width = 30
    Height = 13
    Caption = 'Senha'
  end
  object edtUrl: TEdit
    Left = 24
    Top = 90
    Width = 593
    Height = 21
    TabOrder = 0
    Text = 'localhost'
  end
  object btnEnviar: TButton
    Left = 128
    Top = 401
    Width = 75
    Height = 25
    Caption = 'enviarBD'
    TabOrder = 1
    OnClick = btnEnviarClick
  end
  object edtLocalBD: TEdit
    Left = 24
    Top = 136
    Width = 337
    Height = 21
    TabOrder = 2
    Text = 'C:\Loja Pr'#243' NG 30\DadosI\ACESSO.FDB'
  end
  object btnBancoDados: TButton
    Left = 376
    Top = 136
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 3
    OnClick = btnBancoDadosClick
  end
  object mmResponse: TMemo
    Left = 0
    Top = 456
    Width = 924
    Height = 116
    Align = alBottom
    TabOrder = 4
  end
  object edtCNPJ: TEdit
    Left = 24
    Top = 40
    Width = 337
    Height = 21
    TabOrder = 5
    Text = '00761474000167'
  end
  object cbxTipoBD: TComboBox
    Left = 480
    Top = 136
    Width = 137
    Height = 21
    ItemIndex = 0
    TabOrder = 6
    Text = 'Firebird'
    Items.Strings = (
      'Firebird')
  end
  object edtFerramentaBD: TEdit
    Left = 376
    Top = 186
    Width = 206
    Height = 21
    TabOrder = 7
    Text = 'C:\Windows\SysWOW64\FBCLIENT.DLL'
  end
  object btnFerramentaBD: TButton
    Left = 588
    Top = 186
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 8
    OnClick = btnFerramentaBDClick
  end
  object edtPorta: TEdit
    Left = 416
    Top = 136
    Width = 49
    Height = 21
    TabOrder = 9
    Text = '3050'
  end
  object edtUsuarioBD: TEdit
    Left = 24
    Top = 186
    Width = 165
    Height = 21
    TabOrder = 10
    Text = 'sysdba'
  end
  object edtSenhaBD: TEdit
    Left = 196
    Top = 186
    Width = 165
    Height = 21
    TabOrder = 11
    Text = 'masterkey'
  end
  object RESTClient1: TRESTClient
    BaseURL = 'http://localhost:9000/arquivo/bancodados'
    Params = <>
    Left = 816
    Top = 16
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Method = rmPOST
    Params = <>
    Response = RESTResponse1
    Left = 816
    Top = 64
  end
  object RESTResponse1: TRESTResponse
    Left = 816
    Top = 120
  end
end
