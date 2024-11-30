object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'FormMain'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 62
    Height = 15
    Caption = 'C'#243'digo [F4]'
  end
  object Label2: TLabel
    Left = 136
    Top = 8
    Width = 51
    Height = 15
    Caption = 'Descri'#231#227'o'
  end
  object edtCodigo: TEdit
    Left = 8
    Top = 32
    Width = 121
    Height = 23
    TabOrder = 0
    OnKeyDown = edtCodigoKeyDown
  end
  object edtDescricao: TEdit
    Left = 135
    Top = 32
    Width = 322
    Height = 23
    TabOrder = 1
  end
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=D:\Users\Maico\Downloads\zip\hdp\hdp.dat'
      'Password=masterkey'
      'User_Name=SYSDBA'
      'DriverID=FB'
      'Server=127.0.0.1'
      'Protocol=TCPIP'
      'Port=3050')
    TxOptions.Isolation = xiReadCommitted
    LoginPrompt = False
    Left = 24
    Top = 64
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 152
    Top = 64
  end
  object FDQuery1: TFDQuery
    Connection = Conexao
    Left = 128
    Top = 160
  end
end
