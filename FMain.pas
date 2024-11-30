unit FMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TFormMain = class(TForm)
    edtCodigo: TEdit;
    edtDescricao: TEdit;
    Conexao: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    Label1: TLabel;
    Label2: TLabel;
    FDQuery1: TFDQuery;
    procedure edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses uSelecao;

procedure TFormMain.edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (not (ssAlt in Shift)) and (Key = VK_F4) then
  begin
//    var vRet := Seleciona
//      .Titulo('Selecione a pessoa')
//      .Select('pessoas.npessoa, pessoas.nome, max(FPMENSAL.TOTALEVENTO) as maximo')
//      .From('PESSOAS')
//      .LeftJoin('FPMENSAL', 'pessoas.npessoa = FPMENSAL.NPESSOA')
//      .Where('pessoas.demitido <> ''S''')
//      .GroupBy('pessoas.NPESSOA, PESSOAS.nome')
//      .OrderBy('pessoas.NPESSOA, PESSOAS.nome')
//      .IniciarBuscaPor('pessoas.npessoa')
//      .ExibirColunas(['npessoa', 'nome', 'maximo'])
//      .RenomearColunas(['Id.', 'Nome', 'Máx. salário'])
//      .LarguraColunas([60, 200, 100])
//      .Conexao(Conexao)
//      .Executar;

//    if vRet.Ok then
//    begin
//      edtCodigo.Text := vRet.DataSet.FieldByName('npessoa').AsString;
//      edtDescricao.Text := vRet.DataSet.FieldByName('nome').AsString;
//    end;

//    var vRet := Seleciona
//      .Titulo('Selecione o Produto')
//      .Select('codprod, descricao')
//      .From('produtos')
////      .LeftJoin('FPMENSAL', 'pessoas.npessoa = FPMENSAL.NPESSOA')
//      .Where('ativosn = ''S''')
////      .GroupBy('pessoas.NPESSOA, PESSOAS.nome')
//      .OrderBy('codprod')
//      .IniciarBuscaPor('codprod')
//      .ExibirColunas(['codprod', 'descricao'])
//      .RenomearColunas(['Cód. Produto', 'Descrição'])
////      .LarguraColunas([60, 200])
//      .Conexao(Conexao)
//      .Executar;
//
//    if vRet.Ok then
//    begin
//      edtCodigo.Text := vRet.DataSet.FieldByName('codprod').AsString;
//      edtDescricao.Text := vRet.DataSet.FieldByName('descricao').AsString;
//    end;

    var vRet := Seleciona
      .Titulo('Selecione a NF')
      .Select('nfexp.nseq, nfexp.nnf, nfexp.DESTDATAEM, clientes.rzsocial, nfexp.imptotnota')
      .From('nfexp')
      .LeftJoin('clientes', 'clientes.codcli = nfexp.destcod')
      .Where('nfesit = ''Apr''')
//      .GroupBy('pessoas.NPESSOA, PESSOAS.nome')
//      .Having('')
      .OrderBy('nfexp.nseq desc')
      .IniciarBuscaPor('nnf')
      .IniciarComValor(edtDescricao.Text)
//      .ListarTudo()
      .ExibirColunas(['nseq', 'nnf', 'DESTDATAEM', 'rzsocial', 'imptotnota'])
      .RenomearColunas(['Id.', 'Nº NF', 'Data', 'Cliente', 'Total NF'])
//      .LarguraColunas([60, 200])
      .Con(Conexao)
      .Executar;
//      .DataSet;

//      edtCodigo.Text := vRet.FieldByName('nseq').AsString;
//      edtDescricao.Text := vRet.FieldByName('nnf').AsString;

    if vRet.Ok then
    begin
      edtCodigo.Text := vRet.DataSet.FieldByName('nseq').AsString;
      edtDescricao.Text := vRet.DataSet.FieldByName('nnf').AsString;
    end;
  end;
end;

end.
