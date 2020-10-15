unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  System.JSON, System.iniFiles, System.ioutils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
  FireDAC.Comp.BatchMove.DataSet, FireDAC.Comp.BatchMove,
  FireDAC.Comp.BatchMove.Text, FireDAC.Stan.StorageJSON, PropFilerEh,
  PropStorageEh;

type
  TfrMain = class(TForm)
    IdHTTP1: TIdHTTP;
    Label1: TLabel;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    FDConn: TFDConnection;
    Panel1: TPanel;
    Button1: TButton;
    edURL: TEdit;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    DataSource1: TDataSource;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxGrid1DBTableView1Column4: TcxGridDBColumn;
    cxGrid1DBTableView1Column5: TcxGridDBColumn;
    cxGrid1DBTableView1Column6: TcxGridDBColumn;
    cxGrid1DBTableView1Column7: TcxGridDBColumn;
    FDTab: TFDTable;
    Button3: TButton;
    Button4: TButton;
    Timer1: TTimer;
    IniPropStorageManEh1: TIniPropStorageManEh;
    PropStorageEh1: TPropStorageEh;
    btnStart: TButton;
    btnStop: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edUser: TEdit;
    edPass: TEdit;
    edIP: TEdit;
    edPort: TEdit;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure cxGrid1DBTableView1FocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    var
      fmt: TFormatSettings;
      IniFile: TIniFile;
      skey: string; //ключ фокусной строки
      skey_change: boolean;
    const
      FIniFile = 'Settings.ini';
    procedure SaveProp;
    procedure LoadProp;
    function GetItemIndexColumnKey: integer;
    procedure FindKeyRow();
  public
    { Public declarations }
  end;

var
  frMain: TfrMain;

implementation

{$R *.dfm}

procedure TfrMain.btnStopClick(Sender: TObject);
begin
  Timer1.Enabled:= False;
  btnStart.Enabled:= True;
  btnStop.Enabled:= False;
end;

procedure TfrMain.Button1Click(Sender: TObject);
var
  i: integer;
  JSONValue: TJSONValue;
begin
  JSONValue:=  TJSONObject.ParseJSONValue(IdHTTP1.Get(edURL.Text));
  try

//    for i := 0 to FJSON.Count-1 do begin
//        memo1.Lines.Add(FJSON.Pairs[i].JsonString.Value + ' = ' + FJSON.Pairs[i].JsonValue.Value);
//    end;
  finally
    JSONValue.Free;
  end;
end;

procedure TfrMain.Button2Click(Sender: TObject);
var
  sl: TStringList;
  s, symbol: string;
  high_value, low_value, volume, quoteVolume, percentChange: real;
  date_update: TdateTime;
  JSONValue, jv: TJSONValue;

begin
  if OpenDialog1.Execute then
  begin

    sl:= TStringList.Create;
    try
      sl.LoadFromFile(OpenDialog1.FileName);
      JSONValue:=  TJSONObject.ParseJSONValue(sl.Text);
      skey_change:= false;
      fdtab.DisableControls;
      try
        if JSONValue is TJSONArray then begin
          skey:= fdtab.FieldByName('symbol').AsString;
          fdtab.Edit;
          for jv in TJSONArray(JSONValue) do begin
            FDTab.Insert;

            if jv.TryGetValue('symbol', symbol) then
            else symbol:= '';

             if jv.TryGetValue('high', high_value) then
              else high_value:= 0;

              if jv.TryGetValue('low', low_value) then
              else low_value:= 0;

              if jv.TryGetValue('volume', volume) then
              else volume:= 0;

              if jv.TryGetValue('quoteVolume', quoteVolume) then
              else quoteVolume:= 0;

              if jv.TryGetValue('percentChange', percentChange) then
              else percentChange:= 0;

              if jv.TryGetValue('updatedAt', s) then
              begin

                date_update:= strtodatetime(s, fmt);
              end
              else date_update:= 0;

             FDTab.FieldByName('symbol').AsString:= symbol;
             FDTab.FieldByName('high').AsFloat:= high_value;
             FDTab.FieldByName('low').AsFloat:= low_value;
             FDTab.FieldByName('volume').AsFloat:= volume;
             FDTab.FieldByName('quoteVolume').AsFloat:= quoteVolume;
             FDTab.FieldByName('percentChange').AsFloat:= percentChange;
             if date_update > 0 then
             FDTab.FieldByName('updatedAt').AsDateTime:= date_update;

             FDTab.Post;
          end;
          FDTab.Connection.Commit;
          FDTab.Locate('symbol', skey);
        end;
      finally
        fdtab.EnableControls;
        JSONValue.Free;
      end;
    finally
      sl.Free;
    end;
    skey_change:= true;
    FindKeyRow;
  end;
