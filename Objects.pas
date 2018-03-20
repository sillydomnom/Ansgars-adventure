unit Objects;

interface
uses Classes, SysUtils, StrUtils, Dialogs;
type
  Tplayer = class         //Player Objekt
     private
      gold, armor, health, strength : integer;
      items: TStringList;
      public
      constructor create(gold, armor, health, strength : integer);
      destructor free();
      procedure addItem(item: String);
      //Object getting and setting
      function getGold() : integer;
      procedure setGold(setter : integer);
      function getArmor() : integer;
      procedure setArmor(setter : integer);
      function getHealth() : integer;
      procedure setHealth(setter : integer);
      function getStrength() : integer;
      procedure setStrength(setter : integer);
      function getItems() : tstringlist;
      procedure setItems(setter : tstringlist);
      function checkForItem(item : String) : boolean;
      //Effect Aus�bung von der ausgew�lten Selection
      function setEffect(effect : tstringlist) : boolean;
  end;
  selec = class          //Selection Object
    private
      state : integer;
      text, URL : String;
      subs, effects, conditions : tstringlist;
      public
      constructor create(line : String);
      destructor free();
      //getters
      function checkForCondition(player : Tplayer) : String;
      function getState() : integer;
      function getText() : String;
      function getURL() : String;
      function getEffect : tstringlist;
    end;

implementation

uses Unit1, Unit3;
      {player}
constructor Tplayer.create(gold, armor, health, strength : integer);  //constructor
begin
   self.items := Tstringlist.Create;
   self.gold := gold;
   self.armor := armor;
   self.health := health;
   self.strength := strength;
end;

destructor Tplayer.free();                                            //destructor
Begin
  items.free;
End;

procedure Tplayer.addItem(item: string);                              //items hinzuf�gen
begin
  self.items.Add(item);
end;

function Tplayer.checkForItem(item : String) : boolean;               //items testen
var i : integer;
Begin
 result:= false;
 if self.items.Count <> 0 then
 Begin
  for i := 0 to self.items.Count -1 do
    Begin
    if item = self.items[i] then
      Begin
      result := true;
      break;
      End
    else if self.items.Count -1 = i  then
      result:= false;

    End;
 End;

End;
//getters
function Tplayer.getGold() : integer;
begin
  result := self.gold;
end;

function Tplayer.getArmor;
begin
  result := self.armor;
end;

function Tplayer.getHealth;
begin
  result := self.health;
end;

function Tplayer.getStrength;
begin
  result := self.strength;
end;

function Tplayer.getItems;
begin
  result:= self.items;
end;

//setters

procedure Tplayer.setGold;
begin
  self.gold := setter;
end;

procedure Tplayer.setArmor(setter: Integer);
begin
  self.armor := setter;
end;

procedure Tplayer.setHealth(setter: Integer);
begin
  self.health := setter;
end;

procedure Tplayer.setStrength(setter: Integer);
begin
  self.strength := setter;
end;

procedure Tplayer.setItems;
begin
  self.items := setter;
end;

      //Effect Aus�bung von der ausgew�lten Selection
function Tplayer.setEffect(effect : tstringlist) : boolean;
var effects: tstringlist;
    i : integer;
