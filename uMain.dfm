object frMain: TfrMain
  Left = 0
  Top = 0
  Caption = 'frMain'
  ClientHeight = 486
  ClientWidth = 973
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
    Width = 973
    Height = 113
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 1010
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
    object edURL: TEdit
      Left = 33
      Top = 8
      Width = 400
      Height = 21
      TabOrder = 0
      Text = 'https://api.bittrex.com/v3/markets/summaries'
    end
    object Button3: TButton
      Left = 8
      Top = 80
      Width = 121
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1085#1072#1089#1090#1088#1086#1081#1082#1080
      TabOrder = 1
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 144
      Top = 80
      Width = 129
      Height = 25
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1085#1072#1089#1090#1088#1086#1081#1082#1080
      TabOrder = 2
      OnClick = Button4Click
    end
    object btnStart: TButton
      Left = 439
      Top = 6
      Width = 75
      Height = 25
      Caption = #1057#1090#1072#1088#1090
      TabOrder = 3
      OnClick = btnStartClick
    end
    object btnStop: TButton
      Left = 520
      Top = 6
      Width = 75
      Height = 25
      Caption = #1057#1090#1086#1087
      Enabled = False
      TabOrder = 4
      OnClick = btnStopClick
    end
    object edUser: TEdit
      Left = 86
      Top = 45
      Width = 84
      Height = 21
      TabOrder = 5
    end
    object edPass: TEdit
      Left = 220
      Top = 45
      Width = 100
      Height = 21
      PasswordChar = '*'
      TabOrder = 6
    end
    object edIP: TEdit
      Left = 348
      Top = 45
      Width = 121
      Height = 21
      TabOrder = 7
    end
    object edPort: TEdit
      Left = 511
      Top = 45
      Width = 62
      Height = 21
      NumbersOnly = True
      TabOrder = 8
    end
    object Button5: TButton
      Left = 880
      Top = 6
      Width = 75
      Height = 25
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      TabOrder = 9
      OnClick = Button5Click
    end
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 113
    Width = 973
    Height = 373
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 1010
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
      object cxGrid1DBTableView1Column9: TcxGridDBColumn
        DataBinding.FieldName = 'symbol'
        Visible = False
      end
      object cxGrid1DBTableView1Column1: TcxGridDBColumn
        DataBinding.FieldName = 'symbol1'
        Width = 72
      end
      object cxGrid1DBTableView1Column8: TcxGridDBColumn
        DataBinding.FieldName = 'symbol2'
        Width = 75
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
    Left = 128
    Top = 304
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
    Left = 128
    Top = 360
  end
  object FDConn: TFDConnection
    Params.Strings = (
      'Database=C:\Projects\TestJSON\Win32\Debug\testJSON.db'
      'DriverID=SQLite')
    Left = 736
    Top = 192
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = FDTab
    Left = 600
    Top = 352
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = Timer1Timer
    Left = 608
    Top = 64
  end
  object FDTab: TFDQuery
    Connection = FDConn
    SQL.Strings = (
      
        'select A.rowid, A.*, substr(A.symbol, 1, pos-1) symbol1, substr(' +
        'A.symbol, pos+1, l) symbol2  '
      'from '
      '(SELECT t.*, instr(t.symbol, '#39'-'#39') pos, length(t.symbol) l'
      '       '
      '  FROM summaries t) A')
    Left = 304
    Top = 240
  end
end
