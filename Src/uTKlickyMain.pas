unit uTKlickyMain;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Types, Menus, uGameRect, ComCtrls, Math,
  StrUtils, uTSkinBrowser, ShellAPI, ExtDlgs, uTMConfigStore, uTMHighScore,
  uTMHighScoreViewer;

type
  TKlickusMain = class(TForm)
    Pnl_Status: TPanel;
    Pnl_Game: TPanel;
    lbl_Blx_rem: TLabel;
    lblk_blx_count: TLabel;
    Img_Game: TPaintBox;
    mnu: TMainMenu;
    Datei1: TMenuItem;
    About1: TMenuItem;
    mnu_NeuesSpiel: TMenuItem;
    mnu_Beenden: TMenuItem;
    mnu_KlickyHilfe: TMenuItem;
    mnu_Homepage: TMenuItem;
    Einstellungen1: TMenuItem;
    Schwierigkeitsgrad1: TMenuItem;
    mnu_Skill_0: TMenuItem;
    mnu_Skill_1: TMenuItem;
    mnu_Skill_2: TMenuItem;
    mnu_Skill_3: TMenuItem;
    mnu_Skill_4: TMenuItem;
    mnu_Skill_5: TMenuItem;
    mnu_Skill_6: TMenuItem;
    mnu_Skill_7: TMenuItem;
    mnu_Skill_8: TMenuItem;
    Skinwhlen1: TMenuItem;
    lbl_Time_pstd: TLabel;
    lbl_Time_count: TLabel;
    Timer: TTimer;
    Highscoreanzeigen1: TMenuItem;
    procedure Img_GamePaint(Sender: TObject);
    procedure Img_GameMouseDown(Sender: TObject; Button: TMouseButton;
              Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mnu_NeuesSpielClick(Sender: TObject);
    procedure mnu_BeendenClick(Sender: TObject);
    procedure Skinwhlen1Click(Sender: TObject);
    procedure mnu_HomepageClick(Sender: TObject);
    procedure mnu_KlickyHilfeClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure Highscoreanzeigen1Click(Sender: TObject);
  private
    pStartTime: TSystemTime;
    pScoreEdited: Boolean;
    pSeconds:   Int64;
    pHighScore: THighScore;
    pLevel: Byte;
    pGame: TGameRect;
    pPrevL: TMenuItem;
    pSkinPath: String;
    pBImgPath: String;
    pSkinMap: Array [0..12] of TBitmap;
    pBImgMap: TBitmap;
    config: TMConfigStore;
    function  GetColor(i: Byte): TColor;
    function  getFileName(aFile: String): String;                               
    function  getDirOfFile(aFile: String): String;
    procedure paintGame();
    procedure startNewGame();
    procedure mnu_Skill_Click(Sender: TObject);
    procedure loadSkin(path: String);
    procedure loadBImg(path: String);
    procedure handleScore();
  public
  end;

var KlickusMain: TKlickusMain;

const FIELDLENGTH = 20;

implementation

{$R *.dfm}

procedure TKlickusMain.FormCreate(Sender: TObject);
  begin
    mnu_Skill_0.OnClick := mnu_Skill_Click;
    mnu_Skill_1.OnClick := mnu_Skill_Click;
    mnu_Skill_2.OnClick := mnu_Skill_Click;
    mnu_Skill_3.OnClick := mnu_Skill_Click;
    mnu_Skill_4.OnClick := mnu_Skill_Click;
    mnu_Skill_5.OnClick := mnu_Skill_Click;
    mnu_Skill_6.OnClick := mnu_Skill_Click;
    mnu_Skill_7.OnClick := mnu_Skill_Click;
    mnu_Skill_8.OnClick := mnu_Skill_Click;
    pLevel := 2;
    Pnl_Game.DoubleBuffered := true;                                            // pnl under img_Game has to be buffered
    pGame := TGameRect.Create();                                                // twice to prevent flickering
    pGame.SetWidth(16);
    pGame.SetHeight(18);
    pGame.SetColorCount(3+pLevel);
    pGame.Init(TGAME_RANDOM);
    config := TMConfigStore.Create(getDirOfFile(paramStr(0)) + 'config.dat');
    loadSkin(getDirOfFile(paramStr(0)) + 'Skins\' + config.SkinImage);
    loadBImg(getDirOfFile(paramStr(0)) + 'Backgrounds\' + config.BackImage);
    pLevel := config.Level;
    case pLevel of
    1: pPrevL := mnu_Skill_0;
    2: pPrevL := mnu_Skill_1;
    3: pPrevL := mnu_Skill_2;
    4: pPrevL := mnu_Skill_3;
    5: pPrevL := mnu_Skill_4;
    6: pPrevL := mnu_Skill_5;
    7: pPrevL := mnu_Skill_6;
    8: pPrevL := mnu_Skill_7;
    9: pPrevL := mnu_Skill_8;
    else
    end;
    pPrevL.Checked := true;
    pHighScore := THighScore.Create(getDirOfFile(paramStr(0)) + 'score.dat');
    startNewGame();
  end;

procedure TKlickusMain.FormClose(Sender: TObject; var Action: TCloseAction);
  var i: Integer;
  begin
    if pGame <> nil then pGame.Free();
    for i := 0 to Length(pSkinMap)-1 do
      if pSkinMap[i] <> nil then pSkinMap[i].Free();
    if pBImgMap <> nil then pBImgMap.Free();
    if config <> nil then config.Free();
    if pHighScore <> nil then pHighScore.Free();
  end;

function  TKlickusMain.getFileName(aFile: String): String;
  var c: Cardinal;
  begin
    Result := '';
    aFile := reverseString(aFile);
    for c := 1 to Length(aFile)-1 do
      if aFile[c] = '\' then begin
        Result := reverseString(copy(aFile,0,c-1));
        break;
      end;
  end;

procedure TKlickusMain.handleScore();
  var hv: THighScoreViewer;
  begin
    if not pScoreEdited then begin
      hv := THighScoreViewer.Create(self);
      try
        hv.setHighScore(pHighScore.getScoreLevel(pLevel-1), pSeconds,
                        Cardinal(pGame.GetBlocksRemaining));
        hv.start();
        if hv.hasToReset then pHighScore.reset()
        else pHighScore.setScoreLevel(pLevel-1,hv.gethighScore);
      finally hv.Free();
      end;
      pScoreEdited := true;
    end;
  end;

function  TKlickusMain.getDirOfFile(aFile: String): String;
  var c: Cardinal;
  begin
    Result := '';
    for c := Length(aFile)-1 downto 2 do
      if aFile[c] = '\' then begin
        Result := copy(aFile,0,c);
        break;
      end;
  end;

function  TKlickusMain.GetColor(i: Byte): TColor;
  begin
    case i of
      0 : Result := clBlack;
      1 : Result := $000000FF;
      2 : Result := $00FFFF00;
      3 : Result := $00808040;
      4 : Result := $0000FFFF;
      5 : Result := $00000080;
      6 : Result := $00FF0000;
      7 : Result := $004080FF;
      8 : Result := $00C0C0C0;
      9 : Result := $00800080;
      10: Result := $00404000;
      11: Result := $00008080;
      12: Result := $00FFFFFF;
      else Result := clBlack;
    end;
  end;

procedure TKlickusMain.paintGame();
  var i,j: Integer;
      b: TBitmap;
      s,t: TRect;
      x: Byte;
  begin
    try
      with img_Game.Canvas do begin
        Rectangle(0,0,img_Game.Width,img_Game.Height);
        if pBImgMap <> nil then
          img_Game.Canvas.CopyRect(img_Game.ClientRect,pBImgMap.Canvas,
                                   img_Game.ClientRect);
        for i := 0 to pGame.GetWidth -1 do
          for j := 0 to pGame.GetHeight -1 do begin
            x := pGame.GetCoord(i,j);
            if pSkinMap[12] = nil then begin
              if not ((x=0) and (pBImgPath<>'')) then begin
                Brush.Color := getColor(x);
                Rectangle(i*FIELDLENGTH,j*FIELDLENGTH,(i+1)*FIELDLENGTH,
                          (j+1)*FIELDLENGTH);
              end;
            end else begin
              s.Left   := 0;
              s.Top    := 0;
              s.Right  := FIELDLENGTH;
              s.Bottom := FIELDLENGTH;
              t.Left   := i*FIELDLENGTH;
              t.Top    := j*FIELDLENGTH;
              t.Right  := (i+1)*FIELDLENGTH;
              t.Bottom := (j+1)*FIELDLENGTH;
              if not ((x=0) and (pBImgPath<>'')) then begin
                b := pSkinMap[x];
                img_Game.Canvas.copyRect(t,b.Canvas,s);
              end;
            end;
          end;
        lblk_blx_count.Caption := IntToStr(pGame.GetBlocksRemaining);
      end;
    except
      ShowMessage('Es ist zu einem schwerem Fehler beim Zeichnen des Spiels ' +
                  'gekommen' + #13#10 + 'Das Programm wird beendet.');
      Application.Terminate();
    end;
  end;

procedure TKlickusMain.startNewGame();
  begin
    pScoreEdited := false;
    Timer.Enabled := false;                                                     // game restarted - stop clock
    pSeconds := 0;                                                              // reset seconds since start
    lbl_Time_count.Caption := '';
    pGame.SetColorCount(3+pLevel);
    //pGame.Init(TGAME_CALCULATED);
    pGame.Init(TGAME_RANDOM);
    paintGame();
  end;

procedure TKlickusMain.loadSkin(path: String);
  var i: Integer;
      b: TBitmap;
      s,t: TRect;
  begin
    try
      if path <> '' then begin
        pSkinPath := path;
        config.SkinImage := getFileName(path);
        if pSkinMap[0] = nil then                                               // check whether a skin's been loaded
          for i := 0 to Length(pSkinMap) -1 do begin                            // prepare skinmap if not
            pSkinMap[i] := TBitmap.Create();
            pSkinMap[i].Height := FIELDLENGTH;
            pSkinMap[i].Width := FIELDLENGTH;
          end;
        s.Left   := 3*FIELDLENGTH;
        s.Top    := 3*FIELDLENGTH;
        s.Right  := 4*FIELDLENGTH;
        s.Bottom := 4*FIELDLENGTH;
        t.Left   := 0;
        t.Top    := 0;
        t.Right  := FIELDLENGTH;
        t.Bottom := FIELDLENGTH;
        b := TBitmap.Create();
        try
          b.LoadFromFile(path);
          pSkinMap[0].canvas.CopyRect(t,b.Canvas,s);
          for i := 1 to 4 do begin
            s.Left   := (i-1)*FIELDLENGTH;
            s.Top    := 0;
            s.Right  := i*FIELDLENGTH;
            s.Bottom := FIELDLENGTH;
            pSkinMap[i].canvas.CopyRect(t,b.Canvas,s);
          end;
          for i := 5 to 8 do begin
            s.Left   := (i-5)*FIELDLENGTH;
            s.Top    := FIELDLENGTH;
            s.Right  := (i-4)*FIELDLENGTH;
            s.Bottom := 2*FIELDLENGTH;
            pSkinMap[i].canvas.CopyRect(t,b.Canvas,s);
          end;
          for i := 9 to 12 do begin
            s.Left   := (i-9)*FIELDLENGTH;
            s.Top    := 40;
            s.Right  := (i-8)*FIELDLENGTH;
            s.Bottom := 3*FIELDLENGTH;
            pSkinMap[i].canvas.CopyRect(t,b.Canvas,s);
          end;
        except
          ShowMessage('Die Skindatei ' + path + ' konnte nicht geladen werden');
          for i := 0 to Length(pSkinMap) -1 do FreeAndNil(pSkinMap[i]);
          pSkinPath := '';
        end;
        b.Free();
        paintGame();
      end;
    except
      ShowMessage('Es ist zu einem schwerem Fehler beim Laden der Skindatei ' +
                  'gekommen' + #13#10 + 'Das Programm wird beendet.');
      Application.Terminate();
    end;
  end;

procedure TKlickusMain.loadBImg(path: String);
  begin
    if path <> '' then begin
      pBImgPath := path;
      config.BackImage := getFileName(path);
      if pBImgMap = nil then pBImgMap := TBitmap.Create();
      try    pBImgMap.LoadFromFile(path);
      except
        ShowMessage('Das Hintergrundbild '+path+' konnte nicht geladen werden');
        FreeAndNil(pBImgMap);
        pBImgPath := '';
      end;
      paintGame();
    end;
  end;

procedure TKlickusMain.Img_GamePaint(Sender: TObject);
  begin paintGame(); end;

procedure TKlickusMain.Img_GameMouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
  begin
    if not Timer.Enabled then begin                                             // if clock is not allready runnin'
      pSeconds := 0;                                                            // reset time
      Timer.Enabled := true;                                                    // start timer
      GetSystemTime(pStartTime);                                                // remember systemtime
    end;
    pGame.ClickOnCoord(Floor(x/FIELDLENGTH),Floor(y/FIELDLENGTH));
    LockWindowUpdate(self.Handle);
    try     paintGame();
    finally LockWindowUpdate(0);                                                // update will be allowed
    end;

    if pGame.IsGameOver() then begin
      Timer.Enabled := false;
      handleScore();
      if MessageDlg('Neues Spiel starten?', mtInformation, [mbYes,mbNo],0) =
         mrYes then startNewGame();
    end;
  end;

procedure TKlickusMain.mnu_NeuesSpielClick(Sender: TObject);
  begin startNewGame(); end;                                                    // start new game

procedure TKlickusMain.mnu_BeendenClick(Sender: TObject);
  begin self.Close(); end;                                                      // close application

procedure TKlickusMain.mnu_Skill_Click(Sender: TObject);
  begin
    pLevel := StrToInt(copy(reverseString(TMenuItem(Sender).Name),0,1)) +1;
    pPrevL.Checked := FALSE;
    pPrevL := TMenuItem(Sender);
    pPrevL.Checked := TRUE;
    config.Level := pLevel;
  end;

procedure TKlickusMain.Skinwhlen1Click(Sender: TObject);
  var sb: TSkinBrowser;
  begin
    sb := TSkinBrowser.Create(self);
    try
      if sb.ShowModal() = mrOk then begin
        loadSkin(sb.getSelectedSkin);
        loadBImg(sb.getSelectedBack);
      end;
    finally sb.Free();
    end;
  end;

procedure TKlickusMain.mnu_HomepageClick(Sender: TObject);
  var url: String;
  begin
    url := 'http://www.thomaswerner-online.de/soft_klcks.html';
    ShellExecute(self.Handle,'open',pChar(url),nil,nil,SW_NORMAL);
  end;

procedure TKlickusMain.mnu_KlickyHilfeClick(Sender: TObject);
  var url: String;
  begin
    url := getDirOfFile(ParamStr(0)) + 'Help\deutsch.html';
    ShellExecute(self.Handle,'open',pChar(url),nil,nil,SW_NORMAL);
  end;

procedure TKlickusMain.TimerTimer(Sender: TObject);
  function  convIntToStr(i,minLength: Integer): String;                         // subroutine to format the time
     var r: String;
     begin
       r := IntToStr(i);
       while Length(r) < minLength do r := '0' + r;
       Result := r;
     end;
  var c,d: Int64;
      t: TSystemTime;
  begin
    c := pStartTime.wSecond + (pStartTime.wMinute * 60) +                       // convert time of start into seconds
         (pStartTime.wHour * 60 * 60);
    GetSystemTime(t);                                                           // get current time
    d := t.wSecond + (t.wMinute * 60) + (t.wHour * 60 * 60);                    // convert current time into seconds
    d := d-c;                                                                   // get seconds since game start
    lbl_Time_count.Caption := convIntToStr(floor(d/60),2) + ':' +               // convert seconds to minutes and seconds
                              convIntToStr(d MOD 60,2);
    inc(pSeconds);
  end;

procedure TKlickusMain.Highscoreanzeigen1Click(Sender: TObject);
  var hv: THighScoreViewer;
      s : Boolean;
  begin
    s := Timer.Enabled;
    Timer.Enabled := False;
    hv := THighScoreViewer.Create(self);
    try
      hv.showHighScore(pHighScore.getScoreLevel(pLevel-1));
      if hv.hasToReset then pHighScore.reset();
    finally
      hv.Free();
      Timer.Enabled := s;
    end;
  end;

end.
