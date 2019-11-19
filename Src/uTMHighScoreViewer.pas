unit uTMHighScoreViewer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uTMHighScore, StdCtrls, Math;

type
  THighScoreViewer = class(TForm)
    lbl_Name_Head: TLabel;
    lbl_Blocks_Head: TLabel;
    lbl_Time_Head: TLabel;
    txt_Name_9: TEdit;
    txt_Name_0: TEdit;
    txt_Name_1: TEdit;
    txt_Name_2: TEdit;
    txt_Name_3: TEdit;
    txt_Name_4: TEdit;
    txt_Name_5: TEdit;
    txt_Name_6: TEdit;
    txt_Name_7: TEdit;
    txt_Name_8: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    lbl_Blocks_0: TLabel;
    lbl_Blocks_1: TLabel;
    lbl_Blocks_2: TLabel;
    lbl_Blocks_3: TLabel;
    lbl_Blocks_4: TLabel;
    lbl_Blocks_5: TLabel;
    lbl_Blocks_6: TLabel;
    lbl_Blocks_7: TLabel;
    lbl_Blocks_8: TLabel;
    lbl_Blocks_9: TLabel;
    Button2: TButton;
    lbl_Time_0: TLabel;
    lbl_Time_1: TLabel;
    lbl_Time_2: TLabel;
    lbl_Time_3: TLabel;
    lbl_Time_4: TLabel;
    lbl_Time_5: TLabel;
    lbl_Time_6: TLabel;
    lbl_Time_7: TLabel;
    lbl_Time_8: TLabel;
    lbl_Time_9: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    pDelScore: Boolean;
    isHighScore: Boolean;
    pos: Integer;
    pHighScore: TScoreLevel;
    pControls: Array [0..2] of Array [0..9] of TObject;
  public
    procedure setHighScore(p: Pointer; Time: Int64; Blocks: Cardinal);
    procedure showHighScore(p: Pointer);
    procedure start();
    function  getHighScore(): TScoreLevel;
    function  hasToReset(): Boolean;
  end;

var
  HighScoreViewer: THighScoreViewer;

implementation

{$R *.dfm}

procedure THighScoreViewer.FormCreate(Sender: TObject);
  begin
    pDelScore := false;
    pControls[0,0] := txt_Name_0;    pControls[1,0] := lbl_Blocks_0;
    pControls[0,1] := txt_Name_1;    pControls[1,1] := lbl_Blocks_1;
    pControls[0,2] := txt_Name_2;    pControls[1,2] := lbl_Blocks_2;
    pControls[0,3] := txt_Name_3;    pControls[1,3] := lbl_Blocks_3;
    pControls[0,4] := txt_Name_4;    pControls[1,4] := lbl_Blocks_4;
    pControls[0,5] := txt_Name_5;    pControls[1,5] := lbl_Blocks_5;
    pControls[0,6] := txt_Name_6;    pControls[1,6] := lbl_Blocks_6;
    pControls[0,7] := txt_Name_7;    pControls[1,7] := lbl_Blocks_7;
    pControls[0,8] := txt_Name_8;    pControls[1,8] := lbl_Blocks_8;
    pControls[0,9] := txt_Name_9;    pControls[1,9] := lbl_Blocks_9;

    pControls[2,0] := lbl_Time_0;
    pControls[2,1] := lbl_Time_1;
    pControls[2,2] := lbl_Time_2;
    pControls[2,3] := lbl_Time_3;
    pControls[2,4] := lbl_Time_4;
    pControls[2,5] := lbl_Time_5;
    pControls[2,6] := lbl_Time_6;
    pControls[2,7] := lbl_Time_7;
    pControls[2,8] := lbl_Time_8;
    pControls[2,9] := lbl_Time_9;
  end;

function  THighScoreViewer.hasToReset(): Boolean;
  begin Result := pDelScore; end;

procedure THighScoreViewer.start();
  function  convIntToStr(i,minLength: Integer): String;
     var r: String;
     begin
       r := IntToStr(i);
       while Length(r) < minLength do r := '0' + r;
       Result := r;
     end;
  var i: Integer;
  begin
    try
      for i := 0 to 9 do begin
        TEdit(pControls[0,i]).Text := pHighScore[i].Player;
        if not ((pHighScore[i].BlocksRemaining = 9999) and
                (pHighScore[i].Time = 5940000)) then begin
          TLabel(pControls[1,i]).Caption := IntToStr(pHighScore[i].BlocksRemaining);
          TLabel(pControls[2,i]).Caption := convIntToStr(floor(
                                            pHighScore[i].Time/60),2) + ':' +
                                            convIntToStr(pHighScore[i].Time
                                            MOD 60,2);
          end;
        end;
      if isHighScore then begin
        TEdit(pControls[0,pos]).BorderStyle := bsSingle;
        TEdit(pControls[0,pos]).Color := clWindow;
        TEdit(pControls[0,pos]).Enabled := true;
        TEdit(pControls[0,pos]).Text := '';
      end;
      ShowModal();
    except
      ShowMessage('Es ist zu einem schweren Fehler gekommen.' +
                  #13#10 + 'Das Programm wird nun beendet.');
      Application.Terminate();
    end;
  end;

function  THighScoreViewer.getHighScore(): TScoreLevel;
  begin Result := pHighScore; end;

procedure THighScoreViewer.setHighScore(p:Pointer;Time:Int64;Blocks:Cardinal);
  var i,j: Integer;
  begin
    try
      pHighScore := TScoreLevel(p^);
      for i := 0 to 9 do
        if (pHighScore[i].BlocksRemaining > Integer(Blocks)) or
           ( (pHighScore[i].BlocksRemaining = Integer(Blocks)) and
             (pHighScore[i].Time > Time)                 ) then begin
          isHighScore := true;
          for j := 8 downto i do begin
            pHighScore[j+1].Player := pHighScore[j].Player;
            pHighScore[j+1].BlocksRemaining := pHighScore[j].BlocksRemaining;
            pHighScore[j+1].Time := pHighScore[j].Time;
          end;
          pHighScore[i].BlocksRemaining := Blocks;
          pHighScore[i].Time := Time;
          pos := i;
          break;
        end;
    except
      ShowMessage('Es ist zu einem schweren Fehler gekommen.' +
                  #13#10 + 'Das Programm wird nun beendet.');
      Application.Terminate();
    end;
  end;

procedure THighScoreViewer.showHighScore(p: Pointer);
  begin
    try
      pHighScore := TScoreLevel(p^);
      isHighScore := false;
      pos := 10;
      start();
    except
      ShowMessage('Es ist zu einem schweren Fehler gekommen.' +
                  #13#10 + 'Das Programm wird nun beendet.');
      Application.Terminate();
    end;
  end;

procedure THighScoreViewer.Button2Click(Sender: TObject);
  begin pHighScore[pos].Player := TEdit(pControls[0,pos]).Text; end;

procedure THighScoreViewer.Button1Click(Sender: TObject);
  begin pDelScore := true; end;

end.
