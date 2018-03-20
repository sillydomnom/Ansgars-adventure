unit save;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls;

type
  TForm4 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure initializeButton(Button : integer; filename : String);
    procedure fillFile(list : tstringlist; existing : boolean; save : integer);
  end;

var
  Form4: TForm4;
  Save1: TextFile;
  SaveStats1 : tstringlist;
  SaveExist1: boolean;
  Save2 : TextFile;
  SaveStats2 : tstringlist;
  SaveExist2: boolean;
  Save3 : TextFile;
  SaveStats3 : tstringlist;
  SaveExist3: boolean;

implementation

{$R *.dfm}

uses Unit1, Objects;

procedure TForm4.fillFile(list : tstringlist; existing : boolean; save : integer);      //Datei schreiben
var player : Tplayer;
  i: Integer;
  l: Integer;
  profil : string;
Begin
  player := Form1.getPlayer;
  if not(existing) then
  Begin
    list := list.Create;     // Datei inhalt wird in Liste geschrieben und Liste dann in Datei
    list.Append(InputBox('Profil Name eingeben!', 'Geben Sie Ihrem Profil einen Namen!', 'Ansgar')); //Profil Name abfragen
  End
  else
  Begin
    profil := list[0];
    list.Clear;
    list.append(profil)
  End;
    list.append(Form1.getData());
    list.append(inttostr(player.getGold));
    list.append(inttostr(player.getArmor));
    list.append(inttostr(player.getHealth));
    list.append(inttostr(player.getStrength));
    list.append(inttostr(player.getItems.Count));
    for i := 0 to player.getItems.Count -1 do
    Begin
      list.append(player.getItems[i]);
    End;
  for l := 0 to list.Count - 1 do
  Begin
    case save of
    1: WriteLn(Save1, list[l]);      // in Datei wird geschrieben
    2: WriteLn(Save2, list[l]);
    3: WriteLn(Save3, list[l]);
    end;
  End;
  case save of
  1: CloseFile(Save1);               // Datei wird geschlossen
  2: CloseFile(Save2);
  3: CloseFile(Save3);
  end;
  SaveStats1.free;
  SaveStats2.free;
  SaveStats3.free;
  Form1.Enabled := true;
  Form4.Hide;                        // Fenster geschlossen
End;

procedure TForm4.initializeButton(Button: Integer; filename : String);      // Knöpfe werden initialisiert
begin
  case Button of
  1:Begin
    SaveStats1:= Form1.getText(filename);    //Datei wird in stringlist gescrieben
    AssignFile(Save1, filename);             // zugewiesen
    Reset(Save1);                            //zum lesen verfügbar gemacht
    Button1.Caption := SaveStats1[0];        //Profil Name wird gelesen und auf den Knopf geschrieben
    CloseFile(Save1);                        // Datei wird geschlossen
  End;
  2:Begin
    SaveStats2:= Form1.getText(filename);
    AssignFile(Save2, filename);
    Reset(Save2);
    Button2.Caption := SaveStats1[0];
    CloseFile(Save2);
  End;
  3:Begin
    SaveStats1:= Form1.getText(filename);
    AssignFile(Save1, filename);
    Reset(Save3);
    Button1.Caption := SaveStats1[0];
    CloseFile(Save3);
  End;
  end;

end;

procedure TForm4.Button1Click(Sender: TObject);        //Save 1
begin
  if not(SaveExist1) then                              // Wenn datei nicht vorhanden
  Begin
    AssignFile(Save1, GetCurrentDir() + '\Saves\save1.zrk');    // Datei zuweisen abhängig von relativer Position
      Rewrite(Save1);                                           // Datei neu erstellen
    fillFile(SaveStats1, false, 1);                             // Datei beschreiben
  End
    else
    Begin                                                      // falls schon vorhanden
     DeleteFile(GetCurrentDir() + '\Saves\save1.zrk');         // wird gelöscht
     AssignFile(Save1, GetCurrentDir() + '\Saves\save1.zrk');  // neu zugewiesen
     Rewrite(Save1);                                           // neu erstellt
     fillFile(SaveStats1, true, 1);                            // und wieder beschrieben
    End;
end;

procedure TForm4.Button2Click(Sender: TObject);       //Save 2
begin
  if not(SaveExist2) then
  Begin
    AssignFile(Save2, GetCurrentDir() + '\Saves\save2.zrk');
    Rewrite(Save2);
    fillFile(SaveStats2, false, 2);
  End
    else
    Begin
     DeleteFile(GetCurrentDir() + '\Saves\save2.zrk');
     AssignFile(Save2, GetCurrentDir() + '\Saves\save2.zrk');
     Rewrite(Save2);
     fillFile(SaveStats2, true, 2);
    End;
end;

procedure TForm4.Button3Click(Sender: TObject);     // Save 3
begin
if not(SaveExist3) then
  Begin
    AssignFile(Save3, GetCurrentDir() + '\Saves\save3.zrk');
    Rewrite(Save3);
    fillFile(SaveStats3, false, 3);
  End
    else
     Begin
     DeleteFile(GetCurrentDir() + '\Saves\save1.zrk');
     AssignFile(Save3, GetCurrentDir() + '\Saves\save1.zrk');
     Rewrite(Save3);
     fillFile(SaveStats3, true, 3);
     End;
end;

procedure TForm4.Button4Click(Sender: TObject);    //Cancel
begin
  Form1.Enabled := true;
  Form4.Hide;
end;

procedure TForm4.FormCreate(Sender: TObject);     // bei jedem öffnem und beim ersten Start
begin
  SaveStats1 := tstringlist.create;
  SaveStats2 := tstringlist.create;
  SaveStats3 := tstringlist.create;
  if FileExists(GetCurrentDir() + '\Saves\save1.zrk') then      // wenn existiert
  Begin
    initializeButton(1, GetCurrentDir() + '\Saves\save1.zrk');  //initialisiert
    SaveExist1 := true;                                         // und booelean auf wahr
  End
  else SaveExist1 := false;                                     // sonst auf falsch

  if FileExists(GetCurrentDir() + '\Saves\save2.zrk') then
  Begin
    initializeButton(2, GetCurrentDir() + '\Saves\save2.zrk');
    SaveExist2 := true;
  End
  else  SaveExist2 := false;
  if FileExists(GetCurrentDir() + '\Saves\save3.zrk') then
  Begin
    initializeButton(3, GetCurrentDir() + '\Saves\save3.zrk');
    SaveExist3 := true;
  End
  else SaveExist3 := false;
end;

end.
