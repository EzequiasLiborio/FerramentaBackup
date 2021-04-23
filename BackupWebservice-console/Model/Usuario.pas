unit Usuario;

interface

type

  Tusuario = class
  public
    constructor Create(id: Integer; nome: String);
  private
    Fid: Integer;
    Fnome: String;
    procedure Setid(const Value: Integer);
    procedure Setnome(const Value: String);
  published
    property id: Integer read Fid write Setid;
    property nome: String read Fnome write Setnome;
  end;

implementation

{ Tusuario }

constructor Tusuario.Create(id: Integer; nome: String);
begin
  Setid(id);
  Setnome(nome);
end;

procedure Tusuario.Setid(const Value: Integer);
begin
  Fid := Value;
end;

procedure Tusuario.Setnome(const Value: String);
begin
  Fnome := Value;
end;

end.