Begin
  //stringlist um eine Erweiterung um mehrere Effekte evtl. hinzuzuf�gen
 effects := tstringlist.Create;
 Unit1.Form1.split(':',effect[0],effects);   //gesplittet um die Variable und die Zahl zu isolieren
 result := true; //Falls Spieler stirbt --> false
 //case abh�ngig von der Variable bei 'Gold' ist der case 0 bei 'Armor' 1 usw.
 case IndexStr(effects[0],['Gold', 'Armor', 'HP', 'Strength','Item']) of
 0:
 Begin
   i := strtoint(effects[1]);
   self.gold := self.gold + i;                 //hinzuf�gen der Variable zum eigenen Wert
   if i > 0 then
      Unit1.Form1.Memo1.Lines.Append('Du hast ' + inttostr(i) + ' Gold erhalten!')
   else
      Unit1.Form1.Memo1.Lines.Append('Du hast ' + inttostr(i) + ' Gold verloren!');
   Unit1.Form1.Memo1.Lines.Append('');
 End;
 1:
 Begin
   i := strtoint(effects[1]);
   self.armor := self.armor + i;
   if i > 0 then
      Unit1.Form1.Memo1.Lines.Append('Du hast ' + inttostr(i) + ' R�stung bekommen!')
   else
      Unit1.Form1.Memo1.Lines.Append('Du hast ' + inttostr(i) + ' R�stung verloren!');
   Unit1.Form1.Memo1.Lines.Append('');
 End;
 2:
 Begin
   i := strtoint(effects[1]);
   self.health := self.health + i;
   if i > 0 then
      Unit1.Form1.Memo1.Lines.Append('Du hast ' + inttostr(i) + ' Leben regeneriert!')
   else
      Unit1.Form1.Memo1.Lines.Append('Du hast ' + inttostr(i) + ' Leben verloren!');
   Unit1.Form1.Memo1.Lines.Append('');
   if self.health <= 0 then
   Begin
     ShowMessage('Du bist gestorben!');
     result := false;
   End;
 End;
 3:
 Begin
   i := strtoint(effects[1]);
   self.strength := self.strength + i;
   if i > 0 then
      Unit1.Form1.Memo1.Lines.Append('Du hast ' + inttostr(i) + ' St�rke erlangt!')
   else
      Unit1.Form1.Memo1.Lines.Append('Du hast ' + inttostr(i) + 'St�rke verloren!');
   Unit1.Form1.Memo1.Lines.Append('');
 End;
 4:
 Begin
   self.addItem(effects[1]);
   Unit1.Form1.Memo1.Lines.Append('Du hast ' + effects[1] + ' erhalten!');
   Unit1.Form1.Memo1.Lines.Append('');
 End;
 end;
 Form3.onUpdate(self); //Stats Fenseter updaten
End;

      {selection}
constructor selec.create(line: string);  //Selection wird gebildet abh�ngig von diesem String
begin
  self.subs := tstringlist.create;
  self.effects := TStringList.Create;
  self.conditions := TStringList.Create;
  Unit1.Form1.split('|',line,self.subs);  //line wird gesplittet an den Charachtern '|' (eigener Parameter)
  self.state := strtoint(self.subs[0]);
  self.text := self.subs[1];
  self.URL := self.subs[2];
  case self.state of     // state beschreibt die Art der Selection: 0 w�re bspw. keine Condition o.�.
    1: Unit1.Form1.split(';',self.subs[3],self.conditions);   //Hier auch wieder: M�glichkeit zum erweitern um mehrere
    2: Unit1.Form1.split(';', Self.subs[3], self.effects);    //Conditions oder Effects
    3:Begin
    Unit1.Form1.split(';',self.subs[3],self.conditions);
    Unit1.Form1.split(';', Self.subs[4], self.effects);
    End;
  end;
end;

function selec.checkForCondition(player: Tplayer) : String;         // Pr�fung ob die Selection auch beim player vorhanden
var subs : Tstringlist;                                             // wenn nicht result = 10 Gold o.� f�r die Ausgabe
  con : String;                                                     // du ben�tigst 10 Gold oder so
  con2: Integer;
  abfrage : String;
begin
  subs := Tstringlist.Create;
  if (self.state = 1) or (self.state = 3) then                      // Conditions nur vorhanden bei 1 o. 3
    Begin
      result := '';
      Form1.split(':',self.conditions[0], subs);
      con := (subs[1]);
      abfrage := subs[0];
      //Abfrage f�r die spez. Befehle
      //Wenn vorhanden dann result '' wenn nicht dann String
      case IndexStr(abfrage,['Gold', 'Armor', 'HP', 'Strength', 'Item']) of
      0:Begin
        con2 := StrToInt(con);
        if player.gold > con2 then
          result := ''
        else result := con + ' Gold';
      End;
      1:Begin
        con2 := StrToInt(con);
        if player.armor > con2 then
           result := ''
        else result := con + ' Armor';
      End;
      2:Begin
        con2 := StrToInt(con);
        if player.health > con2 then
          result := ''
        else
          result := con + ' HP';
      End;
      3:Begin
        con2 := StrToInt(con);
        if player.strength > con2 then
          result := ''
        else result := con + ' Strength';
      End;
      4:Begin
        if player.checkForItem(con) then
          result := ''
        else result := 'Item ' + con;
      End;
      end;
    End;
    subs.Free;
end;

//getters
function selec.getState;
begin
  result := self.state;
end;

function selec.getText;
begin
  result := self.text;
end;

function selec.getURL;
begin
  result := self.URL;
end;

function selec.getEffect;
begin
  result := self.effects;
end;

destructor selec.free;
Begin
  self.subs.free;
End;

end.
