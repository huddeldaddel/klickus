unit uTMConfigStore;

interface

uses SysUtils;

type

  TMConfigStore = class
  private
    pFilePath: String;
    pBackImage: String;
    pSkinImage: String;
    pLevel: Byte;
  published
    property BackImage: String read pBackImage write pBackImage;
    property SkinImage: String read pSkinImage write pSkinImage;
    property Level : Byte read pLevel write pLevel;
  public
    constructor Create(filePath: String);
    destructor  Destroy(); override;
  end;

implementation

constructor TMConfigStore.Create(filePath: String);
  var f: Textfile;
      t: String;
  begin
    inherited Create();
    try
      pFilePath := filePath;
      assignFile(f,filePath);
      Reset(f);
      ReadLn(f,pSkinImage);
      ReadLn(f,pBackImage);
      ReadLn(f,t);
      pLevel := strToInt(t);
      CloseFile(f);
    except
    end;
  end;

destructor  TMConfigStore.Destroy();
  var f: TextFile;
  begin
    try
      assignFile(f,pFilePath);
      ReWrite(f);
      WriteLn(f,pSkinImage);
      WriteLn(f,pBackImage);
      WriteLn(f,IntToStr(pLevel));
      CloseFile(f);
    except
    end;
    inherited;
  end;

end.
