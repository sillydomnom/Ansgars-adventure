unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Button3: TButton;
    Button4: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form2: TForm2;


implementation
uses Unit1;
{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  //fen:= TForm1.Create(self);
  //fen.Show;
  Form2.Hide;
  Form1.Show;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  ShowMessage('Progrmmiert von Dominik Schumann'+ #10#13 + 'Story entwickelt von Tim Linneken!' + #10#13 + 'Texturen von Nico' + #10#13 + #10#13 + 'Copyright by Ansgars Adventure!');
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Unit1.Form1.closeAll();
end;

end.
