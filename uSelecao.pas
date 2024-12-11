unit uSelecao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,  FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Generics.Collections;

type
  ISelecao = interface;
  ISelecaoQuery = interface;
  ISelecaoQueryParam = interface;
  ISelecaoQueryParams = interface;
  ISelecaoColuna = interface;
  ISelecaoColunas = interface;
  ISelecaoIniciarBuscaPor = interface;

  TSelecao = class;
  TSelecaoQuery = class;
  TSelecaoQueryParam = class;
  TSelecaoQueryParams = class;
//  TSelecaoColuna = class;
//  TSelecaoColunas = class;
  TSelecaoIniciarBuscaPor = class;

  ISelecaoRetorno = interface
    function GetOk: Boolean;
    function GetDataSet: TDataSet;
    property Ok: Boolean read GetOk;
    property DataSet: TDataSet read GetDataSet;
  end;

  TSelecaoRetorno = class(TInterfacedObject, ISelecaoRetorno)
  private
    FOk: Boolean;
    FDataSet: TDataSet;
    function GetOk: Boolean;
    procedure SetOk(AOk: Boolean);
    function GetDataSet: TDataSet;
    procedure SetValores(AOk: Boolean; ADataSet: TDataSet);
  public
    property Ok: Boolean read GetOk;
    property DataSet: TDataSet read GetDataSet;
    constructor Create(AOk: Boolean; ADataSet: TDataSet); reintroduce; overload;
    destructor Destroy; reintroduce; override;
  end;

  ISelecaoColuna = interface
    // Getter
    function GetAlias(): String;
    function GetNomeExplicito(): String;
    function GetTitulo(): String;
    function GetExibir(): Boolean;
    function GetPermitirFiltro(): Boolean;
    function GetLargura(): Integer;
    // Setter
    function Titulo(ATitulo: String): ISelecaoColuna;
    function Largura(ALargura: Integer): ISelecaoColuna;
    function Exibir(AExibir: Boolean): ISelecaoColuna;
    function PermitirFiltro(APermitirFiltro: Boolean): ISelecaoColuna;
    function &End: ISelecaoColunas;
  end;

  TSelecaoColunasCollection = TDictionary<String, ISelecaoColuna>;
  ISelecaoColunas = interface
    function GetItems(): TSelecaoColunasCollection;
    function Coluna(AAlias: String): ISelecaoColuna;
    function &End: ISelecao;
  end;

//  TSelecaoColunaProps = record
//    NomeExplicito: String;
//    Titulo: String;
//    Exibir: Boolean;
//    PermitirFiltro: Boolean;
//    Largura: Integer;
//    procedure Init;
//  end;
//  TSelecaoColunasCollection = TDictionary<String, TSelecaoColunaProps>;

  TSelecaoColuna = class(TInterfacedObject, ISelecaoColuna)
  private
    FParent: ISelecaoColunas;
    FAlias: String;
    FNomeExplicito: String;
    FTitulo: String;
    FExibir: Boolean;
    FPermitirFiltro: Boolean;
    FLArgura: Integer;
  public
    // Getter
    function GetAlias(): String;
    function GetNomeExplicito(): String;
    function GetTitulo(): String;
    function GetExibir(): Boolean;
    function GetPermitirFiltro(): Boolean;
    function GetLargura(): Integer;
    // Setter
    function Titulo(ATitulo: String): ISelecaoColuna;
    function Exibir(AExibir: Boolean): ISelecaoColuna;
    function PermitirFiltro(APermitirFiltro: Boolean): ISelecaoColuna;
    function Largura(ALargura: Integer): ISelecaoColuna;
    function &End: ISelecaoColunas;

    constructor Create(AParent: ISelecaoColunas; AAlias: String); reintroduce; overload;
  end;

  TSelecaoColunas = class(TInterfacedObject, ISelecaoColunas)
  private
    FParent: ISelecao;
    FColecaoColunas: TSelecaoColunasCollection;
  public
    function GetItems(): TSelecaoColunasCollection;
    function Coluna(AAlias: String): ISelecaoColuna;
    function &End: ISelecao;
    constructor Create(AParent: ISelecao); reintroduce; overload;
    destructor Destroy; reintroduce; override;
  end;

  ISelecaoIniciarBuscaPor = interface
    // Getters
    function GetColuna: String;
    function GetValor: String;
    // Setters
    function Coluna(AColuna: String): ISelecaoIniciarBuscaPor;
    function ComValor(AValor: String): ISelecaoIniciarBuscaPor;
    function &End: ISelecao;
  end;

  TSelecaoIniciarBuscaPor = class(TInterfacedObject, ISelecaoIniciarBuscaPor)
  private
    FParent: ISelecao;
    FColuna: String;
    FValor: String;
  public
    // Getters
    function GetColuna: String;
    function GetValor: String;
    // Setters
    function Coluna(AColuna: String): ISelecaoIniciarBuscaPor;
    function ComValor(AValor: String): ISelecaoIniciarBuscaPor;
    function &End: ISelecao;
    constructor Create(AParent: ISelecao); reintroduce; overload;
    destructor Destroy; reintroduce; override;
  end;

  ISelecaoQueryParam = interface
    // Getters
    function GetName: String;
    function GetType: TFieldType;
    function GetAsInteger: Integer;
    function GetAsFloat: Double;
    function GetAsDateTime: TDateTime;
    function GetAsBoolean: Boolean;
    function GetAsString: String;
    // Setters
    function AsInteger(AValue: Integer): ISelecaoQueryParams;
    function AsFloat(AValue: Double): ISelecaoQueryParams;
    function AsDateTime(AValue: TDateTime): ISelecaoQueryParams;
    function AsBoolean(AValue: Boolean): ISelecaoQueryParams;
    function AsString(AValue: String): ISelecaoQueryParams;
  end;

  ISelecaoQueryParams = interface
    // Getters
    function GetItems: TDictionary<String, ISelecaoQueryParam>;
    function GetParamByName(AName: String): ISelecaoQueryParam;
    function GetCount: Integer;
    // Setters
    function Param(AName: String): ISelecaoQueryParam;
    function &End: ISelecaoQuery;
  end;

  TSelecaoQueryParam = class(TInterfacedObject, ISelecaoQueryParam)
  private
    FParent: ISelecaoQueryParams;
    FName: String;
    FType: TFieldType;
    FValue: packed record
      ValueInteger: Integer;
      ValueFloat: Double;
      ValueDateTime: TDateTime;
      ValueBoolean: Boolean;
      ValueString: String;
    end;
  public
    // Getters
    function GetName: String;
    function GetType: TFieldType;
    function GetAsInteger: Integer;
    function GetAsFloat: Double;
    function GetAsDateTime: TDateTime;
    function GetAsBoolean: Boolean;
    function GetAsString: String;
    // Setters
    function AsInteger(AValue: Integer): ISelecaoQueryParams;
    function AsFloat(AValue: Double): ISelecaoQueryParams;
    function AsDateTime(AValue: TDateTime): ISelecaoQueryParams;
    function AsBoolean(AValue: Boolean): ISelecaoQueryParams;
    function AsString(AValue: String): ISelecaoQueryParams;
    constructor Create(AParent: ISelecaoQueryParams); reintroduce; overload;
    destructor Destroy; reintroduce; override;
  end;

  TSelecaoQueryParams = class(TInterfacedObject, ISelecaoQueryParams)
  private
    FParent: ISelecaoQuery;
