unit uFrmPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  uFrmCadastrarCliente;

type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.lfm}

{ TfrmPrincipal }

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  frmCadastrarCliente:= TfrmCadastrarCliente.Create(nil);
  try
    frmCadastrarCliente.ShowModal;
  finally
    FreeAndNil(frmCadastrarCliente);
  end;
end;

end.

