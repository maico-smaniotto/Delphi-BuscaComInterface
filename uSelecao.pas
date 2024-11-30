unit uSelecao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  IRetornoSelecao = interface
    function GetOk: Boolean;
    function GetDataSet: TDataSet;
    property Ok: Boolean read GetOk;
    property DataSet: TDataSet read GetDataSet;
  end;

  TRetornoSelecao = class(TInterfacedObject, IRetornoSelecao)
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

  ISelecao = interface
    function Titulo(ATitulo: String): ISelecao;
    function Select(ASelect: String): ISelecao;
    function From(AFrom: String): ISelecao;
    function InnerJoin(ATabela: String; ACondicao: String): ISelecao;
    function LeftJoin(ATabela: String; ACondicao: String): ISelecao;
    function Where(ACondicao: String): ISelecao;
    function GroupBy(AGroupBy: String): ISelecao;
    function Having(ACondicao: String): ISelecao;
    function OrderBy(AOrderBy: String): ISelecao;
    function ExibirColunas(AColunas: TArray<String>): ISelecao;
    function RenomearColunas(ANomes: TArray<String>): ISelecao;
    function LarguraColunas(ALarguras: TArray<Integer>): ISelecao;
    function IniciarBuscaPor(AColuna: String): ISelecao;
    function IniciarComValor(AValor: String): ISelecao;
    function ListarTudo(): ISelecao;
    function Con(AConexao: TFDConnection): ISelecao;
    function Executar: IRetornoSelecao;
  end;

  TSelecao = class(TInterfacedObject, ISelecao)
  private
    FTitulo: String;
    FSelect: String;
    FFrom: String;
    FJoins: TStrings;
    FFiltros: TStrings;
    FGroupBy: String;
    FHaving: TStrings;
    FOrderBy: String;
    FExibirColunas: TArray<String>;
    FRenomearColunas: TArray<String>;
    FLarguraColunas: TArray<Integer>;
    FIniciarBuscaPor: String;
    FIniciarComValor: String;
    FListarTudo: Boolean;
    FConexao: TFDConnection;
  public
    function Titulo(ATitulo: String): ISelecao;
    function Select(ASelect: String): ISelecao;
    function From(AFrom: String): ISelecao;
    function InnerJoin(ATabela: String; ACondicao: String): ISelecao;
    function LeftJoin(ATabela: String; ACondicao: String): ISelecao;
    function Where(ACondicao: String): ISelecao;
    function GroupBy(AGroupBy: String): ISelecao;
    function Having(ACondicao: String): ISelecao;
    function OrderBy(AOrderBy: String): ISelecao;
    function ExibirColunas(AColunas: TArray<String>): ISelecao;
    function RenomearColunas(ANomes: TArray<String>): ISelecao;
    function LarguraColunas(ALarguras: TArray<Integer>): ISelecao;
    function IniciarBuscaPor(AColuna: String): ISelecao;
    function IniciarComValor(AValor: String): ISelecao;
    function ListarTudo(): ISelecao;
    function Con(AConexao: TFDConnection): ISelecao;
    function Executar: IRetornoSelecao;
    constructor Create; reintroduce;
    destructor Destroy; override;
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
    FSelect: String;
    FFrom: String;
    FJoins: TStrings;
    FFiltros: TStrings;
    FGroupBy: String;
    FHaving: TStrings;
    FOrderBy: String;
    FExibirColunas: TArray<String>;
    FRenomearColunas: TArray<String>;
    FLarguraColunas: TArray<Integer>;
    FIniciarBuscaPor: String;
    FConexao: TFDConnection;
    FQuery: TFDQuery;
    FRetorno: IRetornoSelecao;

    FPagina: Integer;
    FTotalRegistros: Integer;
    FTotalPaginas: Integer;
    procedure Retornar(AOk: Boolean);
    procedure ConfirmarSelecao;
    procedure ExecutarBusca(APagina: Integer);
    procedure ContarRegistros(AQuery: TFDQuery; out ATotalRegistros: Integer; out ATotalPaginas: Integer);
    procedure TratarColunas;
    procedure AtualizarPaginacao;
  public
    { Public declarations }
    property Retorno: IRetornoSelecao read FRetorno;
    constructor Create(
      AOwner: TComponent;
      ATitulo: String;
      ASelect: String;
      AFrom: String;
      AJoins: TStrings;
      AFiltros: TStrings;
      AGroupBy: String;
      AHaving: TStrings;
      AOrderBy: String;
      AExibirColunas: TArray<String>;
      ARenomearColunas: TArray<String>;
      ALarguraColunas: TArray<Integer>;
      AIniciarBuscaPor: String;
      AIniciarComValor: String;
      AListarTudo: Boolean;
      AConexao: TFDConnection); reintroduce;
  end;

