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
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
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

procedure TForm2.Button1Click(Sender: TObject);            //Start Game
begin
  //fen:= TForm1.Create(self);
  //fen.Show;
  Form2.Hide;
  Form1.Show;
end;

procedure TForm2.Button3Click(Sender: TObject);            //Impressum
begin
  ShowMessage('Progrmmiert von Dominik Schumann'+ #10#13 + 'Story entwickelt von Tim Linneken!' + #10#13 + 'Texturen von Nicolas und Dominik Schumann' + #10#13 + #10#13 + 'Copyright by Ansgars Adventure!');
end;


procedure TForm2.Button4Click(Sender: TObject);
begin
  ShowMessage('In diesem Spiel steuerst du unseren Helden Ansgar!' + #10#13 + 'Begib dich auf eine epische Reise wo DU die Entscheidungen triffst' + #10#13 + 'Mehr dazu im Prolog' + #10#13 + #10#13 + 'Wenn du das Spiel Starten m�chtest klicke im neuem Fenster auf New' + #10#13 + 'Im unterem Teil des Fenster bekommst du f�r jeden Teil der Geschichte' + #10#13 + 'bis zu drei Auswahlm�glichkeiten!' + #10#13 + 'Zum speichern klicke auf Save und w�hle ein Speicher Profil deiner Wahl aus' + #10#13 + 'Zum laden w�hlst du das entsprechende Profil ebenfalls aus' + #10#13 + #10#13 + 'Es wird empfohlen das Spiel mit dem offenem Stats Fenster zu spielen' + #10#13 + 'Viel Spa�! :)');
end;

end.
