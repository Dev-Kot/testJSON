unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  System.JSON, System.iniFiles, System.ioutils, System.Generics.Collections,
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
  FireDAC.Comp.BatchMove.Text, FireDAC.Stan.StorageJSON;

type
  TfrMain = class(TForm)
    IdHTTP1: TIdHTTP;
    Label1: TLabel;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    FDConn: TFDConnection;
    Panel1: TPanel;
    edURL: TEdit;
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
    Button3: TButton;
    Button4: TButton;
    Timer1: TTimer;
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
    btnRefresh: TButton;
    cxGrid1DBTableView1Column8: TcxGridDBColumn;
    FDQ: TFDQuery;
    cxGrid1DBTableView1Column9: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    var
      fmt: TFormatSettings;
      IniFile: TIniFile;
      x: integer; //положение строки грида относительно грида
      skey: string; //ключ фокусной строки
      skey_index: integer;
      is_group_key: boolean; //если строка явялется группировкой
      ListGroupRows: TList<integer>; //содержит список развернутых строк
    const
      FIniFile = 'Settings.ini';
    procedure SaveProp;
    procedure LoadProp;
    function GetItemIndexColumnKey: integer;
    procedure GetKeyRow;
    procedure FindKeyRow();
    procedure LoadGroupRowsExpand;
    procedure SaveGroupRowsExpand;

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

procedure TfrMain.Button3Click(Sender: TObject);
begin
  x := cxGrid1DBTableView1.Controller.TopRecordIndex;
  GetKeyRow;
  SaveGroupRowsExpand;
  cxGrid1DBTableView1.StoreToIniFile(GetCurrentDir + '\grid_settings.ini');
  SaveProp;
end;

procedure TfrMain.Button4Click(Sender: TObject);
begin
  cxGrid1DBTableView1.RestoreFromIniFile(GetCurrentDir + '\grid_settings.ini');
  LoadProp;
  LoadGroupRowsExpand;
  FindKeyRow;
  cxGrid1DBTableView1.Controller.TopRecordIndex:= x;
end;

procedure TfrMain.btnRefreshClick(Sender: TObject);
begin
  FDQ.DisableControls;
  try
    x := cxGrid1DBTableView1.Controller.TopRecordIndex;
    GetKeyRow;
    SaveGroupRowsExpand;
    FDQ.Active:= false;
    FDQ.Active:= true;
  finally
    FDQ.EnableControls;
  end;
  LoadGroupRowsExpand;
  FindKeyRow;
  cxGrid1DBTableView1.Controller.TopRecordIndex:= x;
end;

procedure TfrMain.btnStartClick(Sender: TObject);
begin
  btnStart.Enabled:= False;
  btnStop.Enabled:= True;
  Timer1.Enabled:= True;
end;

procedure TfrMain.FindKeyRow();
var
  i, ii: integer;
begin
  if not (skey = EmptyStr) then
  begin

    ii:= GetItemIndexColumnKey;
    cxGrid1DBTableView1.Controller.ClearSelection;

    if is_group_key then
    begin
      cxGrid1DBTableView1.Controller.FocusedRowIndex:= skey_index;
    end
    else
    begin
      for i := 0 to cxGrid1DBTableView1.DataController.RecordCount-1 do
      begin
        if (cxGrid1DBTableView1.DataController.Values[i,ii] = skey) then
        begin
          cxGrid1DBTableView1.Controller.FocusedRowIndex:= cxGrid1DBTableView1.DataController.GetRowIndexByRecordIndex(i, True);;
          cxGrid1.SetFocus;
          break;
        end;
      end;
    end;

  end;
end;

procedure TfrMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ListGroupRows.Free;
end;

procedure TfrMain.FormCreate(Sender: TObject);
begin
  IdHTTP1.ReadTimeout:= 10000; //при превышении 10 секунд запрос прерывается с ошибкой
  skey:= '';
  ListGroupRows:= TList<integer>.Create;
end;

procedure TfrMain.FormShow(Sender: TObject);
begin
  FDConn.Params.Database:= GetCurrentDir + '\testJSON.db';
  try
    FDConn.Connected:= True;
    FDQ.Active:= True;
  except
    on E: Exception do begin
      ShowMessage('Не удалось подключиться к БД: ' + #13#10 + E.Message);
      Close;
    end;
  end;

  fmt:= TFormatSettings.Create;
  fmt.DateSeparator:= '-';
  fmt.TimeSeparator:= ':';
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

procedure TfrMain.GetKeyRow;
var
  r: integer;
begin
  if cxGrid1DBTableView1.Controller.FocusedRow.IsData then
  begin
    //если строка не является группировкой
    is_group_key:= False;
    skey:= cxGrid1DBTableView1.Controller.FocusedRow.Values[GetItemIndexColumnKey];
  end
  else
  begin
    is_group_key:= True;
    skey_index:= cxGrid1DBTableView1.Controller.FocusedRow.Index;
  end;
end;

procedure TfrMain.LoadGroupRowsExpand;
var
  i: integer;
begin
    for i := 0 to ListGroupRows.Count-1 do
    begin
      cxGrid1DBTableView1.ViewData.Records[ListGroupRows.Items[i]].Expand(False);
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

procedure TfrMain.SaveGroupRowsExpand;
var
  i: integer;
begin
  ListGroupRows.Clear;
  for i := 0 to cxGrid1DBTableView1.ViewData.RowCount-1 do
  begin
    if cxGrid1DBTableView1.ViewData.Records[i].Expanded then
    ListGroupRows.Add(i);
  end;
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

begin
  btnRefresh.Enabled:= False;
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
//    skey:= cxGrid1DBTableView1.Controller.FocusedRow.Values[GetItemIndexColumnKey];
    GetKeyRow;
    x := cxGrid1DBTableView1.Controller.TopRecordIndex;
    FDQ.DisableControls;
    try
        if JSONValue is TJSONArray then begin
          FDQ.Edit;
          for jv in TJSONArray(JSONValue) do begin
            FDQ.Insert;

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

             FDQ.FieldByName('symbol').AsString:= symbol;
             FDQ.FieldByName('high').AsFloat:= high_value;
             FDQ.FieldByName('low').AsFloat:= low_value;
             FDQ.FieldByName('volume').AsFloat:= volume;
             FDQ.FieldByName('quoteVolume').AsFloat:= quoteVolume;
             FDQ.FieldByName('percentChange').AsFloat:= percentChange;
             if date_update > 0 then
             FDQ.FieldByName('updatedAt').AsDateTime:= date_update;

             FDQ.Post;
          end;
          FDQ.Connection.Commit;
          FDQ.Refresh;
        end;
    finally
     FDQ.EnableControls;
     JSONValue.Free;
    end;

    cxGrid1DBTableView1.Controller.TopRecordIndex:= x;
    FindKeyRow;
    btnRefresh.Enabled:= True;
  end;
end;

end.