end;

procedure TfrMain.Button3Click(Sender: TObject);
begin
  cxGrid1DBTableView1.StoreToIniFile(GetCurrentDir + '\grid_settings.ini');
  SaveProp;
end;

procedure TfrMain.Button4Click(Sender: TObject);
begin
  cxGrid1DBTableView1.RestoreFromIniFile(GetCurrentDir + '\grid_settings.ini');
  LoadProp;
end;

procedure TfrMain.Button5Click(Sender: TObject);
begin
  skey_change:= false;
  FDTab.Active:= false;
  fdtab.Active:= true;
  skey_change:= true;
  FindKeyRow;
end;

procedure TfrMain.btnStartClick(Sender: TObject);
begin
  btnStart.Enabled:= False;
  btnStop.Enabled:= True;
  Timer1.Enabled:= True;
end;

procedure TfrMain.cxGrid1DBTableView1FocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  if skey_change then
  skey:= fdtab.FieldByName('symbol').AsString;
  //skey:= AFocusedRecord.Values[GetItemIndexColumnKey];
end;

procedure TfrMain.FindKeyRow();
begin
  if not (skey = EmptyStr) then
  begin
    cxGrid1DBTableView1.Controller.ClearSelection;
    with cxGrid1DBTableView1.DataController do
    begin
      BeginLocate;
      try
        DataSet.Locate('symbol', skey, []);
      finally
        EndLocate;
      end;
    end;

    if Assigned(cxGrid1DBTableView1.Controller.FocusedRecord) then
    begin
      cxGrid1DBTableView1.Controller.FocusedRecord.Selected := true;
      cxGrid1.SetFocus;
    end;

  end;
end;

procedure TfrMain.FormCreate(Sender: TObject);
begin
  skey:= '';
  skey_change:= true;
end;

