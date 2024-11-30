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
    Left = 717
    Top = 459
    Width = 60
    Height = 15
    Anchors = [akTop, akRight]
    Caption = 'Registros: 0'
  end
  object btnPrimPag: TSpeedButton
    Left = 190
    Top = 455
    Width = 93
    Height = 24
    Caption = '[Ctrl+PgUp]   |<<'
    OnClick = btnPrimPagClick
  end
  object btnPagAnt: TSpeedButton
    Left = 299
    Top = 455
    Width = 68
    Height = 24
    Caption = '[PgUp]   <'
    OnClick = btnPagAntClick
  end
  object btnProxPag: TSpeedButton
    Left = 531
    Top = 455
    Width = 58
    Height = 24
    Caption = '[PgDn]   >'
    OnClick = btnProxPagClick
  end
  object btnUltPag: TSpeedButton
    Left = 595
    Top = 455
    Width = 102
    Height = 24
    Caption = '[Ctrl+PgDn]   >>|'
    OnClick = btnUltPagClick
  end
  object Label1: TLabel
    Left = 373
    Top = 459
    Width = 23
    Height = 15
    Caption = 'P'#225'g.'
  end
  object Label2: TLabel
    Left = 455
    Top = 459
    Width = 13
    Height = 15
    Caption = 'de'
  end
  object Label3: TLabel
    Left = 8
    Top = 12
    Width = 237
    Height = 15
    Caption = '[F3] Pr'#243'x. Campo   |   [Ctrl+F3] Campo Anter.'
  end
  object Label8: TLabel
    Left = 4
    Top = 459
    Width = 155
    Height = 15
    Caption = '[ENTER] Escolher selecionado'
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
    Height = 384
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
    Left = 403
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
    Left = 474
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
    Top = 9
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
    Caption = '[F11] Diferenciar Mai'#250'sculas de Min'#250'sculas'
    TabOrder = 8
    OnClick = chkDiferMaiusculasMinusculasClick
  end
  object chkListarTudo: TCheckBox
    Left = 647
    Top = 40
    Width = 130
    Height = 17
    Caption = '[F12] Listar tudo'
    TabOrder = 9
    OnClick = chkListarTudoClick
  end
  object dsGrid: TDataSource
    Left = 44
    Top = 104
  end
end
