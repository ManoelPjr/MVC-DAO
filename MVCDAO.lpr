program MVCDAO;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, uFrmPrincipal, uClienteModel, uFrmCadastrarCliente,
  uDmConexao, uDmCliente
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmCadastrarCliente, frmCadastrarCliente);
  Application.CreateForm(TDmConexao, DmConexao);
  Application.CreateForm(TDmCliente, DmCliente);
  Application.Run;
end.

