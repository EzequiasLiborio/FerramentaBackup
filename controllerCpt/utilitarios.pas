unit utilitarios;

interface

function ExtractNome(const FileName: string): string;

implementation

uses
  System.SysUtils;

function ExtractNome(const FileName: string): string;
begin
  result := '';

  result := ExtractFileName(FileName);

  result := copy(result, 1, length(result) - length(ExtractFileExt(result)));

end;

end.
