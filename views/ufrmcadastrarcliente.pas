unit uFrmCadastrarCliente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  StdCtrls, Grids;

type

  { TfrmCadastrarCliente }

  TfrmCadastrarCliente = class(TForm)
    btnFechar: TButton;
    btnPesquisar: TButton;
    btnNovo: TButton;
    btnDetalhar: TButton;
    btnExcluir: TButton;
    btnListar: TButton;
    btnAlterar: TButton;
    btnGravar: TButton;
    btnCancelar: TButton;
    edtPesq: TLabeledEdit;
    edtCodigo: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtRG: TLabeledEdit;
    edtCPF: TLabeledEdit;
    edtCodigoCidade: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtEstado: TLabeledEdit;
    edtTelefone: TLabeledEdit;
    pnlCadBtns: TPanel;
    pnlFiltro: TPanel;
    pnlPesqBttns: TPanel;
    pgcPrincipal: TPageControl;
    pnlRodape: TPanel;
    StringGrid1: TStringGrid;
    tbPesq: TTabSheet;
    tbDados: TTabSheet;
  private

  public

  end;

var
  frmCadastrarCliente: TfrmCadastrarCliente;

implementation

{$R *.lfm}

end.