procedure TfrMain.FormShow(Sender: TObject);
begin
  FDConn.Params.Database:= GetCurrentDir + '\testJSON.db';
  try
    FDConn.Connected:= True;
    FDTab.Active:= True;
  except
    on E: Exception do begin
      ShowMessage('Не удалось подключиться к БД: ' + #13#10 + E.Message);
      Close;
    end;
  end;

  fmt:= TFormatSettings.Create;
  fmt.DateSeparator:= '-';
  fmt.TimeSeparator:= ':';
  {2020-10-14T06:27:48.74Z}
  fmt.ShortDateFormat:= 'yyyy-mm-ddThh:nn:ss';

end;

function TfrMain.GetItemIndexColumnKey: integer;
var
  i: integer;
begin
  Result:= -1;
  for i := 0 to cxGrid1DBTableView1.ColumnCount-1 do
  if cxGrid1DBTableView1.Columns[i].DataBinding.FieldName = 'symbol' then
  begin
    Result:= i;
    break;
  end;
end;

procedure TfrMain.LoadProp;
var
  IniFile: TIniFile;
  i,j: integer;
  sl: TStringList;
begin
  IniFile:=TIniFile.Create(GetCurrentDir + '\' + FIniFile);
  try
    skey:= IniFile.ReadString('Settings', 'key_string', '');

    if IniFile.SectionExists('GroupRow') then begin
       sl:= TStringList.Create;
       try
         IniFile.ReadSectionValues('GroupRow', sl);

         for i := 0 to sl.Count-1 do begin
            for j := 0 to cxGrid1DBTableView1.ViewData.RecordCount-1 do
            begin

              if VarToStr(cxGrid1DBTableView1.ViewData.Records[j].Values[0]) = sl.Values[sl.Names[i]] then
              begin
                cxGrid1DBTableView1.ViewData.Records[j].Expand(False);
              end;
            end;
         end;

       finally
         sl.Free;
       end;

    end;

  finally
    IniFile.Free;
  end;

  FindKeyRow;
end;

procedure TfrMain.SaveProp;
var
  IniFile: TIniFile;
  FName: string;
  i, index_key: integer;
begin
  FName:= GetCurrentDir + '\' + FIniFile;

  IniFile:= TIniFile.Create(FName);
  try
    IniFile.WriteString('Settings', 'key_string', skey);

    index_key:= GetItemIndexColumnKey;
    IniFile.EraseSection('GroupRow');
    //сохраняем развернутые строки группировки
    for i := 0 to cxGrid1DBTableView1.ViewData.RecordCount-1 do
    begin
      if cxGrid1DBTableView1.ViewData.Records[i].Expanded then
      begin
        IniFile.WriteString('GroupRow', 'RowName_'+i.ToString, cxGrid1DBTableView1.ViewData.Records[i].Values[0]);
      end;
    end;



  finally
    IniFile.Free;
  end;

end;

procedure TfrMain.Timer1Timer(Sender: TObject);
var
  err: boolean;
  s, symbol: string;
  high_value, low_value, volume, quoteVolume, percentChange: real;
  date_update: TdateTime;
  JSONValue, jv: TJSONValue;
  x: integer;
begin
  try
    IdHTTP1.ProxyParams.ProxyUsername:= edUser.Text;
    IdHTTP1.ProxyParams.ProxyPassword:= edPass.Text;
    IdHTTP1.ProxyParams.ProxyServer:= edIP.Text;
    IdHTTP1.ProxyParams.ProxyPort:= StrToIntDef(edPort.Text,0);
    s:= IdHTTP1.Get(edURL.Text);
    err:= False;
  except
    on E: Exception do
    begin
      err:= True;
      showmessage('Произошла ошибка получения ответа с сервера:' + #13#10 + E.Message);
    end;
  end;

  if err then exit;

  JSONValue:=  TJSONObject.ParseJSONValue(s);
  if JSONValue = nil then
  else
  begin
    skey_change:= false;
    x := cxGrid1DBTableView1.Controller.TopRecordIndex;
    fdtab.DisableControls;
    try
        if JSONValue is TJSONArray then begin
          fdtab.Edit;
          for jv in TJSONArray(JSONValue) do begin
            FDTab.Insert;

            if jv.TryGetValue('symbol', symbol) then
            else symbol:= '';

             if jv.TryGetValue('high', high_value) then
              else high_value:= 0;

              if jv.TryGetValue('low', low_value) then
              else low_value:= 0;

              if jv.TryGetValue('volume', volume) then
              else volume:= 0;

              if jv.TryGetValue('quoteVolume', quoteVolume) then
              else quoteVolume:= 0;

              if jv.TryGetValue('percentChange', percentChange) then
              else percentChange:= 0;

              if jv.TryGetValue('updatedAt', s) then
              begin

                date_update:= strtodatetime(s, fmt);
              end
              else date_update:= 0;

             FDTab.FieldByName('symbol').AsString:= symbol;
             FDTab.FieldByName('high').AsFloat:= high_value;
             FDTab.FieldByName('low').AsFloat:= low_value;
             FDTab.FieldByName('volume').AsFloat:= volume;
             FDTab.FieldByName('quoteVolume').AsFloat:= quoteVolume;
             FDTab.FieldByName('percentChange').AsFloat:= percentChange;
             if date_update > 0 then
             FDTab.FieldByName('updatedAt').AsDateTime:= date_update;

             FDTab.Post;
          end;
          FDTab.Connection.Commit;
        end;
    finally
     fdtab.EnableControls;
     JSONValue.Free;
    end;

    skey_change:= true;
    FindKeyRow;
    cxGrid1DBTableView1.Controller.TopRecordIndex:= x;
  end;
end;

end.
