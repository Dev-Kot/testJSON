object frMain: TfrMain
  Left = 0
  Top = 0
  Caption = 'frMain'
  ClientHeight = 486
  ClientWidth = 1010
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 11
    Width = 19
    Height = 13
    Caption = 'URL'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1010
    Height = 113
    Align = alTop
    TabOrder = 0
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 72
      Height = 13
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
    end
    object Label3: TLabel
      Left = 177
      Top = 48
      Width = 37
      Height = 13
      Caption = #1055#1072#1088#1086#1083#1100
    end
    object Label4: TLabel
      Left = 332
      Top = 48
      Width = 10
      Height = 13
      Caption = 'IP'
    end
    object Label5: TLabel
      Left = 480
      Top = 48
      Width = 25
      Height = 13
      Caption = #1055#1086#1088#1090
    end
    object Button1: TButton
      Left = 639
      Top = 6
      Width = 75
      Height = 25
      Caption = #1047#1072#1087#1088#1086#1089
      TabOrder = 0
      OnClick = Button1Click
    end
    object edURL: TEdit
      Left = 33
      Top = 8
      Width = 400
      Height = 21
      TabOrder = 1
      Text = 'https://api.bittrex.com/v3/markets/summaries'
    end
    object Button2: TButton
      Left = 720
      Top = 6
      Width = 75
      Height = 25
      Caption = #1060#1072#1081#1083
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 8
      Top = 80
      Width = 121
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1085#1072#1089#1090#1088#1086#1081#1082#1080
      TabOrder = 3
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 144
      Top = 80
      Width = 129
      Height = 25
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1085#1072#1089#1090#1088#1086#1081#1082#1080
      TabOrder = 4
      OnClick = Button4Click
    end
    object btnStart: TButton
      Left = 439
      Top = 6
      Width = 75
      Height = 25
      Caption = #1057#1090#1072#1088#1090
      TabOrder = 5
      OnClick = btnStartClick
    end
    object btnStop: TButton
      Left = 520
      Top = 6
      Width = 75
      Height = 25
      Caption = #1057#1090#1086#1087
      Enabled = False
      TabOrder = 6
      OnClick = btnStopClick
    end
    object edUser: TEdit
      Left = 86
      Top = 45
      Width = 84
      Height = 21
      TabOrder = 7
    end
    object edPass: TEdit
      Left = 220
      Top = 45
      Width = 100
      Height = 21
      PasswordChar = '*'
      TabOrder = 8
    end
    object edIP: TEdit
      Left = 348
      Top = 45
      Width = 121
      Height = 21
      TabOrder = 9
    end
    object edPort: TEdit
      Left = 511
      Top = 45
      Width = 62
      Height = 21
      NumbersOnly = True
      TabOrder = 10
    end
    object Button5: TButton
      Left = 896
      Top = 6
      Width = 75
      Height = 25
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      TabOrder = 11
      OnClick = Button5Click
    end
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 113
    Width = 1010
    Height = 373
    Align = alClient
    TabOrder = 1
    ExplicitTop = 89
    ExplicitHeight = 397
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnFocusedRecordChanged = cxGrid1DBTableView1FocusedRecordChanged
      DataController.DataSource = DataSource1
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      object cxGrid1DBTableView1Column1: TcxGridDBColumn
        DataBinding.FieldName = 'symbol'
        Width = 139
      end
      object cxGrid1DBTableView1Column2: TcxGridDBColumn
        DataBinding.FieldName = 'high'
        Width = 135
      end
      object cxGrid1DBTableView1Column3: TcxGridDBColumn
        DataBinding.FieldName = 'low'
        Width = 101
      end
      object cxGrid1DBTableView1Column4: TcxGridDBColumn
        DataBinding.FieldName = 'volume'
        Width = 131
      end
      object cxGrid1DBTableView1Column5: TcxGridDBColumn
        DataBinding.FieldName = 'quoteVolume'
        Width = 143
      end
      object cxGrid1DBTableView1Column6: TcxGridDBColumn
        DataBinding.FieldName = 'percentChange'
        Width = 121
      end
      object cxGrid1DBTableView1Column7: TcxGridDBColumn
        DataBinding.FieldName = 'updatedAt'
        Width = 172
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object IdHTTP1: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    AllowCookies = True
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 672
    Top = 48
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Method = sslvSSLv23
    SSLOptions.SSLVersions = [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2]
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 792
    Top = 88
  end
  object FDConn: TFDConnection
    Params.Strings = (
      'Database=C:\Projects\TestJSON\Win32\Debug\testJSON.db'
      'DriverID=SQLite')
    Left = 832
    Top = 216
  end
  object OpenDialog1: TOpenDialog
    Left = 592
    Top = 96
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = FDTab
    Left = 528
    Top = 80
  end
  object FDTab: TFDTable
    Connection = FDConn
    UpdateOptions.UpdateTableName = 'summaries'
    Exclusive = True
    TableName = 'summaries'
    Left = 736
    Top = 56
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = Timer1Timer
    Left = 176
    Top = 240
  end
  object IniPropStorageManEh1: TIniPropStorageManEh
    IniFileName = 'settings.ini'
    Left = 288
    Top = 200
  end
  object PropStorageEh1: TPropStorageEh
    Active = False
    StorageManager = IniPropStorageManEh1
    StoredProps.Strings = (
      '<P>.Height'
      '<P>.Left'
      '<P>.PixelsPerInch'
      '<P>.Top'
      '<P>.Width'
      '<P>.WindowState'
      'cxGrid1.cxGrid1DBTableView1.<P>.Preview.Column'
      
        'cxGrid1.cxGrid1DBTableView1.cxGrid1DBTableView1Column1.<P>.Group' +
        'Index'
      'cxGrid1.cxGrid1DBTableView1.cxGrid1DBTableView1Column1.<P>.Width'
      'cxGrid1.cxGrid1DBTableView1.cxGrid1DBTableView1Column2.<P>.Width'
      'cxGrid1.cxGrid1DBTableView1.cxGrid1DBTableView1Column3.<P>.Width'
      
        'cxGrid1.cxGrid1DBTableView1.cxGrid1DBTableView1Column4.<P>.Group' +
        'Index'
      'cxGrid1.cxGrid1DBTableView1.cxGrid1DBTableView1Column4.<P>.Width'
      
        'cxGrid1.cxGrid1DBTableView1.cxGrid1DBTableView1Column5.<P>.Group' +
        'Index'
      'cxGrid1.cxGrid1DBTableView1.cxGrid1DBTableView1Column5.<P>.Width'
      
        'cxGrid1.cxGrid1DBTableView1.cxGrid1DBTableView1Column6.<P>.Group' +
        'Index'
      'cxGrid1.cxGrid1DBTableView1.cxGrid1DBTableView1Column6.<P>.Width'
      
        'cxGrid1.cxGrid1DBTableView1.cxGrid1DBTableView1Column7.<P>.Group' +
        'Index'
      'cxGrid1.cxGrid1DBTableView1.cxGrid1DBTableView1Column7.<P>.Width')
    Left = 392
    Top = 232
  end
end
