unit uTMHighScore;

interface

uses SysUtils, Dialogs, Windows, Forms;

type

  TScore = record
    Player: String;
    BlocksRemaining: Integer;
    Time: Int64;
  end;

  TScoreLevel = Array [0..9] of TScore;

  THighScore = class
  private
    pPath: String;
    pLevel: Array [0..9] of TScoreLevel;
  public
    constructor Create(); overload;
    constructor Create(aPath: String); overload;
    destructor  Destroy(); override;
    procedure saveToFile(aPath: String);
    procedure loadFromFile(aPath: String);
    function  getScoreLevel(Level: Integer): Pointer;
    procedure setScoreLevel(Level: Integer; Score: TScoreLevel);
    procedure reset();
  end;

implementation

constructor THighScore.Create();
  begin
    inherited;
    pPath := '';
  end;

constructor THighScore.Create(aPath: String);
  begin
    Create();
    loadFromFile(aPath);
  end;

destructor  THighScore.Destroy();
  begin
    if pPath <> '' then saveToFile(pPath);
    inherited;
  end;

function  THighScore.getScoreLevel(Level: Integer): Pointer;
  begin Result := @pLevel[Level]; end;

procedure THighScore.setScoreLevel(Level: Integer; Score: TScoreLevel);
  begin pLevel[Level] := Score; end;

procedure THighScore.saveToFile(aPath: String);
  var b: Array [0..31] of Byte;
      d: DWORD;
      h: THandle;
      i,j: Integer;
  begin
    try
      h := CreateFile(pChar(aPath),GENERIC_READ OR GENERIC_WRITE,0,nil,
                      OPEN_ALWAYS,0,0);
      if h <> INVALID_HANDLE_VALUE then begin
        d := 32;
        for i := 0 to 9 do
          for j := 0 to 9 do
            if d = 32 then begin
              zeroMemory(@b[0],32);
              copyMemory(@b[0],Pointer(pLevel[i][j].Player),
                         Length(pLevel[i][j].Player));
              copyMemory(@b[20],@pLevel[i][j].BlocksRemaining,4);
              copyMemory(@b[24],@pLevel[i][j].Time,8);
              writeFile(h,b[0],32,d,nil);
              if d <> 32 then
                ShowMessage('Die Highscores konnten nicht gespeichert werden');
            end;
        closeHandle(h);
      end else ShowMessage('Die Highscores konnten nicht gespeichert werden');
    except
      ShowMessage('Es ist zu einem schweren Fehler beim Speichern gekommen' +
                  #13#10 + 'Das Programm wird nun beendet.');
      Application.Terminate();
    end;
  end;

procedure THighScore.reset();
  var i,j: Integer;
  begin
    for i := 0 to 9 do
      for j := 0 to 9 do begin
        setLength(pLevel[i][j].Player,20);
        zeroMemory(Pointer(pLevel[i][j].Player),20);
        pLevel[i][j].BlocksRemaining := 9999;
        pLevel[i][j].Time := 5940000;
      end;
  end;

procedure THighScore.loadFromFile(aPath: String);
  var b: Array [0..31] of Byte;
      d: DWORD;
      h: THandle;
      i,j: Integer;
  begin
    try
      pPath := aPath;
      for i := 0 to 9 do
        for j := 0 to 9 do begin
          setLength(pLevel[i][j].Player,20);
          zeroMemory(Pointer(pLevel[i][j].Player),20);
          pLevel[i][j].BlocksRemaining := 9999;
          pLevel[i][j].Time := 5940000;
        end;
      h := CreateFile(pChar(aPath),GENERIC_READ,0,nil,OPEN_EXISTING,0,0);
      if h <> INVALID_HANDLE_VALUE then begin
        i := 0;
        j := 0;
        d := 32;
        while d = 32 do begin
          readFile(h,b[0],32,d,nil);
          if d = 32 then begin
            copyMemory(Pointer(pLevel[i][j].Player),@b[0],20);
            copyMemory(@pLevel[i][j].BlocksRemaining,@b[20],4);
            copyMemory(@pLevel[i][j].Time,@b[24],8);
          end;
          if j < 9 then inc(j)
          else begin
            inc(i);
            j := 0;
          end;
          if (i = 10) and (j = 0) then d := 0;
        end;
        closeHandle(h);
      end else ShowMessage('Die Highscore-Datei konnte nicht geladen werden');
    except
      ShowMessage('Es ist zu einem schweren Fehler beim Laden gekommen' +
                  #13#10 + 'Das Programm wird nun beendet.');
      Application.Terminate();
    end;
  end;

end.
