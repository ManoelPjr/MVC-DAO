unit uClienteController;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Grids, uClienteModel, uDmCliente;
type

  { TClienteController }

  TClienteController = class
  public
    constructor Create;
    destructor Destroy; override;
    procedure Pesquisar (sNome: String; var aStringGrid: TStringGrid);
    procedure CarregarCliente(oCliente: TCliente; iCodigo: Integer);
    function Inserir(oCliente: TCliente; out sErro: String):Boolean;
    function Alterar(oCliente: TCliente; out sErro: String):Boolean;
    function Excluir(iCodigo: Integer; out sErro: String):Boolean;
  end;

implementation

{ TClienteController }

constructor TClienteController.Create;
begin
  DmCliente.Create(nil);
end;

destructor TClienteController.Destroy;
begin
  FreeAndNil(DmCliente);
  inherited Destroy;
end;

procedure TClienteController.Pesquisar(sNome: String;
  var aStringGrid: TStringGrid);
begin
  DmCliente.Pesquisar(sNome,aStringGrid);
end;

procedure TClienteController.CarregarCliente(oCliente: TCliente;
  iCodigo: Integer);
begin
  DmCliente.CarregarCliente(oCliente,iCodigo);
end;

function TClienteController.Inserir(oCliente: TCliente; out sErro: String
  ): Boolean;
begin
  Result:= DmCliente.Inserir(oCliente,sErro);
end;

function TClienteController.Alterar(oCliente: TCliente; out sErro: String
  ): Boolean;
begin
  Result:= DmCliente.Alterar(oCliente,sErro);
end;

function TClienteController.Excluir(iCodigo: Integer; out sErro: String
  ): Boolean;
begin
  Result:= DmCliente.Excluir(iCodigo,sErro);
end;

end.

