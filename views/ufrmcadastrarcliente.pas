unit uFrmCadastrarCliente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  StdCtrls, Grids, uClienteController, uClienteModel, Types;

type
  TOperacao = (opNovo, opAlterar, opNavegacao);
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
    strGridPesq: TStringGrid;
    tbPesq: TTabSheet;
    tbDados: TTabSheet;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnDetalharClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnListarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure strGridPesqDblClick(Sender: TObject);
    procedure strGridPesqDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure strGridPesqSelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
  private
    FOperacao: TOperacao;
    FIdSelecionado: integer;
    procedure SetUp;
    procedure Pesquisar;
    procedure Novo;
    procedure Detalhar;
    procedure CarregarCliente;
    procedure Listar;
    procedure Alterar;
    procedure Excluir;
    procedure Gravar;
    procedure Inserir;
    procedure HabilitarControles(aOperacao: TOperacao);
  public
    property IdSelecionado: integer read FIdSelecionado write FIdSelecionado;
  end;

var
  frmCadastrarCliente: TfrmCadastrarCliente;

implementation

{$R *.lfm}

{ TfrmCadastrarCliente }

procedure TfrmCadastrarCliente.strGridPesqSelectCell(Sender: TObject; aCol,
  aRow: Integer; var CanSelect: Boolean);
begin
  if aRow > 1 then
    IdSelecionado:= StrToInt(strGridPesq.Cells[0,aRow]);
end;

procedure TfrmCadastrarCliente.strGridPesqDrawCell(Sender: TObject; aCol,
  aRow: Integer; aRect: TRect; aState: TGridDrawState);
begin
  with strGridPesq do
  begin
  Canvas.Brush.Color:= clGray;
  Canvas.Font.Color:= $00DADD2FC;
  Canvas.Font.Style:=[fsBold];
  Canvas.FillRect(aRect);
  //Canvas.TextOut(Rect.Left+2, Rect.Top+2, Cells[0,0]);
  //Canvas.TextOut(Rect.Left, Rect.Top, Cells[ACol,ARow]);
  end;
end;

procedure TfrmCadastrarCliente.strGridPesqDblClick(Sender: TObject);
begin
  Detalhar;
end;

procedure TfrmCadastrarCliente.FormShow(Sender: TObject);
begin
  SetUp;
end;

procedure TfrmCadastrarCliente.FormKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
    begin
      Key:= #0;
      //Perform(WM_NEXTDLGCTL,0,0); Delphi
      SelectNext(ActiveControl,True,True); //Lazarus
    end;
end;

procedure TfrmCadastrarCliente.btnPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCadastrarCliente.btnNovoClick(Sender: TObject);
begin
  Novo;
  HabilitarControles(opNovo);
end;

procedure TfrmCadastrarCliente.btnDetalharClick(Sender: TObject);
begin
  Detalhar;
end;

procedure TfrmCadastrarCliente.btnAlterarClick(Sender: TObject);
begin
  FOperacao:= opAlterar;
  HabilitarControles(opAlterar);
end;

procedure TfrmCadastrarCliente.btnCancelarClick(Sender: TObject);
begin
  HabilitarControles(opNavegacao);
end;

procedure TfrmCadastrarCliente.btnExcluirClick(Sender: TObject);
begin
  Excluir;
end;

procedure TfrmCadastrarCliente.btnGravarClick(Sender: TObject);
begin
  Gravar;
  HabilitarControles(opNavegacao);
end;

procedure TfrmCadastrarCliente.btnListarClick(Sender: TObject);
begin
  Listar;
end;

procedure TfrmCadastrarCliente.SetUp;
begin
  tbPesq.TabVisible := True;//False;
  tbDados.TabVisible := False;
  pgcPrincipal.ActivePage := tbPesq;
  FIdSelecionado := 1;
end;

procedure TfrmCadastrarCliente.Pesquisar;
var
  oClienteController: TClienteController;
begin
  oClienteController := TClienteController.Create;
  try
    oClienteController.Pesquisar(edtPesq.Text, strGridPesq);
  finally
    FreeAndNil(oClienteController);
  end;
end;

procedure TfrmCadastrarCliente.Novo;
begin
  FOperacao := opNovo;
  pgcPrincipal.ActivePage := tbDados;
end;

procedure TfrmCadastrarCliente.Detalhar;
begin
  if strGridPesq.Cells[0, 1] = '' then
    raise Exception.Create('Não há registro para ser detalhado.');
  CarregarCliente;
  pgcPrincipal.ActivePage := tbDados;
end;

