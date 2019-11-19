object KlickusMain: TKlickusMain
  Left = 359
  Top = 347
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Klickus'
  ClientHeight = 366
  ClientWidth = 436
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mnu
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    436
    366)
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Status: TPanel
    Left = 2
    Top = 2
    Width = 105
    Height = 361
    Anchors = [akLeft, akTop, akBottom]
    TabOrder = 0
    object lbl_Blx_rem: TLabel
      Left = 8
      Top = 8
      Width = 36
      Height = 13
      Caption = 'Bl'#246'cke:'
    end
    object lblk_blx_count: TLabel
      Left = 49
      Top = 8
      Width = 3
      Height = 13
    end
    object lbl_Time_pstd: TLabel
      Left = 8
      Top = 32
      Width = 21
      Height = 13
      Caption = 'Zeit:'
    end
    object lbl_Time_count: TLabel
      Left = 49
      Top = 32
      Width = 3
      Height = 13
      Layout = tlCenter
    end
  end
  object Pnl_Game: TPanel
    Left = 112
    Top = 2
    Width = 322
    Height = 362
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    object Img_Game: TPaintBox
      Left = 1
      Top = 1
      Width = 320
      Height = 360
      OnMouseDown = Img_GameMouseDown
      OnPaint = Img_GamePaint
    end
  end
  object mnu: TMainMenu
    Left = 120
    Top = 8
    object Datei1: TMenuItem
      Caption = 'Datei'
      object mnu_NeuesSpiel: TMenuItem
        Caption = 'Neues Spiel'
        OnClick = mnu_NeuesSpielClick
      end
      object mnu_Beenden: TMenuItem
        Caption = 'Beenden'
        OnClick = mnu_BeendenClick
      end
    end
    object Einstellungen1: TMenuItem
      Caption = 'Einstellungen'
      object Highscoreanzeigen1: TMenuItem
        Caption = 'Highscore anzeigen'
        OnClick = Highscoreanzeigen1Click
      end
      object Schwierigkeitsgrad1: TMenuItem
        Caption = 'Schwierigkeitsgrad'
        object mnu_Skill_0: TMenuItem
          Caption = '1'
        end
        object mnu_Skill_1: TMenuItem
          Caption = '2'
        end
        object mnu_Skill_2: TMenuItem
          Caption = '3'
        end
        object mnu_Skill_3: TMenuItem
          Caption = '4'
        end
        object mnu_Skill_4: TMenuItem
          Caption = '5'
        end
        object mnu_Skill_5: TMenuItem
          Caption = '6'
        end
        object mnu_Skill_6: TMenuItem
          Caption = '7'
        end
        object mnu_Skill_7: TMenuItem
          Caption = '8'
        end
        object mnu_Skill_8: TMenuItem
          Caption = '9'
        end
      end
      object Skinwhlen1: TMenuItem
        Caption = 'Skin w'#228'hlen'
        OnClick = Skinwhlen1Click
      end
    end
    object About1: TMenuItem
      Caption = 'Hilfe'
      object mnu_KlickyHilfe: TMenuItem
        Caption = 'Klickus-Hilfe'
        OnClick = mnu_KlickyHilfeClick
      end
      object mnu_Homepage: TMenuItem
        Caption = 'Homepage'
        OnClick = mnu_HomepageClick
      end
    end
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 152
    Top = 8
  end
end