//    TSelecaoQueryParamsCollection = TDictionary<String, ISelecaoQueryParam>;
    FParams: TDictionary<String, ISelecaoQueryParam>;
  public
    // Getters
    function GetItems: TDictionary<String, ISelecaoQueryParam>;
    function GetParamByName(AName: String): ISelecaoQueryParam;
    function GetCount: Integer;
    // Setters
    function Param(AName: String): ISelecaoQueryParam;
    function &End: ISelecaoQuery;
    constructor Create(AParent: ISelecaoQuery); reintroduce; overload;
    destructor Destroy; reintroduce; override;
  end;

  ISelecaoQuery = interface
    // Getters
    function GetSelect: String;
    function GetFrom: String;
    function GetJoins: TStrings;
    function GetFiltros: TStrings;
    function GetGroupBy: String;
    function GetHaving: TStrings;
    function GetOrderBy: String;
    // Setters
    function Select(ASelect: String): ISelecaoQuery;
    function From(AFrom: String): ISelecaoQuery;
    function InnerJoin(AExpressao: String): ISelecaoQuery;
    function LeftJoin(AExpressao: String): ISelecaoQuery;
    function Where(ACondicao: String): ISelecaoQuery;
    function GroupBy(AGroupBy: String): ISelecaoQuery;
    function Having(ACondicao: String): ISelecaoQuery;
    function OrderBy(AOrderBy: String): ISelecaoQuery;
    function Params: ISelecaoQueryParams;

    function &End: ISelecao;
  end;

  TSelecaoQuery = class(TInterfacedObject, ISelecaoQuery)
  private
    FParent: ISelecao;
    FSelect: String;
    FFrom: String;
    FJoins: TStrings;
    FFiltros: TStrings;
    FGroupBy: String;
    FHaving: TStrings;
    FOrderBy: String;
    FParams: ISelecaoQueryParams;
  public
    // Getters
    function GetSelect: String;
    function GetFrom: String;
    function GetJoins: TStrings;
    function GetFiltros: TStrings;
    function GetGroupBy: String;
    function GetHaving: TStrings;
    function GetOrderBy: String;
    // Setters
    function Select(ASelect: String): ISelecaoQuery;
    function From(AFrom: String): ISelecaoQuery;
    function InnerJoin(AExpressao: String): ISelecaoQuery;
    function LeftJoin(AExpressao: String): ISelecaoQuery;
    function Where(ACondicao: String): ISelecaoQuery;
    function GroupBy(AGroupBy: String): ISelecaoQuery;
    function Having(ACondicao: String): ISelecaoQuery;
    function OrderBy(AOrderBy: String): ISelecaoQuery;

    function Params: ISelecaoQueryParams;
    function &End: ISelecao;

    constructor Create(AParent: ISelecao); reintroduce; overload;
    destructor Destroy; reintroduce; override;
  end;

  ISelecao = interface
    function Titulo(ATitulo: String): ISelecao;
    function Query: ISelecaoQuery;
    function Colunas: ISelecaoColunas;
    function IniciarBuscaPor: ISelecaoIniciarBuscaPor;
    function ListarTudo(): ISelecao;
    function Conexao(AConexao: TFDConnection): ISelecao;
    function Executar: ISelecaoRetorno;
  end;

  TSelecao = class(TInterfacedObject, ISelecao)
  private
    FTitulo: String;
    FSelecaoQuery: ISelecaoQuery;
    FColunas: ISelecaoColunas;
    FIniciarBuscaPor: ISelecaoIniciarBuscaPor;
    FListarTudo: Boolean;
    FConexao: TFDConnection;
  public
    function Titulo(ATitulo: String): ISelecao;
    function Query: ISelecaoQuery;
    function Colunas: ISelecaoColunas;
    function IniciarBuscaPor: ISelecaoIniciarBuscaPor;
    function ListarTudo(): ISelecao;
    function Conexao(AConexao: TFDConnection): ISelecao;
    function Executar: ISelecaoRetorno;

    class function New(): ISelecao;

    constructor Create; reintroduce;
    destructor Destroy; reintroduce; override;
  end;

  TFormSelecao = class(TForm)
    btnVoltar: TButton;
    Grid: TDBGrid;
    edtBusca: TEdit;
    dsGrid: TDataSource;
    lblRegistros: TLabel;
    btnPrimPag: TSpeedButton;
    btnPagAnt: TSpeedButton;
    btnProxPag: TSpeedButton;
    btnUltPag: TSpeedButton;
    edtPaginaAtual: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtTotalPaginas: TEdit;
    cbFiltrar: TComboBox;
    rbInicia: TRadioButton;
    rbContem: TRadioButton;
    chkDiferMaiusculasMinusculas: TCheckBox;
    Label3: TLabel;
    chkListarTudo: TCheckBox;
    Label8: TLabel;
    procedure btnVoltarClick(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure edtBuscaChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtBuscaKeyPress(Sender: TObject; var Key: Char);
    procedure btnProxPagClick(Sender: TObject);
    procedure btnUltPagClick(Sender: TObject);
    procedure btnPagAntClick(Sender: TObject);
    procedure btnPrimPagClick(Sender: TObject);
    procedure cbFiltrarClick(Sender: TObject);
    procedure rbIniciaClick(Sender: TObject);
    procedure rbContemClick(Sender: TObject);
    procedure chkListarTudoClick(Sender: TObject);
    procedure chkDiferMaiusculasMinusculasClick(Sender: TObject);
    procedure GridMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtPaginaAtualKeyPress(Sender: TObject; var Key: Char);
    procedure edtPaginaAtualExit(Sender: TObject);
  private
    { Private declarations }
    FSelecaoQuery: ISelecaoQuery;
    FColunas: TSelecaoColunasCollection;
    FListaAlias: TStrings;

    FIniciarBuscaPor: ISelecaoIniciarBuscaPor;
    FConexao: TFDConnection;

    FQuery: TFDQuery;
    FRetorno: ISelecaoRetorno;

    FPagina: Integer;
    FTotalRegistros: Integer;
    FTotalPaginas: Integer;

    procedure CarregarTodasColunas;

    procedure Retornar(AOk: Boolean);
    procedure ConfirmarSelecao;
    procedure ExecutarBusca(APagina: Integer);
    procedure ContarRegistros(AQuery: TFDQuery; out ATotalRegistros: Integer; out ATotalPaginas: Integer);
    procedure TratarColunas;
    procedure AtualizarPaginacao;
  public
    { Public declarations }
    property Retorno: ISelecaoRetorno read FRetorno;
    constructor Create(
      AOwner: TComponent;
      ATitulo: String;
      ASelecaoQuery: ISelecaoQuery;
      AColunas: ISelecaoColunas;
      AIniciarBuscaPor: ISelecaoIniciarBuscaPor;
      AListarTudo: Boolean;
      AConexao: TFDConnection); reintroduce; overload;
    destructor Destroy; reintroduce; override;
  end;

function Seleciona: ISelecao;

implementation

{$R *.dfm}

const LIMITE = 16;

function Seleciona: ISelecao;
begin
  Result := TSelecao.Create;
end;

function Concatenar(AList: TArray<String>; AStr: String; ALimit: Integer): String;
begin
  Result := '';
  for var I := Low(AList) to ALimit do
  begin
    if Result <> '' then
      Result := Result + AStr;
    Result := Result + AList[I];
  end;
end;

{ TSelecaoRetorno }

constructor TSelecaoRetorno.Create(AOk: Boolean; ADataSet: TDataSet);
begin
  inherited Create;
  SetValores(AOk, ADataSet);
end;

destructor TSelecaoRetorno.Destroy;
begin
  if Assigned(FDataSet) then
    FDataSet.Free;
  inherited;
end;

function TSelecaoRetorno.GetDataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TSelecaoRetorno.GetOk: Boolean;
begin
  Result := FOk;
end;

procedure TSelecaoRetorno.SetOk(AOk: Boolean);
begin
  SetValores(AOk, FDataSet);
end;

procedure TSelecaoRetorno.SetValores(AOk: Boolean; ADataSet: TDataSet);
begin
  if ADataSet <> FDataSet then
  begin
    if Assigned(FDataSet) then
      FDataSet.Free;
    FDataSet := ADataSet;
  end;
  if ((not Assigned(FDataSet)) or FDataSet.IsEmpty) then
    FOk := False
  else
    FOk := AOk;
end;

{ TFormSelecao }

procedure TFormSelecao.AtualizarPaginacao;
begin
  edtPaginaAtual.Text := IntToStr(FPagina);
  edtTotalPaginas.Text := IntToStr(FTotalPaginas);
  lblRegistros.Caption := 'Registros: ' + IntToStr(FTotalRegistros);
end;

procedure TFormSelecao.btnVoltarClick(Sender: TObject);
begin
  Retornar(False);
end;

procedure TFormSelecao.CarregarTodasColunas;
//var
//  LTokens: TArray<String>;
begin
//  LTokens := FSelect.Split([',']);
  for var LToken in FSelecaoQuery.GetSelect.Split([',']) do
  begin
    var LParts := LToken.Trim().Split([' ']);
    if Length(LParts) = 0 then Continue;

    var LAlias := '';
    var LCompleto := '';
    if Length(LParts) > 1 then
    begin
      LAlias := LParts[Length(LParts) - 1].Trim();
      var LLimite := 0;
      if SameText(LParts[Length(LParts) - 2].Trim(), 'as') then
        LLimite := Length(LParts) - 3
      else
        LLimite := Length(LParts) - 2;
      LCompleto := Concatenar(LParts, ' ', LLimite);
    end
    else
    begin
      var LParts2 := LParts[0].Split(['.']);
      if Length(LParts2) > 1 then
        LAlias := LParts2[Length(LParts2) - 1]
      else
        LAlias := LParts[0];
      LCompleto := LParts[0];
    end;
    LAlias := LAlias.Trim();
    LCompleto := LCompleto.Trim();

    if LAlias.Contains('+') or LAlias.Contains('-') or LAlias.Contains('*') or LAlias.Contains('/') or LAlias.Contains('(') or LAlias.Contains(')') then
      Continue;

    var LValue := '';
    var LDic := TDictionary<String, String>.Create;
    try
      LDic.TryGetValue(LAlias, LValue);
      LValue := LCompleto;
      LDic.AddOrSetValue(LAlias, LValue);
    finally
      LDic.Free;
    end;

    ShowMessage(LValue + ' ======= ' + LAlias);
    //FListaAlias.Add(LAlias);
  end;
end;

procedure TFormSelecao.cbFiltrarClick(Sender: TObject);
begin
  ExecutarBusca(1);
end;

procedure TFormSelecao.chkDiferMaiusculasMinusculasClick(Sender: TObject);
begin
  ExecutarBusca(1);
end;

procedure TFormSelecao.chkListarTudoClick(Sender: TObject);
begin
  if chkListarTudo.Checked then
  begin
    edtBusca.OnChange := nil;
    try
      edtBusca.Text := '';
    finally
      edtBusca.OnChange := edtBuscaChange;
    end;
  end;
  ExecutarBusca(1);
end;

procedure TFormSelecao.ConfirmarSelecao;
begin
  if dsGrid.DataSet.IsEmpty then Exit;
  Retornar(True);
end;

procedure TFormSelecao.ContarRegistros(AQuery: TFDQuery; out ATotalRegistros: Integer; out ATotalPaginas: Integer);
var
  qryAux: TFDQuery;
begin
  qryAux := TFDQuery.Create(nil);
  try
    qryAux.Connection := AQuery.Connection;
    qryAux.SQL.Text := 'SELECT COUNT(*) AS TOTAL FROM (' + AQuery.SQL.Text + ')';
    for var I := 0  to AQuery.ParamCount -1 do
      qryAux.ParamByName(AQuery.Params[I].Name).Value := AQuery.Params[I].Value;
    qryAux.Open;
    ATotalRegistros := qryAux.FieldByName('TOTAL').AsInteger;
    ATotalPaginas := ATotalRegistros div LIMITE;
    if (ATotalRegistros mod LIMITE) > 0 then
      Inc(ATotalPaginas);
  finally
    qryAux.Free;
  end;
end;

constructor TFormSelecao.Create(
  AOwner: TComponent;
  ATitulo: String;
  ASelecaoQuery: ISelecaoQuery;
  AColunas: ISelecaoColunas;
  AIniciarBuscaPor: ISelecaoIniciarBuscaPor;
  AListarTudo: Boolean;
  AConexao: TFDConnection);
begin
  inherited Create(AOwner);
  Caption := ATitulo;
  FSelecaoQuery := ASelecaoQuery;

  // AColunas vai conter apenas as colunas que têm alguma personalização
  FColunas := AColunas.GetItems();
  FListaAlias := TStringList.Create;
  // Carrega as demais colunas da cláusula select completando FColunas e também alimenta a lista de aliases FListaAlias
  CarregarTodasColunas;

  FIniciarBuscaPor := AIniciarBuscaPor;
  FConexao := AConexao;

  FPagina := 0;
  FTotalRegistros := 0;
  FTotalPaginas := 0;

  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := FConexao;
  FRetorno := TSelecaoRetorno.Create(False, FQuery);

  edtBusca.OnChange := nil;
  chkDiferMaiusculasMinusculas.OnClick := nil;
  chkListarTudo.OnClick := nil;
  rbInicia.OnClick := nil;
  try
    edtBusca.Text := FIniciarBuscaPor.GetValor;
    chkDiferMaiusculasMinusculas.Checked := False;
    chkListarTudo.Checked := AListarTudo;
    rbInicia.Checked := True;
  finally
    edtBusca.OnChange := edtBuscaChange;
    chkDiferMaiusculasMinusculas.OnClick := chkDiferMaiusculasMinusculasClick;
    chkListarTudo.OnClick := chkListarTudoClick;
    rbInicia.OnClick := rbIniciaClick;
  end;
  dsGrid.DataSet := FQuery;
end;

destructor TFormSelecao.Destroy;
begin
//    FSelecaoQuery.Free;
//    FIniciarBuscaPor.Free;
  FColunas.Free;
  FListaAlias.Free;

  // Objeto FQuery será transferido para FRetorno e não deve ser destruído aqui
  inherited;
end;

procedure TFormSelecao.edtBuscaChange(Sender: TObject);
begin
  if chkListarTudo.Checked then
    chkListarTudo.Checked := False
  else
    ExecutarBusca(1);
end;

procedure TFormSelecao.edtBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DOWN then
  begin
    Grid.SetFocus;
  end;
end;

procedure TFormSelecao.edtBuscaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Grid.SetFocus;
  end;
end;

procedure TFormSelecao.edtPaginaAtualExit(Sender: TObject);
begin
  edtPaginaAtual.Text := IntToStr(FPagina);
end;

procedure TFormSelecao.edtPaginaAtualKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    ExecutarBusca(StrToIntDef(edtPaginaAtual.Text, 1));
    Grid.SetFocus;
  end;
end;

procedure TFormSelecao.ExecutarBusca(APagina: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT ' + FSelecaoQuery.GetSelect);
  FQuery.SQL.Add('FROM ' + FSelecaoQuery.GetFrom);

  for var I := 0 to FSelecaoQuery.GetJoins.Count - 1 do
    FQuery.SQL.Add(FSelecaoQuery.GetJoins[I]);

  FQuery.SQL.Add('WHERE 1 = 1 ');
  for var I := 0 to FSelecaoQuery.GetFiltros.Count - 1 do
    FQuery.SQL.Add('AND ' + FSelecaoQuery.GetFiltros[I]);

  if not chkListarTudo.Checked then
  begin
    if (edtBusca.Text <> '') then
    begin
      var vBusca := edtBusca.Text + '%';
      if rbContem.Checked then
        vBusca := '%' + vBusca;

      if chkDiferMaiusculasMinusculas.Checked then
      begin
        FQuery.SQL.Add('AND ' + FColunas.Items[FListaAlias[cbFiltrar.ItemIndex]].GetNomeExplicito + ' LIKE :P_BUSCA');
        FQuery.ParamByName('P_BUSCA').AsString := vBusca;
      end
      else
      begin
        FQuery.SQL.Add('AND UPPER(' + FColunas.Items[FListaAlias[cbFiltrar.ItemIndex]].GetNomeExplicito + ') LIKE :P_BUSCA');
        FQuery.ParamByName('P_BUSCA').AsString := AnsiUpperCase(vBusca);
      end;
    end
    else
      FQuery.SQL.Add('AND 1 = 0');
  end;

  if FSelecaoQuery.GetGroupBy <> '' then
    FQuery.SQL.Add('GROUP BY ' + FSelecaoQuery.GetGroupBy);

  if FSelecaoQuery.GetHaving.Count > 0 then
  begin
    FQuery.SQL.Add('HAVING 1 = 1 ');
    for var I := 0 to FSelecaoQuery.GetHaving.Count - 1 do
      FQuery.SQL.Add('AND ' + FSelecaoQuery.GetHaving[I]);
  end;

  if FSelecaoQuery.GetOrderBy <> '' then
    FQuery.SQL.Add('ORDER BY ' + FSelecaoQuery.GetOrderBy);

  ContarRegistros(FQuery, FTotalRegistros, FTotalPaginas);

  FPagina := APagina;
  if FPagina > FTotalPaginas then
    FPagina := FTotalPaginas;
  if FPagina < 1 then
    FPagina := 1;

  FQuery.SQL.Add('OFFSET :P_SKIP ROWS');
  FQuery.SQL.Add('FETCH FIRST :P_LIMIT ROWS ONLY');
  FQuery.ParamByName('P_SKIP').AsInteger  := (FPagina - 1) * LIMITE;
  FQuery.ParamByName('P_LIMIT').AsInteger := LIMITE;

  FQuery.Open();

  if rbInicia.Checked then
  begin
    if FQuery.FieldByName(FListaAlias[cbFiltrar.ItemIndex]) is TStringField then
      if not FQuery.Locate(FListaAlias[cbFiltrar.ItemIndex], edtbusca.Text, []) then
        FQuery.Locate(FListaAlias[cbFiltrar.ItemIndex], edtbusca.Text, [loPartialKey]);
  end;

  if FQuery.IsEmpty then
    FPagina := 0;

  TratarColunas;
  AtualizarPaginacao;
end;

procedure TFormSelecao.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  begin
    case Key of
      VK_PRIOR: btnPagAnt.Click;
      VK_NEXT: btnProxPag.Click;
      VK_F3:
      begin
        cbFiltrar.ItemIndex := cbFiltrar.ItemIndex + 1;
        ExecutarBusca(1);
      end;
    end;
  end
  else if Shift = [ssCtrl] then
  begin
    case Key of
      Ord('1'): rbInicia.Checked := True;
      Ord('2'): rbContem.Checked := True;
      Ord('3'): chkDiferMaiusculasMinusculas.Checked := not chkDiferMaiusculasMinusculas.Checked;
      Ord('4'): chkListarTudo.Checked := not chkListarTudo.Checked;
      VK_PRIOR: btnPrimPag.Click;
      VK_NEXT: btnUltPag.Click;
      VK_F3:
      begin
        if cbFiltrar.ItemIndex > 0 then
        begin
          cbFiltrar.ItemIndex := cbFiltrar.ItemIndex - 1;
          ExecutarBusca(1);
        end;
      end;
    end;
  end;
end;

procedure TFormSelecao.FormShow(Sender: TObject);
begin
  var vIndex := 0;
  cbFiltrar.OnClick := nil;
  try
    cbFiltrar.Items.Clear;
    for var LCol in FListaAlias do
    begin
      var LColuna := FColunas.Items[LCol];
      if not LColuna.GetPermitirFiltro() then Continue;

      if LColuna.GetTitulo() <> '<not assigned>' then
        cbFiltrar.Items.Add(LColuna.GetTitulo())
      else
        cbFiltrar.Items.Add(LCol);

      if SameText(LCol, FIniciarBuscaPor.GetColuna) then
        vIndex := cbFiltrar.GetCount - 1;
    end;
    cbFiltrar.ItemIndex := vIndex;
  finally
    cbFiltrar.OnClick := cbFiltrarClick;
  end;
  edtBusca.SetFocus;
  ExecutarBusca(1);
end;

procedure TFormSelecao.GridDblClick(Sender: TObject);
begin
  ConfirmarSelecao;
end;

procedure TFormSelecao.GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    ConfirmarSelecao;
  end
  else if (Key = VK_UP) then
  begin
    if dsGrid.DataSet.IsEmpty or (dsGrid.DataSet.RecNo = 1) then
      edtBusca.SetFocus;
  end;
end;

procedure TFormSelecao.GridMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Shift = [ssRight]) and (Button = TMouseButton.mbRight) then
  begin
    chkListarTudo.Checked := True;
  end;
end;

procedure TFormSelecao.rbContemClick(Sender: TObject);
begin
  ExecutarBusca(1);
end;

procedure TFormSelecao.rbIniciaClick(Sender: TObject);
begin
  ExecutarBusca(1);
end;

procedure TFormSelecao.Retornar(AOk: Boolean);
begin
  TSelecaoRetorno(FRetorno).SetOk(AOk);
  Close;
end;

procedure TFormSelecao.btnPrimPagClick(Sender: TObject);
begin
  ExecutarBusca(1);
end;

procedure TFormSelecao.btnPagAntClick(Sender: TObject);
begin
  ExecutarBusca(FPagina - 1);
end;

procedure TFormSelecao.btnProxPagClick(Sender: TObject);
begin
  ExecutarBusca(FPagina + 1);
end;

procedure TFormSelecao.btnUltPagClick(Sender: TObject);
begin
  ExecutarBusca(FTotalPaginas);
end;

procedure TFormSelecao.TratarColunas;
begin
  if FColunas.Count > 0 then
  begin
    for var LColuna in FColunas do
    begin
      var vField := FQuery.FindField(LColuna.Key);
      if Assigned(vField) then
      begin
        vField.Visible := LColuna.Value.GetExibir();
        if LColuna.Value.GetTitulo() <> '<not assigned>' then
          vField.DisplayLabel := LColuna.Value.GetTitulo()
        else
          vField.DisplayLabel := LColuna.Key;

        if LColuna.Value.GetLargura() <> -1 then
          vField.DisplayWidth := LColuna.Value.GetLargura();
      end;
    end;
  end;
end;

{ TSelecao }

function TSelecao.IniciarBuscaPor: ISelecaoIniciarBuscaPor;
begin
  Result := FIniciarBuscaPor;
end;

function TSelecao.Colunas: ISelecaoColunas;
begin
  Result := FColunas;
end;

function TSelecao.Conexao(AConexao: TFDConnection): ISelecao;
begin
  FConexao := AConexao;
  Result := Self;
end;

constructor TSelecao.Create;
begin
  inherited;
  FTitulo          := '';
  FSelecaoQuery := TSelecaoQuery.Create(Self);
  FColunas := TSelecaoColunas.Create(Self);
  FIniciarBuscaPor := TSelecaoIniciarBuscaPor.Create(Self);
  FListarTudo      := False;
  FConexao         := nil;
end;

destructor TSelecao.Destroy;
begin
//  FColunas.Free;
//  FSelecaoQuery.Free;
//  FIniciarBuscaPor.Free;
  ShowMessage('TSelecao.Destroy');
  inherited;
end;

function TSelecao.Executar: ISelecaoRetorno;
var
  FormSelecao: TFormSelecao;
begin
  FormSelecao := TFormSelecao.Create(
    nil,
    FTitulo,
    FSelecaoQuery,
    FColunas,
    FIniciarBuscaPor,
    FListarTudo,
    FConexao
  );
  try
    FormSelecao.ShowModal;
    Result := FormSelecao.Retorno;
  finally
    FormSelecao.Free;
  end;
end;

function TSelecao.ListarTudo: ISelecao;
begin
  FListarTudo := True;
  Result := Self;
end;

class function TSelecao.New: ISelecao;
begin
  Result := TSelecao.Create;
end;

function TSelecao.Query: ISelecaoQuery;
begin
  Result := FSelecaoQuery;
end;

function TSelecao.Titulo(ATitulo: String): ISelecao;
begin
  FTitulo := ATitulo;
  Result := Self;
end;

{ TSelecaoQuery }

constructor TSelecaoQuery.Create(AParent: ISelecao);
begin
  FParent := AParent;

  FParams := TSelecaoQueryParams.Create(Self);
  FSelect          := '';
  FFrom            := '';
  FJoins           := TStringList.Create;
  FFiltros         := TStringList.Create;
  FGroupBy         := '';
  FHaving          := TStringList.Create;
  FOrderBy         := '';
end;

destructor TSelecaoQuery.Destroy;
begin
  FJoins.Free;
  FFiltros.Free;
  FHaving.Free;
//  FParams.Free;
  ShowMessage('TSelecaoQuery.Destroy');
  inherited;
end;

function TSelecaoQuery.&End: ISelecao;
begin
  Result := FParent;
end;

function TSelecaoQuery.From(AFrom: String): ISelecaoQuery;
begin
  FFrom := AFrom;
  Result := Self;
end;

function TSelecaoQuery.GetFiltros: TStrings;
begin
  Result := FFiltros;
end;

function TSelecaoQuery.GetFrom: String;
begin
  Result := FFrom;
end;

function TSelecaoQuery.GetGroupBy: String;
begin
  Result := FGroupBy;
end;

function TSelecaoQuery.GetHaving: TStrings;
begin
  Result := FHaving;
end;

function TSelecaoQuery.GetJoins: TStrings;
begin
  Result := FJoins;
end;

function TSelecaoQuery.GetOrderBy: String;
begin
  Result := FOrderBy;
end;

function TSelecaoQuery.GetSelect: String;
begin
  Result := FSelect;
end;

function TSelecaoQuery.GroupBy(AGroupBy: String): ISelecaoQuery;
begin
  FGroupBy := AGroupBy;
  Result := Self;
end;

function TSelecaoQuery.Having(ACondicao: String): ISelecaoQuery;
begin
  FHaving.Add(ACondicao);
  Result := Self;
end;

function TSelecaoQuery.InnerJoin(AExpressao: String): ISelecaoQuery;
begin
  FJoins.Add('INNER JOIN ' + AExpressao);
  Result := Self;
end;

function TSelecaoQuery.LeftJoin(AExpressao: String): ISelecaoQuery;
begin
  FJoins.Add('LEFT JOIN ' + AExpressao);
  Result := Self;
end;

function TSelecaoQuery.OrderBy(AOrderBy: String): ISelecaoQuery;
begin
  FOrderBy := AOrderBy;
  Result := Self;
end;

function TSelecaoQuery.Params: ISelecaoQueryParams;
begin
  Result := FParams;
end;

function TSelecaoQuery.Select(ASelect: String): ISelecaoQuery;
begin
  FSelect := ASelect;
  Result := Self;
end;

function TSelecaoQuery.Where(ACondicao: String): ISelecaoQuery;
begin
  FFiltros.Add(ACondicao);
  Result := Self;
end;

{ TSelecaoColunaProps }

//procedure TSelecaoColunaProps.Init;
//begin
//  Self.NomeExplicito := '';
//  Self.Titulo := '<not assigned>';
//  Self.Exibir := True;
//  Self.PermitirFiltro := True;
//  Self.Largura := -1;
//end;

{ TSelecaoIniciarBuscaPor }

function TSelecaoIniciarBuscaPor.Coluna(AColuna: String): ISelecaoIniciarBuscaPor;
begin
  FColuna := AColuna;
  Result := Self;
end;

function TSelecaoIniciarBuscaPor.ComValor(AValor: String): ISelecaoIniciarBuscaPor;
begin
  FValor := AValor;
  Result := Self;
end;

constructor TSelecaoIniciarBuscaPor.Create(AParent: ISelecao);
begin
  inherited Create;
  FParent := AParent;
end;

destructor TSelecaoIniciarBuscaPor.Destroy;
begin
  ShowMessage('TSelecaoIniciarBuscaPor.Free');
  //FParent.Free;
  inherited;
end;

function TSelecaoIniciarBuscaPor.&End: ISelecao;
begin
  Result := FParent;
end;

function TSelecaoIniciarBuscaPor.GetColuna: String;
begin
  Result := FColuna;
end;

function TSelecaoIniciarBuscaPor.GetValor: String;
begin
  Result := FValor;
end;

{ TSelecaoQueryParams }

constructor TSelecaoQueryParams.Create(AParent: ISelecaoQuery);
begin
  FParent := AParent;
  FParams := TDictionary<String, ISelecaoQueryParam>.Create;
end;

destructor TSelecaoQueryParams.Destroy;
begin
  FParams.Free;
  ShowMessage('TSelecaoQueryParams.Destroy');
  inherited;
end;

function TSelecaoQueryParams.&End: ISelecaoQuery;
begin
  Result := FParent;
end;

function TSelecaoQueryParams.GetCount: Integer;
begin
  Result := FParams.Count;
end;

function TSelecaoQueryParams.GetItems: TDictionary<String, ISelecaoQueryParam>;
begin
  Result := FParams;
end;

function TSelecaoQueryParams.GetParamByName(AName: String): ISelecaoQueryParam;
begin
  Result := FParams.Items[AName];
end;

function TSelecaoQueryParams.Param(AName: String): ISelecaoQueryParam;
begin
  if not FParams.TryGetValue(AName, Result) then
  begin
    Result := TSelecaoQueryParam.Create(Self);
    FParams.Add(AName, Result);
  end;
end;

{ TSelecaoQueryParam }

function TSelecaoQueryParam.AsBoolean(AValue: Boolean): ISelecaoQueryParams;
begin
  FType := ftBoolean;
  FValue.ValueBoolean := AValue;
  Result := FParent;
end;

function TSelecaoQueryParam.AsDateTime(AValue: TDateTime): ISelecaoQueryParams;
begin
  FType := ftDateTime;
  FValue.ValueDateTime := AValue;
  Result := FParent;
end;

function TSelecaoQueryParam.AsFloat(AValue: Double): ISelecaoQueryParams;
begin
  FType := ftFloat;
  FValue.ValueFloat := AValue;
  Result := FParent;
end;

function TSelecaoQueryParam.AsInteger(AValue: Integer): ISelecaoQueryParams;
begin
  FType := ftInteger;
  FValue.ValueInteger := AValue;
  Result := FParent;
end;

function TSelecaoQueryParam.AsString(AValue: String): ISelecaoQueryParams;
begin
  FType := ftString;
  FValue.ValueString := AValue;
  Result := FParent;
end;

constructor TSelecaoQueryParam.Create(AParent: ISelecaoQueryParams);
begin
  FParent := AParent;
  FType := ftUnknown;
end;

destructor TSelecaoQueryParam.Destroy;
begin
  ShowMessage('TSelecaoQueryParam.Destroy');
  inherited;
end;

function TSelecaoQueryParam.GetAsBoolean: Boolean;
begin
  if FType <> ftBoolean then
    raise Exception.Create('Not a boolean value');
  Result := FValue.ValueBoolean;
end;

function TSelecaoQueryParam.GetAsDateTime: TDateTime;
begin
  if FType <> ftDateTime then
    raise Exception.Create('Not a date and time value');
  Result := FValue.ValueDateTime;
end;

function TSelecaoQueryParam.GetAsFloat: Double;
begin
  if FType <> ftFloat then
    raise Exception.Create('Not a float value');
  Result := FValue.ValueFloat;
end;

function TSelecaoQueryParam.GetAsInteger: Integer;
begin
  if FType <> ftInteger then
    raise Exception.Create('Not an integer value');
  Result := FValue.ValueInteger;
end;

function TSelecaoQueryParam.GetAsString: String;
begin
  if FType <> ftString then
    raise Exception.Create('Not a string value');
  Result := FValue.ValueString;
end;

function TSelecaoQueryParam.GetName: String;
begin
  Result := FName;
end;

function TSelecaoQueryParam.GetType: TFieldType;
begin
  Result := FType;
end;

{ TSelecaoColuna }

constructor TSelecaoColuna.Create(AParent: ISelecaoColunas; AAlias: String);
begin
  Self.FParent := AParent;
  Self.FAlias := AAlias;
  Self.FNomeExplicito := '';
  Self.FTitulo := '<not assigned>';
  Self.FExibir := True;
  Self.FPermitirFiltro := True;
  Self.FLargura := -1;
end;

function TSelecaoColuna.&End: ISelecaoColunas;
begin
  Result := FParent;
end;

function TSelecaoColuna.Exibir(AExibir: Boolean): ISelecaoColuna;
begin
  FExibir := AExibir;
  Result := Self;
end;

function TSelecaoColuna.GetAlias: String;
begin
  Result := FAlias;
end;

function TSelecaoColuna.GetExibir: Boolean;
begin
  Result := FExibir;
end;

function TSelecaoColuna.GetLargura: Integer;
begin
  Result := FLargura;
end;

function TSelecaoColuna.GetNomeExplicito: String;
begin
  Result := FNomeExplicito;
end;

function TSelecaoColuna.GetPermitirFiltro: Boolean;
begin
  Result := FPermitirFiltro;
end;

function TSelecaoColuna.GetTitulo: String;
begin
  Result := FTitulo;
end;

function TSelecaoColuna.Largura(ALargura: Integer): ISelecaoColuna;
begin
  FLArgura := ALargura;
  Result := Self;
end;

function TSelecaoColuna.PermitirFiltro(APermitirFiltro: Boolean): ISelecaoColuna;
begin
  FPermitirFiltro := APermitirFiltro;
  Result := Self;
end;

function TSelecaoColuna.Titulo(ATitulo: String): ISelecaoColuna;
begin
  FTitulo := ATitulo;
  Result := Self;
end;

{ TSelecaoColunas }

function TSelecaoColunas.Coluna(AAlias: String): ISelecaoColuna;
begin
  if not FColecaoColunas.TryGetValue(AAlias, Result) then
  begin
    Result := TSelecaoColuna.Create(Self, AAlias);
    FColecaoColunas.Add(AAlias, Result)
  end;

end;

constructor TSelecaoColunas.Create(AParent: ISelecao);
begin
  inherited Create;
  FParent := AParent;
  FColecaoColunas := TSelecaoColunasCollection.Create;
end;

destructor TSelecaoColunas.Destroy;
begin
  FColecaoColunas.Free;
  ShowMessage('TSelecaoColunas.Destroy');
  inherited;
end;

function TSelecaoColunas.&End: ISelecao;
begin
  Result := FParent;
end;

function TSelecaoColunas.GetItems: TSelecaoColunasCollection;
begin
  Result := FColecaoColunas;
end;

end.
