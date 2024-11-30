program BuscaComInterface;

uses
  Vcl.Forms,
  FMain in 'FMain.pas' {FormMain},
  uSelecao in 'uSelecao.pas' {FormSelecao};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
