library dbobj;

uses
  plugintf,
  dbobjclasses in 'dbobjclasses.pas';

function NewPlugin: IPlugUnknown;
begin
  Result := TPlugin.Create;
end;

exports
  NewPlugin;
{$R *.res}

begin
end.

