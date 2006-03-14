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

unit displayclasses;

interface

uses Controls, plugintf, displayctrl, StdXML_TLB;

type

  TPlugin = class(TInterfacedObject, IPlugUnknown, IPlugDisplay, IPlugPages)
    procedure AddPage(AName, ACaption: string); stdcall;
    procedure Hide; stdcall;
    procedure Show; stdcall;
    procedure SetParent(const Value: TWinControl); stdcall;
    procedure SetXMLCursor(const Value: IXMLCursor); stdcall;
    function GetXML: string; stdcall;
    procedure SetPluginManager(const Value: IPluginManager); stdcall;
    procedure SetXML(const Value: string); stdcall;
  private
    FContainer: TWinControl;
    FController: IController;
    FXMLCursor: IXMLCursor;
    FParent: TWinControl;
    FPluginManager: IPluginManager;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses Classes, displaygui;

constructor TPlugin.Create;
begin
  FContainer := TContainer.Create(nil);
  FController := NewController(FContainer);
end;

destructor TPlugin.Destroy;
begin
  FController := nil;
  FXMLCursor := nil;
  inherited;
end;

procedure TPlugin.AddPage(AName, ACaption: string);
begin
  with FPluginManager[AName].AsDisplay do
  begin
    Parent := FController.AddPage(AName, ACaption);;
    Show;
  end;
end;

procedure TPlugin.Hide;
begin
  FContainer.Parent := nil;
end;

procedure TPlugin.SetXML(const Value: string);
begin
  if Length(Value) > 0 then
  begin
    FXMLCursor.LoadXML(Value);
    //FController.Propriete := FXMLCursor.GetValue('Propriete');
  end;
end;

function TPlugin.GetXML: string;
begin

  if FXMLCursor.Count = 0 then
    //FXMLCursor.AppendChild('Propriete', FController.Propriete)
  else
    {FXMLCursor.SetValue('/Propriete', FController.Propriete)};
  Result := FXMLCursor.XML;

end;

procedure TPlugin.SetParent(const Value: TWinControl);
begin
  FParent := Value;
end;

procedure TPlugin.SetPluginManager(const Value: IPluginManager);
begin
  FPluginManager := Value;
end;

procedure TPlugin.SetXMLCursor(const Value: IXMLCursor);
begin
  FXMLCursor := Value;
end;

procedure TPlugin.Show;
begin
  FContainer.Parent := FParent;
  FContainer.Align := alClient;

  AddPage('welcome', 'Accueil');
end;

end.

