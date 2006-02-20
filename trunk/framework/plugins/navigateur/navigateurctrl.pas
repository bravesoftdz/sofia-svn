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

unit navigateurctrl;

interface

uses
  Forms, Classes, Controls, Grids, navigateurclasses, DBGrids, DB, DBClient,
  ExtCtrls, contnrs, dbuibclasses, jvuib, stdxml_tlb;

type
  TDBViewList = class;

  TDBView = class(TObject)
  private
    FClientDataSet: TClientDataset;
    FDataSource: TDataSource;
    FDBGrid: TDBGrid;
    FName: string;
  public
    constructor Create(AName, XMLData: string);
    destructor Destroy; override;
    property ClientDataSet: TClientDataset read FClientDataSet write FClientDataSet;
    property DataSource: TDataSource read FDataSource write FDataSource;
    property DBGrid: TDBGrid read FDBGrid write FDBGrid;
    property Name: string read FName write FName;
  end;

  TDBViewList = class(TObjectList)
  private
    FDBViewList: TObjectList;
    function GetCount: Integer;
    function GetItems(Index: Integer): TDBView;
  public
    constructor Create;
    destructor Destroy; override;
    function Add(AName, XMLData: string): TDBView;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TDBView read GetItems; default;
  end;

  TNavigateurFrame = class(TFrame)
  private
    FDBViewList: TDBViewList;
    { Déclarations privées }
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    property DBViewList: TDBViewList read FDBViewList;
    { Déclarations publiques }
  end;

  TController = class(TInterfacedObject, IController)
    procedure AddResultatRecherche(Name, XMLData: string); stdcall;
  private
    FContainer: TNavigateurFrame;
  public
    constructor Create(AContainer: TWinControl);
    destructor Destroy; override;
    property Container: TNavigateurFrame read FContainer write FContainer;
  end;

function NewController(AControl: TWinControl): IController;

implementation

uses SysUtils;

{$R *.dfm}

function NewController(AControl: TWinControl): IController;
begin
  Result := TController.Create(AControl);
end;

constructor TController.Create(AContainer: TWinControl);
begin
  FContainer := AContainer as TNavigateurFrame;
end;

destructor TController.Destroy;
begin
  inherited;
end;

procedure TController.AddResultatRecherche(Name, XMLData: string);
begin
  FContainer.DBViewList.Add(Name, XMLData);
end;

constructor TDBView.Create(AName, XMLData: string);
begin
  inherited Create;
  FName := AName;
  FClientDataSet := TClientDataset.Create(nil);
  FDataSource := TDataSource.Create(nil);
  FDBGrid := TDBGrid.Create(nil);
  FDBGrid.DataSource := FDataSource;
  FDataSource.DataSet := FClientDataSet;
  FClientDataSet.XMLData := XMLData;
end;

destructor TDBView.Destroy;
begin
  FreeAndNil(FDBGrid);
  FreeAndNil(FDataSource);
  FreeAndNil(FClientDataSet);
  inherited Destroy;
end;

constructor TDBViewList.Create;
begin
  inherited;
  FDBViewList := TObjectList.Create;
end;

destructor TDBViewList.Destroy;
begin
  FDBViewList.Free;
  inherited;
end;

function TDBViewList.Add(AName, XMLData: string): TDBView;
begin
  Result := TDBView.Create(AName, XMLData);
  FDBViewList.Add(Result);
end;

function TDBViewList.GetCount: Integer;
begin
  Result := FDBViewList.Count;
end;

function TDBViewList.GetItems(Index: Integer): TDBView;
begin
  Result := TDBView(FDBViewList.Items[Index]);
end;

constructor TNavigateurFrame.Create(AOwner: TComponent);
begin
  inherited;
  FDBViewList := TDBViewList.Create();
end;

destructor TNavigateurFrame.Destroy;
begin
  FreeAndNil(FDBViewList);
  inherited Destroy;
end;

end.

