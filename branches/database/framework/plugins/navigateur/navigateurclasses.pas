{-------------------------------------------------------------------------------
Copyright (c) 2006 Lawrence-Albert Zemour. All rights reserved.

This file is part of Sofia.

Sofia is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

Sofia is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Sofia; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-------------------------------------------------------------------------------}

unit navigateurclasses;

interface

uses Classes, Controls, plugintf;

type

  IController = interface(IInterface)
  ['{CD5C131C-E966-4743-85B9-D1F2E96D4DDD}']
    procedure Refresh; stdcall;
  end;

  TNavigateurPlugin = class(TInterfacedObject, IPlugUnknown, IPlugDisplay)
  private
    FContainer: TWinControl;
    FController: IController;
  public
    constructor Create;
    destructor Destroy; override;
    function GetContainer: TWinControl; stdcall;
  end;

implementation

uses navigateurctrl;

constructor TNavigateurPlugin.Create;
begin
  FContainer := TNavigateurFrame.Create(nil);
  FController := NewController(FContainer);
end;

destructor TNavigateurPlugin.Destroy;
begin
  FContainer.Free;
  inherited;
end;

function TNavigateurPlugin.GetContainer: TWinControl;
begin
  Result := FContainer;
end;


end.
