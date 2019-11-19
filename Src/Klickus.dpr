program Klickus;

uses
  Forms,
  uTKlickyMain in 'uTKlickyMain.pas' {KlickusMain},
  uGameRect in 'uGameRect.pas',
  uTMConfigStore in 'uTMConfigStore.pas',
  uTMHighScoreViewer in 'uTMHighScoreViewer.pas' {HighScoreViewer},
  uTMHighScore in 'uTMHighScore.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Klickus';
  Application.CreateForm(TKlickusMain, KlickusMain);
  Application.Run;
end.
