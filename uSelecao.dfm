object FormSelecao: TFormSelecao
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'FormSelecao'
  ClientHeight = 487
  ClientWidth = 801
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    801
    487)
  TextHeight = 15
  object lblRegistros: TLabel
    Left = 721
    Top = 437
    Width = 60
    Height = 15
    Anchors = [akTop, akRight]
    Caption = 'Registros: 0'
    ExplicitLeft = 552
  end
  object btnPrimPag: TSpeedButton
    Left = 33
    Top = 455
    Width = 31
    Height = 24
    Caption = '|<<'
    OnClick = btnPrimPagClick
  end
  object btnPagAnt: TSpeedButton
    Left = 99
    Top = 455
    Width = 31
    Height = 24
    Caption = '<'
    OnClick = btnPagAntClick
  end
  object btnProxPag: TSpeedButton
    Left = 251
    Top = 455
    Width = 31
    Height = 24
    Caption = '>'
    OnClick = btnProxPagClick
  end
  object btnUltPag: TSpeedButton
    Left = 315
    Top = 455
    Width = 31
    Height = 24
    Caption = '>>|'
    OnClick = btnUltPagClick
  end
  object Label1: TLabel
    Left = 147
    Top = 437
    Width = 23
    Height = 15
    Caption = 'P'#225'g.'
  end
  object Label2: TLabel
    Left = 194
    Top = 437
    Width = 13
    Height = 15
    Caption = 'de'
  end
  object Label3: TLabel
    Left = 8
    Top = 11
    Width = 237
    Height = 15
    Caption = 'Pr'#243'x. Campo [F3]   |   Campo Anter. [Ctrl+F3]'
  end
  object Label4: TLabel
    Left = 8
    Top = 437
    Width = 56
    Height = 15
    Caption = 'Ctrl+PgUp'
  end
  object Label5: TLabel
    Left = 96
    Top = 437
    Width = 29
    Height = 15
    Caption = 'PgUp'
  end
  object Label6: TLabel
    Left = 251
    Top = 437
    Width = 29
    Height = 15
    Caption = 'PgDn'
  end
  object Label7: TLabel
    Left = 315
    Top = 437
    Width = 56
    Height = 15
    Caption = 'Ctrl+PgDn'
  end
  object btnVoltar: TButton
    Left = 702
    Top = 8
    Width = 91
    Height = 25
    Cancel = True
    Caption = 'Voltar [Esc]'
    TabOrder = 0
    OnClick = btnVoltarClick
  end
  object Grid: TDBGrid
    Left = 4
    Top = 66
    Width = 789
    Height = 365
    DataSource = dsGrid
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDblClick = GridDblClick
    OnKeyDown = GridKeyDown
    OnMouseDown = GridMouseDown
  end
  object edtBusca: TEdit
    Left = 251
    Top = 37
    Width = 382
    Height = 23
    TabOrder = 2
    OnChange = edtBuscaChange
    OnKeyDown = edtBuscaKeyDown
    OnKeyPress = edtBuscaKeyPress
  end
  object edtPaginaAtual: TEdit
    Left = 147
    Top = 456
    Width = 41
    Height = 23
    Alignment = taCenter
    NumbersOnly = True
    TabOrder = 3
    OnExit = edtPaginaAtualExit
    OnKeyPress = edtPaginaAtualKeyPress
  end
  object edtTotalPaginas: TEdit
    Left = 194
    Top = 456
    Width = 41
    Height = 23
    Alignment = taCenter
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 4
  end
  object cbFiltrar: TComboBox
    Left = 251
    Top = 8
    Width = 145
    Height = 23
    Style = csDropDownList
    TabOrder = 5
    OnClick = cbFiltrarClick
  end
  object rbInicia: TRadioButton
    Left = 8
    Top = 40
    Width = 105
    Height = 17
    Caption = 'Inicia [Ctrl+1]'
    TabOrder = 6
    OnClick = rbIniciaClick
  end
  object rbContem: TRadioButton
    Left = 119
    Top = 40
    Width = 116
    Height = 17
    Caption = 'Cont'#233'm [Ctrl+2]'
    TabOrder = 7
    OnClick = rbContemClick
  end
  object chkDiferMaiusculasMinusculas: TCheckBox
    Left = 416
    Top = 11
    Width = 280
    Height = 17
    Caption = 'Diferenciar Mai'#250'sculas de Min'#250'sculas [Ctrl+3]'
    TabOrder = 8
    OnClick = chkDiferMaiusculasMinusculasClick
  end
  object chkListarTudo: TCheckBox
    Left = 647
    Top = 39
    Width = 130
    Height = 17
    Caption = 'Listar tudo [Ctrl+4]'
    TabOrder = 9
    OnClick = chkListarTudoClick
  end
  object dsGrid: TDataSource
    Left = 44
    Top = 104
  end
end
