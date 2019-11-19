unit uGameRect;

interface

uses Graphics, Math, Dialogs, SysUtils;

type

  TGameCreationMethod = (TGAME_RANDOM, TGAME_CALCULATED);

  TGameRect = class
  private
    pGameArea : Array of Array of Byte;
    pWidth: Integer;
    pHeight: Integer;
    pNumColors: Byte;
    procedure recursiveRectSearch(X,Y: Integer);
  public
    constructor Create();
    destructor  Destroy(); override;
    procedure Init(method: TGameCreationMethod);
    function  GetWidth(): Integer;
    procedure SetWidth(i: Integer);
    function  GetHeight(): Integer;
    procedure SetHeight(i: Integer);
    function  GetBlocksRemaining(): Integer;
    function  GetColorCount(): Byte;
    procedure SetColorCount(cc: Byte);
    procedure ClickOnCoord(x,y: Integer);
    function  IsCoordEmpty(x,y: Integer): Boolean;
    function  IsGameOver(): Boolean;
    function  GetCoord(x,y: Integer): Byte;
  end;

implementation

constructor TGameRect.Create();
  begin
    inherited;
    pWidth := 10;
    pHeight := 10;
    pNumColors := 4;
    Init(TGAME_RANDOM);
  end;

destructor  TGameRect.Destroy();
  begin inherited; end;

procedure TGameRect.Init(method: TGameCreationMethod);
  var i,j: Integer;
  begin
    case method of
    TGAME_RANDOM: begin
      setLength(pGameArea,pWidth);
      for i := 0 to pWidth -1 do
      setLength(pGameArea[i],pHeight);
      randomize();
      for i := 0 to pWidth -1 do
        for j := 0 to pHeight -1 do
          pGameArea[i,j] := RandomRange(1,pNumColors+1);
      end;
    TGAME_CALCULATED: begin
      for i := 0 to pWidth -1 do
        for j := 0 to pHeight -1 do
          if i < 6 then pGameArea[i,j] := 1
          else pGameArea[i,j] := 2
      end;
    end;
  end;

function  TGameRect.GetBlocksRemaining(): Integer;
  var i,j,k: Integer;
  begin
    k := 0;
    for i:=0 to pWidth-1 do
      for j:=0 to pHeight-1 do
        if pGameArea[i,j]<>0 then inc(k);
    Result := k;
  end;

function  TGameRect.GetWidth(): Integer;
  begin Result := pWidth; end;

procedure TGameRect.SetWidth(i: Integer);
  begin pWidth := i; end;

function  TGameRect.GetHeight(): Integer;
  begin Result := pHeight; end;

procedure TGameRect.SetHeight(i: Integer);
  begin pHeight := i; end;

function  TGameRect.GetColorCount(): Byte;
  begin Result := pNumColors; end;

procedure TGameRect.SetColorCount(cc: Byte);
  begin
    if cc < 128 then pNumColors := cc
    else raise Exception.Create('Wrong parameter: ' + #13#10 +
                                'Number of colors may not be larger then 127');
  end;

procedure TGameRect.recursiveRectSearch(X,Y: Integer);
  begin
    if (x <> 0) and (pGameArea[x-1,y] = pGameArea[x,y] XOR 128) then begin
      pGameArea[x-1,y] := pGameArea[x-1,y] XOR 128;
      recursiveRectSearch(x-1,y);
    end;
    if (x < pWidth -1) and (pGameArea[x+1,y]= pGameArea[x,y] XOR 128) then begin
      pGameArea[x+1,y] := pGameArea[x+1,y] XOR 128;
      recursiveRectSearch(x+1,y);
    end;
    if (y <> 0) and (pGameArea[x,y-1] = pGameArea[x,y] XOR 128) then begin
      pGameArea[x,y-1] := pGameArea[x,y-1] XOR 128;
      recursiveRectSearch(x,y-1);
    end;
    if (y< pHeight-1) and (pGameArea[x,y+1] = pGameArea[x,y] XOR 128) then begin
      pGameArea[x,y+1] := pGameArea[x,y+1] XOR 128;
      recursiveRectSearch(x,y+1);
    end;
  end;

procedure TGameRect.ClickOnCoord(x,y: Integer);
  var f: Boolean;
      i,j,k: Integer;
  begin
    f := false;
    if pGameArea[x,y] <> 0 then begin
      if x <> 0 then f := pGameArea[x-1,y] = pGameArea[x,y];                    // left
      if x < pWidth -1 then f := f OR (pGameArea[x+1,y] = pGameArea[x,y]);      // right
      if y <> 0 then f := f OR (pGameArea[x,y-1] = pGameArea[x,y]);             // up
      if y < pHeight -1 then f := f OR (pGameArea[x,y+1] = pGameArea[x,y]);     // down
      if f then begin
        pGameArea[x,y] := pGameArea[x,y] XOR 128;
        recursiveRectSearch(x,y);
      end;
      for i :=0 to pWidth -1 do                                                 // delete marked fields
        for j:=0 to pHeight-1 do
          if pGameArea[i,j] AND 128 = 128 then pGameArea[i,j] := 0;
      for i := 0 to pWidth -1 do                                                // collapse
        for k := 0 to pHeight -1 do
          for j := pHeight-2 downto -1 do
            if pGameArea[i,j+1] = 0 then begin
              pGameArea[i,j+1] := pGameArea[i,j];
              pGameArea[i,j] := 0;
            end;
      for i := 0 to pWidth -1 do
        for j := 0 to pWidth -1 do begin
          f := false;
          for k := 0 to pHeight -1 do                                           // check the line for existing blocks
            if pGameArea[j,k] <> 0 then begin
              f := true;
              break;
            end;
          if not f and (j <> pWidth-1) then                                     // collapse when no blocks remaining
            for k := 0 to pHeight-1 do begin
              pGameArea[j,k] := pGameArea[j+1,k];
              pGameArea[j+1,k] := 0;
            end;
        end;
    end;
  end;

function  TGameRect.IsGameOver(): Boolean;
  var b: Boolean;
      i,j: Integer;
  begin
    b := false;
    if GetBlocksRemaining() = 0 then b := FALSE
    else begin
      for i := 0 to pWidth -1 do begin
        for j := 0 to pHeight -2 do
          if (pGameArea[i,j] = pGameArea[i,j+1]) and
             (pGameArea[i,j] <> 0)then begin
            b := TRUE;
            break;
          end;
        if b then break;
      end;
      if not b then
        for i := 0 to pWidth -2 do begin
          for j := 0 to pHeight -1 do
            if (pGameArea[i,j] = pGameArea[i+1,j]) and
               (pGameArea[i,j] <> 0) then begin
              b := TRUE;
              break;
            end;
          if b then break;
        end;
    end;
    Result := not b;
  end;

function  TGameRect.IsCoordEmpty(x,y: Integer): Boolean;
  begin Result := (pGameArea[x,y] = 0); end;

function  TGameRect.GetCoord(x,y: Integer): Byte;
  begin Result := pGameArea[x,y]; end;

end.