function Seleciona: ISelecao;

implementation

{$R *.dfm}

const LIMITE = 16;

function Seleciona: ISelecao;
begin
  Result := TSelecao.Create;
end;

{ TRetornoSelecao }

constructor TRetornoSelecao.Create(AOk: Boolean; ADataSet: TDataSet);
begin
  inherited Create;
  SetValores(AOk, ADataSet);
end;

destructor TRetornoSelecao.Destroy;
begin
  if Assigned(FDataSet) then
    FDataSet.Free;
  inherited;
end;

function TRetornoSelecao.GetDataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TRetornoSelecao.GetOk: Boolean;
begin
  Result := FOk;
end;

procedure TRetornoSelecao.SetOk(AOk: Boolean);
begin
  SetValores(AOk, FDataSet);
end;

procedure TRetornoSelecao.SetValores(AOk: Boolean; ADataSet: TDataSet);
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
  ASelect: String;
  AFrom: String;
  AJoins: TStrings;
  AFiltros: TStrings;
  AGroupBy: String;
  AHaving: TStrings;
  AOrderBy: String;
  AExibirColunas: TArray<String>;
  ARenomearColunas: TArray<String>;
  ALarguraColunas: TArray<Integer>;
  AIniciarBuscaPor: String;
  AIniciarComValor: String;
  AListarTudo: Boolean;
  AConexao: TFDConnection);
begin
  inherited Create(AOwner);
  Caption := ATitulo;
  FSelect := ASelect;
  FFrom := AFrom;
  FJoins := AJoins;
  FFiltros := AFiltros;
  FGroupBy := AGroupBy;
  FHaving := AHaving;
  FOrderBy := AOrderBy;
  FExibirColunas := AExibirColunas;
  FRenomearColunas := ARenomearColunas;
  FLarguraColunas := ALarguraColunas;
  FIniciarBuscaPor := AIniciarBuscaPor;
  FConexao := AConexao;

  FPagina := 0;
  FTotalRegistros := 0;
  FTotalPaginas := 0;

  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := FConexao;
  FRetorno := TRetornoSelecao.Create(False, FQuery);

  edtBusca.OnChange := nil;
  chkDiferMaiusculasMinusculas.OnClick := nil;
  chkListarTudo.OnClick := nil;
  rbInicia.OnClick := nil;
  try
    edtBusca.Text := AIniciarComValor;
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
  FQuery.SQL.Add('SELECT ' + FSelect);
  FQuery.SQL.Add('FROM ' + FFrom);

  for var I := 0 to FJoins.Count - 1 do
    FQuery.SQL.Add(FJoins[I]);

  FQuery.SQL.Add('WHERE 1 = 1 ');
  for var I := 0 to FFiltros.Count - 1 do
    FQuery.SQL.Add('AND ' + FFiltros[I]);

  if not chkListarTudo.Checked then
  begin
    if (edtBusca.Text <> '') then
    begin
      var vBusca := edtBusca.Text + '%';
      if rbContem.Checked then
        vBusca := '%' + vBusca;

      if chkDiferMaiusculasMinusculas.Checked then
      begin
        FQuery.SQL.Add('AND ' + FExibirColunas[cbFiltrar.ItemIndex] + ' LIKE :P_BUSCA');
        FQuery.ParamByName('P_BUSCA').AsString := vBusca;
      end
      else
      begin
        FQuery.SQL.Add('AND UPPER(' + FExibirColunas[cbFiltrar.ItemIndex] + ') LIKE :P_BUSCA');
        FQuery.ParamByName('P_BUSCA').AsString := AnsiUpperCase(vBusca);
      end;
    end
    else
      FQuery.SQL.Add('AND 1 = 0');
  end;

  if FGroupBy <> '' then
    FQuery.SQL.Add('GROUP BY ' + FGroupBy);

  if FHaving.Count > 0 then
  begin
    FQuery.SQL.Add('HAVING 1 = 1 ');
    for var I := 0 to FHaving.Count - 1 do
      FQuery.SQL.Add('AND ' + FHaving[I]);
  end;

  if FOrderBy <> '' then
    FQuery.SQL.Add('ORDER BY ' + FOrderBy);

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
    if FQuery.FieldByName(FExibirColunas[cbFiltrar.ItemIndex]) is TStringField then
      if not FQuery.Locate(FExibirColunas[cbFiltrar.ItemIndex], edtbusca.Text, []) then
        FQuery.Locate(FExibirColunas[cbFiltrar.ItemIndex], edtbusca.Text, [loPartialKey]);
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
    for var I := Low(FExibirColunas) to High(FExibirColunas) do
    begin
      if Length(FExibirColunas) = Length(FRenomearColunas) then
        cbFiltrar.Items.Add(FRenomearColunas[I])
      else
        cbFiltrar.Items.Add(FExibirColunas[I]);
      if AnsiUpperCase(FExibirColunas[I]) = AnsiUpperCase(FIniciarBuscaPor) then
        vIndex := I;
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
  TRetornoSelecao(FRetorno).SetOk(AOk);
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
  if Length(FExibirColunas) > 0 then
  begin
    for var I := 0 to FQuery.FieldCount - 1 do
      FQuery.Fields[I].Visible := False;

    for var I := 0 to Length(FExibirColunas) - 1 do
    begin
      var vField := FQuery.FindField(FExibirColunas[I]);
      if Assigned(vField) then
      begin
        vField.Visible := True;
        if Length(FRenomearColunas) = Length(FExibirColunas) then
          vField.DisplayLabel := FRenomearColunas[I];
        if Length(FLarguraColunas) = Length(FExibirColunas) then
          //vField.DisplayWidth := FLarguraColunas[I];
          Grid.Columns[I].Width := FLarguraColunas[I];
      end;
    end;
  end;