procedure TfrmCadastrarCliente.CarregarCliente;
var
  oCliente: TCliente;
  oClienteController: TClienteController;
begin
  oCliente := TCliente.Create;
  oClienteController := TClienteController.Create;
  try
    oClienteController.CarregarCliente(oCliente,
      StrToInt(strGridPesq.Cells[0, IdSelecionado]));
    with oCliente do
    begin
      edtCodigo.Text := IntToStr(Id);
      edtNome.Text := Nome;
      edtRG.Text := RG;
      edtCPF.Text := CPF;
      edtCodigoCidade.Text := IntToStr(Id_cidade);
      edtCidade.Text := Cidade;
      edtEstado.Text := Estado;
      edtTelefone.Text := Telefone;
    end;
  finally
    FreeAndNil(oClienteController);
    FreeAndNil(oCliente);
  end;
end;

procedure TfrmCadastrarCliente.Listar;
begin
  pgcPrincipal.ActivePage:= tbPesq;
end;

procedure TfrmCadastrarCliente.Alterar;
var
  oCliente: TCliente;
  oClienteController: TClienteController;
  sErro: String;
begin
  oCliente := TCliente.Create;
  oClienteController := TClienteController.Create;
  try
   with oCliente do
   begin
     Id:= StrToIntDef(edtCodigo.Text,0);
     Id_cidade:= StrToIntDef(edtCodigoCidade.Text,0);
     Nome:= edtNome.Text;
     CPF:= edtCPF.Text;
     RG:= edtRG.Text;
     Telefone:=edtTelefone.Text;
   end;
   if oClienteController.Alterar(oCliente, sErro) = False then
     raise Exception.Create(sErro);
  finally
    FreeAndNil(oClienteController);
    FreeAndNil(oCliente);
  end;

end;

procedure TfrmCadastrarCliente.Excluir;
var
  oClienteController: TClienteController;
  sErro: String;
begin
  oClienteController:= TClienteController.Create;
  try
    if strGridPesq.Cells[0,1] = '' then
      raise Exception.Create('Não há registro para ser excluido.');
    if oClienteController.Excluir(StrToIntDef(strGridPesq.Cells[0,strGridPesq.Row],0), sErro) = False then
      raise Exception.Create(sErro);
    oClienteController.Pesquisar(EmptyStr, strGridPesq);
  finally
    FreeAndNil(oClienteController);
  end;
end;

procedure TfrmCadastrarCliente.Gravar;
var
  oClienteController: TClienteController;
begin
  case FOperacao of
   opNovo : Inserir;
   opAlterar : Alterar;
  end;
  oClienteController:= TClienteController.Create;
  try
   oClienteController.Pesquisar(EmptyStr, strGridPesq);
  finally
    FreeAndNil(oClienteController);
  end;
end;

procedure TfrmCadastrarCliente.Inserir;
var
  oCliente: TCliente;
  oClienteController: TClienteController;
  sErro: String;
begin
  oCliente:= TCliente.Create;
  oClienteController:= TClienteController.Create;
  try
    with oCliente do
    begin
      Id:= 0;
      Id_cidade:= StrToIntDef(edtCodigoCidade.Text,0);
      Nome := edtNome.Text;
      CPF:= edtCPF.Text;
      RG:= edtRG.Text;
      Telefone:=edtTelefone.Text;
    end;
    if oClienteController.Inserir(oCliente, sErro) = False then
      raise Exception.Create(sErro);
  finally
    FreeAndNil(oClienteController);
    FreeAndNil(oCliente);
  end;
end;

procedure TfrmCadastrarCliente.HabilitarControles(aOperacao: TOperacao);
begin
  case aOperacao of
   opNovo, opAlterar :
     begin
     edtNome.Enabled:= True;
     edtRG.Enabled:= True;
     edtCPF.Enabled:= True;
     edtCodigoCidade.Enabled:= True;
     edtTelefone.Enabled:= True;
     btnListar.Enabled:= False;
     btnFechar.Enabled:= False;
     btnAlterar.Enabled:= False;
     btnGravar.Enabled:= True;
     btnCancelar.Enabled:= True;
   end;
    opNavegacao:
      begin
      edtNome.Enabled:= False;
      edtRG.Enabled:= False;
      edtCPF.Enabled:= False;
      edtCodigoCidade.Enabled:= False;
      edtTelefone.Enabled:= False;
      btnListar.Enabled:= True;
      btnFechar.Enabled:= True;
      btnAlterar.Enabled:= True;
      btnGravar.Enabled:= False;
      btnCancelar.Enabled:= False;
      end;
  end;
end;

end.
