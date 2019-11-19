object HighScoreViewer: THighScoreViewer
  Left = 406
  Top = 399
  Width = 363
  Height = 338
  Caption = 'Klickus Highscore-Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_Name_Head: TLabel
    Left = 32
    Top = 8
    Width = 31
    Height = 13
    AutoSize = False
    Caption = 'Name:'
  end
  object lbl_Blocks_Head: TLabel
    Left = 216
    Top = 8
    Width = 35
    Height = 13
    AutoSize = False
    Caption = 'Blocks:'
  end
  object lbl_Time_Head: TLabel
    Left = 264
    Top = 8
    Width = 89
    Height = 13
    AutoSize = False
    Caption = 'Zeit:'
  end
  object Label4: TLabel
    Left = 16
    Top = 32
    Width = 9
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '1.'
  end
  object Label5: TLabel
    Left = 16
    Top = 56
    Width = 9
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '2.'
  end
  object Label6: TLabel
    Left = 16
    Top = 80
    Width = 9
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '3.'
  end
  object Label7: TLabel
    Left = 16
    Top = 104
    Width = 9
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '4.'
  end
  object Label8: TLabel
    Left = 16
    Top = 128
    Width = 9
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '5.'
  end
  object Label9: TLabel
    Left = 16
    Top = 152
    Width = 9
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '6.'
  end
  object Label10: TLabel
    Left = 16
    Top = 176
    Width = 9
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '7.'
  end
  object Label11: TLabel
    Left = 16
    Top = 200
    Width = 9
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '8.'
  end
  object Label12: TLabel
    Left = 16
    Top = 224
    Width = 9
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '9.'
  end
  object Label13: TLabel
    Left = 8
    Top = 248
    Width = 15
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '10.'
  end
  object lbl_Blocks_0: TLabel
    Left = 216
    Top = 32
    Width = 38
    Height = 13
    AutoSize = False
  end
  object lbl_Blocks_1: TLabel
    Left = 216
    Top = 56
    Width = 38
    Height = 13
    AutoSize = False
  end
  object lbl_Blocks_2: TLabel
    Left = 216
    Top = 80
    Width = 38
    Height = 13
    AutoSize = False
  end
  object lbl_Blocks_3: TLabel
    Left = 216
    Top = 104
    Width = 38
    Height = 13
    AutoSize = False
  end
  object lbl_Blocks_4: TLabel
    Left = 216
    Top = 128
    Width = 38
    Height = 13
    AutoSize = False
  end
  object lbl_Blocks_5: TLabel
    Left = 216
    Top = 152
    Width = 38
    Height = 13
    AutoSize = False
  end
  object lbl_Blocks_6: TLabel
    Left = 216
    Top = 176
    Width = 38
    Height = 13
    AutoSize = False
  end
  object lbl_Blocks_7: TLabel
    Left = 216
    Top = 200
    Width = 38
    Height = 13
    AutoSize = False
  end
  object lbl_Blocks_8: TLabel
    Left = 216
    Top = 224
    Width = 38
    Height = 13
    AutoSize = False
  end
  object lbl_Blocks_9: TLabel
    Left = 216
    Top = 248
    Width = 38
    Height = 13
    AutoSize = False
  end
  object lbl_Time_0: TLabel
    Left = 264
    Top = 32
    Width = 85
    Height = 17
    AutoSize = False
  end
  object lbl_Time_1: TLabel
    Left = 264
    Top = 56
    Width = 85
    Height = 13
    AutoSize = False
  end
  object lbl_Time_2: TLabel
    Left = 264
    Top = 80
    Width = 85
    Height = 13
    AutoSize = False
  end
  object lbl_Time_3: TLabel
    Left = 264
    Top = 104
    Width = 85
    Height = 13
    AutoSize = False
  end
  object lbl_Time_4: TLabel
    Left = 264
    Top = 128
    Width = 85
    Height = 13
    AutoSize = False
  end
  object lbl_Time_5: TLabel
    Left = 264
    Top = 152
    Width = 85
    Height = 13
    AutoSize = False
  end
  object lbl_Time_6: TLabel
    Left = 264
    Top = 176
    Width = 85
    Height = 13
    AutoSize = False
  end
  object lbl_Time_7: TLabel
    Left = 264
    Top = 200
    Width = 85
    Height = 13
    AutoSize = False
  end
  object lbl_Time_8: TLabel
    Left = 264
    Top = 224
    Width = 85
    Height = 13
    AutoSize = False
  end
  object lbl_Time_9: TLabel
    Left = 264
    Top = 248
    Width = 85
    Height = 13
    AutoSize = False
  end
  object txt_Name_9: TEdit
    Left = 32
    Top = 248
    Width = 177
    Height = 21
    AutoSize = False
    BorderStyle = bsNone
    Color = clBtnFace
    Enabled = False
    MaxLength = 20
    TabOrder = 0
  end
  object txt_Name_0: TEdit
    Left = 32
    Top = 32
    Width = 177
    Height = 21
    AutoSize = False
    BorderStyle = bsNone
    Color = clBtnFace
    Enabled = False
    MaxLength = 20
    TabOrder = 1
  end
  object txt_Name_1: TEdit
    Left = 32
    Top = 56
    Width = 177
    Height = 21
    AutoSize = False
    BorderStyle = bsNone
    Color = clBtnFace
    Enabled = False
    MaxLength = 20
    TabOrder = 2
  end
  object txt_Name_2: TEdit
    Left = 32
    Top = 80
    Width = 177
    Height = 21
    AutoSize = False
    BorderStyle = bsNone
    Color = clBtnFace
    Enabled = False
    MaxLength = 20
    TabOrder = 3
  end
  object txt_Name_3: TEdit
    Left = 32
    Top = 104
    Width = 177
    Height = 21
    AutoSize = False
    BorderStyle = bsNone
    Color = clBtnFace
    Enabled = False
    MaxLength = 20
    TabOrder = 4
  end
  object txt_Name_4: TEdit
    Left = 32
    Top = 128
    Width = 177
    Height = 21
    AutoSize = False
    BorderStyle = bsNone
    Color = clBtnFace
    Enabled = False
    MaxLength = 20
    TabOrder = 5
  end
  object txt_Name_5: TEdit
    Left = 32
    Top = 152
    Width = 177
    Height = 21
    AutoSize = False
    BorderStyle = bsNone
    Color = clBtnFace
    Enabled = False
    MaxLength = 20
    TabOrder = 6
  end
  object txt_Name_6: TEdit
    Left = 32
    Top = 176
    Width = 177
    Height = 21
    AutoSize = False
    BorderStyle = bsNone
    Color = clBtnFace
    Enabled = False
    MaxLength = 20
    TabOrder = 7
  end
  object txt_Name_7: TEdit
    Left = 32
    Top = 200
    Width = 177
    Height = 21
    AutoSize = False
    BorderStyle = bsNone
    Color = clBtnFace
    Enabled = False
    MaxLength = 20
    TabOrder = 8
  end
  object txt_Name_8: TEdit
    Left = 32
    Top = 224
    Width = 177
    Height = 21
    AutoSize = False
    BorderStyle = bsNone
    Color = clBtnFace
    Enabled = False
    MaxLength = 20
    TabOrder = 9
  end
  object Button2: TButton
    Left = 246
    Top = 280
    Width = 105
    Height = 27
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 10
    OnClick = Button2Click
  end
  object Button1: TButton
    Left = 8
    Top = 280
    Width = 113
    Height = 25
    Caption = 'Highscores l'#246'schen'
    ModalResult = 2
    TabOrder = 11
    OnClick = Button1Click
  end
end