end;

{ TSelecao }

function TSelecao.IniciarBuscaPor(AColuna: String): ISelecao;
begin
  FIniciarBuscaPor := AColuna;
  Result := Self;
end;

function TSelecao.IniciarComValor(AValor: String): ISelecao;
begin
  FIniciarComValor := AValor;
  Result := Self;
end;

function TSelecao.ExibirColunas(AColunas: TArray<String>): ISelecao;
begin
  FExibirColunas := AColunas;
  Result := Self;
end;

function TSelecao.Con(AConexao: TFDConnection): ISelecao;
begin
  FConexao := AConexao;
  Result := Self;
end;

constructor TSelecao.Create;
begin
  inherited;
  FTitulo          := '';
  FSelect          := '';
  FFrom            := '';
  FJoins           := TStringList.Create;
  FFiltros         := TStringList.Create;
  FGroupBy         := '';
  FHaving          := TStringList.Create;
  FOrderBy         := '';
  FExibirColunas   := nil;
  FRenomearColunas := nil;
  FLarguraColunas  := nil;
  FIniciarBuscaPor := '';
  FIniciarComValor := '';
  FListarTudo      := False;
  FConexao         := nil;
end;

destructor TSelecao.Destroy;
begin
  FJoins.Free;
  FFiltros.Free;
  FHaving.Free;
  inherited;
end;

function TSelecao.Executar: IRetornoSelecao;
var
  FormSelecao: TFormSelecao;
begin
  FormSelecao := TFormSelecao.Create(
    nil,
    FTitulo,
    FSelect,
    FFrom,
    FJoins,
    FFiltros,
    FGroupBy,
    FHaving,
    FOrderBy,
    FExibirColunas,
    FRenomearColunas,
    FLarguraColunas,
    FIniciarBuscaPor,
    FIniciarComValor,
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

function TSelecao.From(AFrom: String): ISelecao;
begin
  FFrom := AFrom;
  Result := Self;
end;

function TSelecao.GroupBy(AGroupBy: String): ISelecao;
begin
  FGroupBy := AGroupBy;
  Result := Self;
end;

function TSelecao.Having(ACondicao: String): ISelecao;
begin
  FHaving.Add(ACondicao);
  Result := Self;
end;

function TSelecao.InnerJoin(ATabela, ACondicao: String): ISelecao;
begin
  FJoins.Add('INNER JOIN ' + ATabela + ' ON ' + ACondicao);
  Result := Self;
end;

function TSelecao.LarguraColunas(ALarguras: TArray<Integer>): ISelecao;
begin
  FLarguraColunas := ALarguras;
  Result := Self;
end;

function TSelecao.LeftJoin(ATabela, ACondicao: String): ISelecao;
begin
  FJoins.Add('LEFT JOIN ' + ATabela + ' ON ' + ACondicao);
  Result := Self;
end;

function TSelecao.ListarTudo: ISelecao;
begin
  FListarTudo := True;
  Result := Self;
end;

function TSelecao.OrderBy(AOrderBy: String): ISelecao;
begin
  FOrderBy := AOrderBy;
  Result := Self;
end;

function TSelecao.RenomearColunas(ANomes: TArray<String>): ISelecao;
begin
  FRenomearColunas := ANomes;
  Result := Self;
end;

function TSelecao.Select(ASelect: String): ISelecao;
begin
  FSelect := ASelect;
  Result := Self;
end;

function TSelecao.Titulo(ATitulo: String): ISelecao;
begin
  FTitulo := ATitulo;
  Result := Self;
end;

function TSelecao.Where(ACondicao: String): ISelecao;
begin
  FFiltros.Add(ACondicao);
  Result := Self;
end;

end.
