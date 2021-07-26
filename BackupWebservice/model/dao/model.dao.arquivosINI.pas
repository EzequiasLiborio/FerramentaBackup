unit model.dao.arquivosINI;

interface

uses
  System.Classes, controller.confpublic;

type
  TarquivosINI = class

  private
  public
    procedure WorkDirectoryAbrir;
  protected

  end;

var
  arquivosINI: TarquivosINI;

implementation

uses
  System.Inifiles, System.SysUtils, Vcl.Forms;

{ TarquivosINI }

procedure TarquivosINI.WorkDirectoryAbrir;
var
  WorkDirectory: TINIFile;

begin

  WorkDirectory := TINIFile.Create(ExtractFilePath(Application.ExeName) + '\Workdir.ini');

  try

    workDirBD := WorkDirectory.ReadString('Diretorios', 'workDirBD', '');
    workDirConf := WorkDirectory.ReadString('Diretorios', 'workDirConf', '');
    workDirBackups := WorkDirectory.ReadString('Diretorios', 'workDirBackups', '');
    workDirFB := WorkDirectory.ReadString('Diretorios', 'workDirFB', '');
    workDirPorta :=  WorkDirectory.ReadString('Diretorios', 'workDirPorta', '8081');

  finally
    WorkDirectory.Free;
  end;

end;

end.
