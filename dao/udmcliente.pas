unit uDmCliente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Grids, DB, ZDataset,
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
    function GerarId: integer;
    procedure Pesquisar(sNome: string; var aStringGrid: TStringGrid);
    procedure CarregarCliente(oCliente: TCliente; iCodigo: integer);
    function Inserir(oCliente: TCliente; out sErro: string): boolean;
    function Alterar(oCliente: TCliente; out sErro: string): boolean;
    function Excluir(iCodigo: integer; out sErro: string): boolean;
  end;

var
  DmCliente: TDmCliente;

implementation

{$R *.lfm}

{ TDmCliente }

function TDmCliente.GerarId: integer;
var
  sqlSequencia: TZQuery;
begin
  sqlSequencia := TZQuery.Create(nil);
  try
    with sqlSequencia do
    begin
      Connection := DmConexao.sqlConexao;
      SQL.Text := 'select COALESCE (max(id), 0) + 1 as seq from cliente';
      Open;
      Result := FieldByName('seq').AsInteger;
    end;
  finally
    FreeAndNil(sqlSequencia);
  end;
end;

procedure TDmCliente.Pesquisar(sNome: string; var aStringGrid: TStringGrid);
var
  iTotal: integer;
begin
  iTotal := 1;
  try
    with sqlPesquisar do
    begin
      if Active then
        Close;
      if sNome = EmptyStr then
        Params[0].AsString := '%'
      else
        Params[0].AsString := '%' + sNome + '%';
      Open;
      DisableControls;
      Last;
      with aStringGrid do
      begin
        RowCount := RecordCount + 1;
        ColCount := 4;
        Cells[0, 0] := 'Código';
        Cells[1, 0] := 'Nome';
        Cells[2, 0] := 'Telefone';
        Cells[3, 0] := 'Cidade';
        ColWidths[0] := 40;
        ColWidths[1] := 200;
        ColWidths[2] := 120;
        ColWidths[3] := 180;
      end;
      First;
      while not EOF do
      begin
        with aStringGrid do
        begin
          Cells[0, iTotal] := FieldByName('id').AsString;
          Cells[1, iTotal] := FieldByName('nome').AsString;
          Cells[2, iTotal] := FieldByName('telefone').AsString;
          Cells[3, iTotal] := FieldByName('cidade').AsString;
        end;
        Inc(iTotal);
        Next;
      end;
    end;
  finally
    sqlPesquisar.EnableControls;
    sqlPesquisar.Close;
  end;
end;

procedure TDmCliente.CarregarCliente(oCliente: TCliente; iCodigo: integer);
var
  sqlCliente: TZQuery;
begin
  sqlCliente := TZQuery.Create(nil);
  try
    with sqlCliente do
    begin
      Connection := DmConexao.sqlConexao;
      SQL.Text := 'select c.*, cid.nome as cidade, e.sigla from cliente c left join '
        + 'cidade cid on (c.id_cidade = cid.id) left join estado e on (cid.id_estado = e.id) where c.id = '
        + IntToStr(iCodigo);
      Open;
    end;
    with oCliente do
    begin
      Id := sqlCliente.FieldByName('id').AsInteger;
      Id_cidade := sqlCliente.FieldByName('id_cidade').AsInteger;
      Nome := sqlCliente.FieldByName('nome').AsString;
      RG := sqlCliente.FieldByName('rg').AsString;
      CPF := sqlCliente.FieldByName('cpf').AsString;
      Telefone := sqlCliente.FieldByName('telefone').AsString;
      Cidade := sqlCliente.FieldByName('cidade').AsString;
      Estado := sqlCliente.FieldByName('idsigla').AsString;
    end;
  finally
    FreeAndNil(sqlCliente);
  end;
end;

function TDmCliente.Inserir(oCliente: TCliente; out sErro: string): boolean;
begin
  with sqlInserir, oCliente do
  begin
    Params[0].AsInteger := GerarId;
    if Id_cidade = 0 then
      Params[1].Clear
    else
      Params[1].AsInteger := Id_cidade;
    Params[2].AsString := Nome;
    Params[3].AsString := CPF;
    Params[4].AsString := RG;
    Params[5].AsString := Telefone;
    try
      ExecSQL;
      Result := True;
    except
      on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao inserir cliente: ' + sLineBreak + E.Message;
        Result := False;
      end;
    end;
  end;
end;

function TDmCliente.Alterar(oCliente: TCliente; out sErro: string): boolean;
begin
  with sqlAlterar, oCliente do
  begin

    if Id_cidade = 0 then
      Params[0].Clear
    else
      Params[0].AsInteger := Id_cidade;
    Params[1].AsString := Nome;
    Params[2].AsString := CPF;
    Params[3].AsString := RG;
    Params[4].AsString := Telefone;
    Params[5].AsInteger := Id;
    try
      ExecSQL;
      Result := True;
    except
      on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao alterar cliente: ' + sLineBreak + E.Message;
        Result := False;
      end;
    end;
  end;
end;

function TDmCliente.Excluir(iCodigo: integer; out sErro: string): boolean;
begin
  with sqlExcluir do
  begin
    Params[0].AsInteger := iCodigo;
    try
      ExecSQL;
      Result := True;
    except
      on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao excluir cliente: ' + sLineBreak + E.Message;
        Result := False;
      end;
    end;
  end;
end;

end.
