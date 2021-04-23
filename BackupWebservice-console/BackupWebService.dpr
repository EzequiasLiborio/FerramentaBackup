program BackupWebService;

{$APPTYPE CONSOLE}
{$R *.res}

uses Horse, Horse.Jhonson, Horse.Commons, Horse.BasicAuthentication,
  Horse.Compression, Horse.OctetStream, Horse.HandleException, system.Json, system.SysUtils,
  System.Classes;

var
  App: THorse;
  Users: TJSONArray;

begin

  App := THorse.Create(9000);

  Users := TJSONArray.Create;
  // App.use(Compression()) // Must come before Jhonson middleware
  // tipo stream nãodeve ser zipado
  App.use(Jhonson());
  App.use(OctetStream);
  App.use(HandleException);

  App.use(HorseBasicAuthentication(
    function(const AUsername, APassword: string): Boolean
    begin
      Result := AUsername.Equals('user') and APassword.Equals('password');
    end));

  App.Get('exception',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      LConteudo := TJSONObject.Create;
      LConteudo.AddPair('nome', 'ezequias');
      Res.Send(LConteudo);
    end);

  App.Get('/users',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Send<TJSONAncestor>(Users.Clone);
    end);

  App.Post('/user',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      user: TJSONObject;
    begin
      user := Req.Body<TJSONObject>.Clone as TJSONObject;
      Users.AddElement(user);
      Res.Send<TJSONAncestor>(user.Clone).Status(THTTPStatus.created);

    end);

  App.Post('/BancoDados',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      lsStream: TMemoryStream;
    begin
      user := Req.Body<TJSONObject>.Clone as TJSONObject;
      Users.AddElement(user);
      Res.Send<TJSONAncestor>(user.Clone).Status(THTTPStatus.created);

    end);

  App.Delete('/user/:id',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      id: Integer;
    begin
      id := Req.Params.Items['id'].ToInteger;
      Users.Remove(id).Free;
      Res.Send<TJSONAncestor>(Users.Clone).Status(THTTPStatus.NoContent);

    end);

  App.start;

end.
