object SkinBrowser: TSkinBrowser
  Left = 524
  Top = 114
  BorderStyle = bsToolWindow
  Caption = 'Skin-Browser'
  ClientHeight = 389
  ClientWidth = 421
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
  object lbl_NoSkinsError: TLabel
    Left = 168
    Top = 8
    Width = 209
    Height = 177
    AutoSize = False
    Transparent = True
    WordWrap = True
  end
  object pBox_Preview: TPaintBox
    Left = 168
    Top = 8
    Width = 249
    Height = 249
    OnPaint = pBox_PreviewPaint
  end
  object lst_Skins: TListBox
    Left = 0
    Top = 8
    Width = 161
    Height = 249
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
    OnClick = lst_SkinsClick
  end
  object btn_Cancel: TButton
    Left = 301
    Top = 355
    Width = 113
    Height = 30
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 1
  end
  object btn_OK: TButton
    Left = 182
    Top = 355
    Width = 113
    Height = 30
    Caption = #220'bernehmen'
    ModalResult = 1
    TabOrder = 2
  end
  object lst_Backgrounds: TListBox
    Left = 0
    Top = 264
    Width = 417
    Height = 81
    ItemHeight = 13
    Sorted = True
    TabOrder = 3
    OnClick = lst_BackgroundsClick
  end
end
