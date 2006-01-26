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
  plugmgr;

type
  TAppForm = class(TForm)
    tmrLaunch: TTimer;
    procedure tmrLaunchTimer(Sender: TObject);
  private
    FPluginMgr: TPluginManager;
    //FLoader: TLoaderForm;
    { D�clarations priv�es }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure TestClosePlugins;
    procedure TestContact;
    procedure TestClients;
    property PluginMgr: TPluginManager read FPluginMgr;
    { D�clarations publiques }
  end;

var
  AppForm: TAppForm;

implementation

uses loading, display, plugdef, plugintf;

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
  FPluginMgr['contact'].DisplayClose;
  FPluginMgr['clients'].DisplayClose;
end;

procedure TAppForm.TestContact;
var
  Stream: TSerializeStream;
begin
  Stream := TSerializeStream.Create('object TContactData'#$D#$A'  NomContact = ''testload'''#$D#$A'end'#$D#$A);
  try
    with FPluginMgr['contact']  do
    begin
      IOLoadFromStream(Stream);
      DisplayShow(DisplayForm.Panel3);
    end;
  finally
    LoadingForm.Hide;
    Stream.Free;
  end;
end;

procedure TAppForm.TestClients;
var
  Stream: TStringStream;
begin
  Stream := TSerializeStream.Create('object TClientsData'#$D#$A'  Collection = <'#$D#$A'    item'#$D#$A'      NomClient = ''Lawrence-Albert Z'#233'mour'''#$D#$A'    end'#$D#$A'    item'#$D#$A'      NomClient = ''Anne-Ang'#233'lique Meuleman'''#$D#$A'    end>'#$D#$A'end'#$D#$A);
  try
    with FPluginMgr['clients'] do
    begin
      IOLoadFromStream(Stream);
      DisplayShow(DisplayForm.Panel2);
    end;
  finally
    LoadingForm.Hide;
    Stream.Free;
  end;
end;

procedure TAppForm.tmrLaunchTimer(Sender: TObject);
begin
  tmrLaunch.Enabled := False;
  LoadingForm.Show;
  FPluginMgr.LoadPlugins;
  TestClients;
  DisplayForm.ShowModal;
  TestClosePlugins;
  Close;
end;

end.
