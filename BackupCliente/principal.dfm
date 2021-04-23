object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 299
  ClientWidth = 635
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
    Top = 40
    Width = 19
    Height = 13
    Caption = 'URL'
  end
  object Label2: TLabel
    Left = 24
    Top = 117
    Width = 37
    Height = 13
    Caption = 'Arquivo'
  end
  object edtUrl: TEdit
    Left = 24
    Top = 72
    Width = 337
    Height = 21
    TabOrder = 0
    Text = 'localhost'
  end
  object btnEnviar: TButton
    Left = 112
    Top = 224
    Width = 75
    Height = 25
    Caption = 'enviarBD'
    TabOrder = 1
    OnClick = btnEnviarClick
  end
  object edtArquivo: TEdit
    Left = 24
    Top = 136
    Width = 337
    Height = 21
    TabOrder = 2
    Text = 'C:\Loja Pr'#243' NG 30\DadosI\ACESSO.FDB'
  end
  object btnArq: TButton
    Left = 376
    Top = 136
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 3
    OnClick = btnArqClick
  end
  object Button1: TButton
    Left = 248
    Top = 224
    Width = 75
    Height = 25
    Caption = 'enviarClass'
    TabOrder = 4
    OnClick = Button1Click
  end
  object RESTClient1: TRESTClient
    BaseURL = 'http://localhost:9000/arquivo/bancodados'
    Params = <>
    Left = 176
    Top = 16
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Method = rmPOST
    Params = <>
    Response = RESTResponse1
    Left = 264
    Top = 16
  end
  object RESTResponse1: TRESTResponse
    Left = 368
    Top = 16
  end
end
