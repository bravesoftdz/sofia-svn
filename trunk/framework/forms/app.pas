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

unit app;

interface

uses
  Forms, Controls, ExtCtrls, Classes, StdCtrls,
  plugins;

type
  TAppForm = class(TForm)
    tmrLaunch: TTimer;
    procedure tmrLaunchTimer(Sender: TObject);
  private
    FPluginMgr: TPluginManager;
    //FLoader: TLoaderForm;
    { Déclarations privées }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure TestClosePlugins;
    procedure TestOpenPlugin1;
    procedure TestOpenPlugin2;
    property PluginMgr: TPluginManager read FPluginMgr;
    { Déclarations publiques }
  end;

var
  AppForm: TAppForm;

implementation

uses loading, display, plugintf, SysUtils;

{$R *.dfm}

constructor TAppForm.Create(AOwner: TComponent);
begin
  inherited;
  Application.ShowMainForm := False;
  FPluginMgr := TPluginManager.Create;
end;

destructor TAppForm.Destroy;
begin
  FPluginMgr.Free;
  inherited;
end;

procedure TAppForm.TestClosePlugins;
begin
  (FPluginMgr.Plugins[0] as TControlInstance).Close;
  (FPluginMgr.Plugins[1] as TControlInstance).Close;
end;

procedure TAppForm.TestOpenPlugin1;
var
  XML: TStringStream;
begin
  XML := TStringStream.Create('object TContactData'#$D#$A'  NomContact = ''testload'''#$D#$A'end'#$D#$A);
  try
    FPluginMgr.LoadPlugins;
    with FPluginMgr.Plugins[0] as TControlInstance do
    begin
      (Plugin as IControl).Load(XML);
      Open(DisplayForm.Panel2);
    end;
  finally
    LoadingForm.Hide;
    XML.Free;
  end;
end;

procedure TAppForm.TestOpenPlugin2;
var
  XML: TStringStream;
begin
  XML := TStringStream.Create('object TClientsData'#$D#$A'  Collection = <'#$D#$A'    item'#$D#$A'      NomClient = ''Lawrence-Albert Z'#233'mour'''#$D#$A'    end'#$D#$A'    item'#$D#$A'      NomClient = ''Anne-Ang'#233'lique Meuleman'''#$D#$A'    end>'#$D#$A'end'#$D#$A);
  try
    FPluginMgr.LoadPlugins;
    with FPluginMgr.Plugins[1] as TControlInstance do
    begin
      (Plugin as IControl).Load(XML);
      Open(DisplayForm.Panel3);
    end;
  finally
    LoadingForm.Hide;
    XML.Free;
  end;
end;

procedure TAppForm.tmrLaunchTimer(Sender: TObject);
begin
  tmrLaunch.Enabled := False;
  LoadingForm.Show;
  TestOpenPlugin1;
  TestOpenPlugin2;
  DisplayForm.ShowModal;
  TestClosePlugins;
  Close;
end;

end.

