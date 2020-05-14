unit uDmCliente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Grids, db, ZDataset,
  uDmConexao, uClienteModel;

type

  { TDmCliente }

  TDmCliente = class(TDataModule)
    sqlPesquisar: TZQuery;
    sqlInserir: TZQuery;
    sqlAlterar: TZQuery;
    sqlExcluir: TZQuery;
    sqlPesquisarcidade: TStringField;
    sqlPesquisarid: TLongintField;
    sqlPesquisarnome: TStringField;
    sqlPesquisartelefone: TStringField;
  private

  public
    function GerarId : Integer;
    procedure Pesquisar(sNome:String; var aStringGrid: TStringGrid) ;
    procedure CarregarCliente(oCliente: TCliente; iCodigo: Integer);
    function  Inserir(oCliente : TCliente; out sErro:string):Boolean;
    function  Alterar(oCliente : TCliente; out sErro:string):Boolean;
    function  Excluir(iCodigo : Integer; out sErro:string):Boolean;
  end;

var
  DmCliente: TDmCliente;

implementation

{$R *.lfm}

{ TDmCliente }

function TDmCliente.GerarId: Integer;
var
  sqlSequencia: TZQuery;
begin
  sqlSequencia:= TZQuery.Create(nil);
  try
    with sqlSequencia do
begin
   Connection:= DmConexao.sqlConexao;
   SQL.Text:='select COALESCE (max(id), 0) + 1 as seq from cliente';
   Open;
   Result:= FieldByName('seq').AsInteger;
end;
  finally
    FreeAndNil(sqlSequencia);
  end;
end;

procedure TDmCliente.Pesquisar(sNome: String; var aStringGrid: TStringGrid);
var
  iTotal : Integer;
begin
  iTotal:= 1;
  try
    with sqlPesquisar do
begin

end;
  finally
    //FreeStatement
  end;
end;

procedure TDmCliente.CarregarCliente(oCliente: TCliente; iCodigo: Integer);
begin

end;

function TDmCliente.Inserir(oCliente: TCliente; out sErro: string): Boolean;
begin

end;

function TDmCliente.Alterar(oCliente: TCliente; out sErro: string): Boolean;
begin

end;

function TDmCliente.Excluir(iCodigo: Integer; out sErro: string): Boolean;
begin

end;

end.

