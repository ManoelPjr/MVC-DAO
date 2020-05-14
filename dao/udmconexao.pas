unit uDmConexao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection;

type

  { TDmConexao }

  TDmConexao = class(TDataModule)
    sqlConexao: TZConnection;
  private

  public

  end;

var
  DmConexao: TDmConexao;

implementation

{$R *.lfm}

end.

