unit save;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm4 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure initializeButton(Button : integer; filename : String);
  end;

var
  Form4: TForm4;
  Save1: TextFile;
  SaveStats1 : tstringlist;
  Save2 : TextFile;
  SaveStats2 : tstringlist;
  Save3 : TextFile;
  SaveStats3 : tstringlist;

implementation

{$R *.dfm}

uses Unit1, Objects;

procedure TForm4.initializeButton(Button: Integer; filename : String);
begin
  case Button of
  1:Begin
    SaveStats1:= Form1.getText(filename);
    AssignFile(Save1, filename);
    Reset(Save1);
    Button1.Caption := SaveStats1[0];
  End;
  2:Begin
    SaveStats2:= Form1.getText(filename);
    AssignFile(Save2, filename);
    Reset(Save2);
    Button2.Caption := SaveStats1[0];
  End;
  3:Begin
    SaveStats1:= Form1.getText(filename);
    AssignFile(Save1, filename);
    Reset(Save3);
    Button1.Caption := SaveStats1[0];
  End;
  end;

end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  if FileExists(GetCurrentDir() + '\Saves\save1.zrk') then
    initializeButton(1, GetCurrentDir() + '\Saves\save1.zrk');
  if FileExists(GetCurrentDir() + '\Saves\save2.zrk') then
    initializeButton(2, GetCurrentDir() + '\Saves\save2.zrk');
  if FileExists(GetCurrentDir() + '\Saves\save3.zrk') then
    initializeButton(3, GetCurrentDir() + '\Saves\save3.zrk');
  if TTextRec(Save1).Mode = 55216 then
    ShowMessage('Yeah!');
end;

end.
