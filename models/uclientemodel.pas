unit uClienteModel;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TCliente }

  TCliente = class
  private
    fRG: string;
    fCPF: string;
    fId: integer;
    fNome: string;
    fTelefone: string;
    fId_cidade: integer;
    fCidade: string;
    fEstado: string;
    procedure setNome(AValue: string);
    procedure setTelefone(AValue: string);
  public
    property Id: integer read fId write fid;
    property Id_cidade: integer read fId_cidade write fId_cidade;
    property Nome: string read fNome write setNome;
    property CPF: string read fCPF write fCPF;
    property RG: string read fRG write fRG;
    property Telefone: string read fTelefone write setTelefone;
    property Cidade: string read fCidade write fCidade;
    property Estado: string read fEstado write fEstado;
  end;

implementation

{ TCliente }

procedure TCliente.setNome(AValue: string);
begin
  if fNome = AValue then
    Exit;
  if Trim(AValue) = EmptyStr then
    raise EArgumentException.Create('O [Nome] precisa ser preenchido.')
  else
    fNome := AValue;
end;

procedure TCliente.setTelefone(AValue: string);
begin
  if fTelefone = AValue then
    Exit;
  if Trim(AValue) = EmptyStr then
    raise EArgumentException.Create('O [Telefone] precisa ser preenchido.')
  else
    fTelefone := AValue;
end;

end.
