unit uTSkinBrowser;

interface

uses
  Messages, SysUtils, Windows, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, StrUtils, Math;

type
  TSkinBrowser = class(TForm)
    lst_Skins: TListBox;
    pBox_Preview: TPaintBox;
    btn_Cancel: TButton;
    btn_OK: TButton;
    lbl_NoSkinsError: TLabel;
    lst_Backgrounds: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure lst_SkinsClick(Sender: TObject);
    procedure pBox_PreviewPaint(Sender: TObject);
    procedure lst_BackgroundsClick(Sender: TObject);
  private
    function  getDirOfFile(aFile: String): String;
    function  getFileName(aFile: String): String;
  public
    function  getSelectedSkin(): String;
    function  getSelectedBack(): String;
  end;

var
  SkinBrowser: TSkinBrowser;

implementation

{$R *.dfm}

procedure TSkinBrowser.FormCreate(Sender: TObject);
  var hSearch: THandle;
      w32data: WIN32_FIND_DATAA;
  begin
    self.DoubleBuffered := true;
    hSearch := FindFirstFile(pChar(getDirOfFile(ParamStr(0))+'Skins\*.bmp'),w32data);
    if hSearch <> INVALID_HANDLE_VALUE then begin
      if w32data.dwFileAttributes AND FILE_ATTRIBUTE_DIRECTORY = 0 then
        lst_Skins.Items.Add(getFileName(w32data.cFileName));
      while FindNextFile(hSearch,w32data) do
        if w32data.dwFileAttributes AND FILE_ATTRIBUTE_DIRECTORY = 0 then
          lst_Skins.Items.Add(getFileName(w32data.cFileName));
      FindClose(hSearch);
    end;
    hSearch := FindFirstFile(pChar(getDirOfFile(ParamStr(0))+'Backgrounds\*.bmp'),w32data);
    if hSearch <> INVALID_HANDLE_VALUE then begin
      if w32data.dwFileAttributes AND FILE_ATTRIBUTE_DIRECTORY = 0 then
        lst_Backgrounds.Items.Add(getFileName(w32data.cFileName));
      while FindNextFile(hSearch,w32data) do
        if w32data.dwFileAttributes AND FILE_ATTRIBUTE_DIRECTORY = 0 then
          lst_Backgrounds.Items.Add(getFileName(w32data.cFileName));
      FindClose(hSearch);
    end;
    if lst_Skins.Items.Count = 0 then
      lbl_NoSkinsError.Caption := 'Es konnten keine Skins gefunden werden.'+
      #13#10+ 'Das sollte nicht so sein. Die Darstellung wird' +#13#10+
      'nun gezeichnet, was weniger schön aussieht.'
    else begin
      lbl_NoSkinsError.Caption := '';
      lst_Skins.Selected[0] := TRUE;
    end;
    if lst_Backgrounds.Items.Count > 0 then
      lst_Backgrounds.Selected[0] := TRUE;
  end;

function  TSkinBrowser.getDirOfFile(aFile: String): String;
  var c: Cardinal;
  begin
    Result := '';
    for c := Length(aFile)-1 downto 2 do
      if aFile[c] = '\' then begin
        Result := copy(aFile,0,c);
        break;
      end;
  end;

function  TSkinBrowser.getFileName(aFile: String): String;
  var c: Cardinal;
  begin
    Result := '';
    for c := 1 to Length(aFile)-1 do
      if aFile[c] = '.' then begin
        Result := copy(aFile,0,c-1);
        break;
      end;
  end;

function  TSkinBrowser.getSelectedSkin(): String;
  var c: Cardinal;
  begin
    if lst_Skins.Count = 0 then Result := ''
    else for c := 0 to lst_Skins.Count -1 do
      if lst_Skins.Selected[c] then
        Result := getDirOfFile(ParamStr(0))+'Skins\'+lst_Skins.Items[c]+'.bmp';
  end;

function  TSkinBrowser.getSelectedBack(): String;
  var c: Cardinal;
  begin
    if lst_Backgrounds.Count = 0 then Result := ''
    else for c := 0 to lst_Backgrounds.Count -1 do
      if lst_Backgrounds.Selected[c] then
        Result := getDirOfFile(ParamStr(0))+'Backgrounds\'+lst_Backgrounds.Items[c]+'.bmp';
  end;

procedure TSkinBrowser.lst_SkinsClick(Sender: TObject);
  begin pBox_Preview.Refresh(); end;

procedure TSkinBrowser.lst_BackgroundsClick(Sender: TObject);
  begin pBox_Preview.Refresh(); end;

procedure TSkinBrowser.pBox_PreviewPaint(Sender: TObject);
  var b: TBitmap;
      c: Cardinal;
      r1,r2,r3,r4: TRect;
  begin
    r1.Left := Floor((pBox_Preview.Width-100)/2);
    r1.Top := Floor((pBox_Preview.Height-100)/2);
    r1.Right := r1.Left + 100;
    r1.Bottom := r1.Top + 100;
    r2.Left := 0;
    r2.Top := 0;
    r2.Right := 100;
    r2.Bottom := 100;
    r3.Left := 0;
    r3.Top := 0;
    r3.Right := pBox_Preview.Width;
    r3.Bottom := pBox_Preview.Height;
    r4 := r3;
    b := TBitmap.Create();
    try
      if lst_Backgrounds.Items.Count <> 0 then
        for c := 0 to lst_Backgrounds.Items.Count -1 do
          if lst_Backgrounds.Selected[c] then begin
            b.LoadFromFile(getDirOfFile(ParamStr(0))+'Backgrounds\'+lst_Backgrounds.Items[c]+'.bmp');
            r4.Right := b.Width;
            r4.Bottom := b.Height;
            pBox_Preview.Canvas.CopyRect(r4,b.Canvas,r3);
            break;
          end;
      if lst_Skins.Count <> 0 then
        for c := 0 to lst_Skins.Items.Count -1 do
          if lst_Skins.Selected[c] then begin
            b.LoadFromFile(getDirOfFile(ParamStr(0))+'Skins\'+lst_Skins.Items[c]+'.bmp');
            pBox_Preview.Canvas.CopyRect(r1,b.Canvas,r2);
            break;
          end;
    finally
      b.Free();
    end;
  end;

end.
