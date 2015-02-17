unit lazExt_aBTF_ObjectInspector;

{$mode objfpc}{$H+}

interface

{$I in0k_lazExt_aBTF_ObjectInspector_INI.inc}

{%region --- setUp INLINE SETTINGs for Compile     ---------------- /fold}
{$undef _lazExt_aBTF_CodeExplorer_API_001_}
{$undef _lazExt_aBTF_CodeExplorer_API_002_}
{$undef _lazExt_aBTF_CodeExplorer_API_003_}
{$undef _lazExt_aBTF_CodeExplorer_API_004_}
{$undef _lazExt_aBTF_CodeExplorer_API_005_}
//----
{$ifDef lazExt_aBTF_CodeExplorer_Auto_SHOW}
    {$define _lazExt_aBTF_CodeExplorer_API_001_}
{$endif}
{$ifDef lazExt_aBTF_CodeExplorer_WinAPI_mode}
    //---- под Виндой
    {$undef  _lazExt_aBTF_CodeExplorer_API_002_}
    {$define _lazExt_aBTF_CodeExplorer_API_003_}
    {$ifdef lazExt_aBTF_CodeExplorer_cacheCodeExplorer}
    {$define _lazExt_aBTF_CodeExplorer_API_004_}
    {$endif}
    {$define _lazExt_aBTF_CodeExplorer_API_005_}
{$else}
    //---- стандартный (через IDE Lazarus) метод работы
    {$define _lazExt_aBTF_CodeExplorer_API_002_}
    {$define _lazExt_aBTF_CodeExplorer_API_001_}
{$endif}
{$ifDef lazExt_aBTF_ObjectInspector_EventLOG_mode}
    {$define _EventLOG_}
{$else}
    {$undef  _EventLOG_}
{$endIf}
{$define _INLINE_}
{%endRegion}
{%region --- Hint about Global SETTINGs on Compile ---------------- /fold}
{$hint 'SETTINGs info: ---------------------------->>>'}
{$ifDef lazExt_aBTF_ObjectInspector_EventLOG_mode}
    {$hint 'lazExt_aBTF_ObjectInspector_EventLOG_mode On'}
{$else}
    {$hint 'lazExt_aBTF_ObjectInspector_EventLOG_mode OFF'}
{$endif}
{$ifDef lazExt_aBTF_CodeExplorer_Auto_SHOW}
    {$hint 'lazExt_aBTF_CodeExplorer_Auto_SHOW On'}
{$else}
    {$hint 'lazExt_aBTF_CodeExplorer_Auto_SHOW OFF'}
{$endif}
{$ifDef lazExt_aBTF_CodeExplorer_WinAPI_mode}
    {$hint 'lazExt_aBTF_CodeExplorer_WinAPI_mode On'}
{$else}
    {$hint 'lazExt_aBTF_CodeExplorer_WinAPI_mode OFF'}
{$endif}
{$ifDef lazExt_aBTF_CodeExplorer_cacheCodeExplorer}
    {$hint 'lazExt_aBTF_CodeExplorer_cacheCodeExplorer On'}
{$else}
    {$hint 'lazExt_aBTF_CodeExplorer_cacheCodeExplorer OFF'}
{$endif}
{$hint '<<<---------------------------------------->>>'}
{%endRegion}


{$undef _lazExt_aBTF_CodeExplorer_API_002_}
{$undef _lazExt_aBTF_CodeExplorer_API_003_}
{$undef _lazExt_aBTF_CodeExplorer_API_004_}
{$undef _lazExt_aBTF_CodeExplorer_API_005_}

{$define _lazExt_aBTF_CodeExplorer_API_003_}
{.$define _lazExt_aBTF_CodeExplorer_API_004_}
{$define _lazExt_aBTF_CodeExplorer_API_005_}

uses {$ifDEF lazExt_aBTF_ObjectInspector_EventLOG_mode}
        sysutils, Dialogs, lazExt_aBTF_ObjectInspector_DEBUG,
     {$endIf}
     {$ifDEF _lazExt_aBTF_CodeExplorer_API_003_}
        windows, Controls,
     {$endIf}  ObjectInspector,
     SrcEditorIntf, IDECommands, MenuIntf,  FormEditingIntf,
     LCLType, PropEdits, ProjectIntf, LazIDEIntf, ComponentEditors,
     Classes, Forms;

type

 tLazExt_aBTF_ObjectInspector=class
  {%region --- CodeExplorer Window ToggleFormUnit --------------------- /fold}
  {$ifDef _lazExt_aBTF_CodeExplorer_API_001_}
  strict private
   _IDECommand_TFU_:TIDECommand; //< это комманда для открытия
   _IDECommand_TFU_OnExecuteMethod_original:TNotifyEvent;    //< его событие
    procedure _TFU_OnExecuteMethod_myCustom(Sender:TObject); //< моя подстава
    procedure _TFU_rePlace_OnExecuteMethod(const ideCommand:TIDECommand);
    procedure _TFU_reStore_OnExecuteMethod(const ideCommand:TIDECommand);
  private
    procedure _TFU_rePLACE;
  {$endIf}
  {%endRegion}
  {%region --- Active SourceEditorWindow -------------------------- /fold}
  protected
   _ide_Window_SEW_:TSourceEditorWindowInterface; //< текущee АКТИВНОЕ окно редактирования
   _ide_Window_SEW_onDeactivate_original:TNotifyEvent;    //< его событие
    procedure _SEW_onDeactivate_myCustom(Sender:TObject); //< моя подстава
    procedure _SEW_rePlace_onDeactivate(const wnd:tForm);
    procedure _SEW_reStore_onDeactivate(const wnd:tForm);
  private
    procedure _SEW_SET(const wnd:TSourceEditorWindowInterface);
  {%endRegion}
  {%region --- ВСЯ СУТь ------------------------------------------- /fold}
  protected
    function _do_BTF_ObjectInspector_:boolean;
  protected
    {$ifDef _lazExt_aBTF_CodeExplorer_API_002_}
    function _do_BTF_CodeExplorer_do_wndCE_OPN:boolean;
    function _do_BTF_CodeExplorer_do_wndSE_BTF:boolean;
    function _do_BTF_CodeExplorer_use_ideLaz:boolean; {$ifDEF _INLINE_}inline;{$endIf}
    {$endIf}
    {$ifDef _lazExt_aBTF_CodeExplorer_API_003_}
    function _do_BTF_ObjectInspector_use_winAPI:boolean; {$ifDEF _INLINE_}inline;{$endIf}
    {$endIf}
  {%endRegion}
  {%region --- ide_Window_CEV : API_004 --------------------------- /fold}
  {$ifDef _lazExt_aBTF_CodeExplorer_API_004_}
  strict private
   _ide_Window_OIV_:tForm;                        //< найденное окно
   _ide_Window_OIV_onClose_original_:TCloseEvent; //< его событие при выходе
    procedure _OIV_onClose_myCustom_(Sender:TObject; var CloseAction:TCloseAction);
    procedure _OIV_rePlace_onClose(const wnd:tForm);
    procedure _OIV_reStore_onClose(const wnd:tForm);
  private
    procedure _CEV_SET_(const wnd:tForm);
  {$endIf}
  {%endRegion}
  {%region --- ide_Window_CEV : API_005 --------------------------- /fold}
  {$ifDef _lazExt_aBTF_CodeExplorer_API_005_}
  strict private
    function  _OIV_find_inSCREEN_:TForm;
    function  _OIV_find_:TForm;
  private
    function  _OIV_GET:TForm;
  {$endIf}
  {%endRegion}
  {%region --- IdeEVENT ------------------------------------------- /fold}
  strict private //< обработка событий
   _ideEvent_Editor_:TSourceEditorInterface;
    procedure _ideEvent_exeEvent_;
    procedure _ideEvent_semEditorActivate(Sender:TObject);
    procedure _ideEvent_semWindowFocused (Sender:TObject);
  strict private //< регистрация событий
    procedure _ideEvent_register_;
  {%endRegion}

  protected
    procedure myFNC;
  protected
  // _ideMenu_TFUV_:TIDEMenuCommand;
   _ideMenuITM_TFUV_onClick_original_:TNotifyEvent;
    procedure _TFUV_onClick_myCustom_(Sender:TObject); //< моя подстава
    procedure _TFUV_onClick_rePlace(const ideMenuItem:TIDEMenuCommand);
  public
    //procedure _IDECommand_TFU_:TIDECommand; //< это комманда для открытия    (Sender: TObject)
    //procedure _aaaaaaaaa(Sender:TObject); //< моя подстава
    //function enumerate_menuItem:boolean;
    //function enumerate_menuItemITEM(const ideMenuITEM:TIDEMenuSection):boolean;
    function _ideMenu_find_inSection(const ideCommand:TIDECommand; ideMenuSection:TIDEMenuSection):TIDEMenuCommand;
    function _ideMenu_find_         (const ideCommand:TIDECommand):TIDEMenuCommand;
  public
    constructor Create;
    destructor DESTROY; override;
  public
    procedure _onRegister_ideMenuITM_TFUV;
  public
   _ide_Applctn_Lazarus_onActivate_original_:{pointer;//}TNotifyEvent;
    procedure  _Lazarus_onActivate_myCustom_(Sender:TObject);
  public
   _ide_Window_DSGNR_:TCustomForm;
   _ide_Window_DSGNR_onActivate_original_:{pointer;//}TNotifyEvent;
    procedure _DSGNR_onActivate_myCustom_(Sender:TObject);
    procedure _DSGNR_rePlace_onActivate_(const wnd:TCustomForm);
    procedure _DSGNR_reStore_onActivate_(const wnd:TCustomForm);
    procedure _DSGNR_SET_(const wnd:TCustomForm);
    //_ideWindow_DSGNR_onDeActivate_original_:TNotifyEvent;

    procedure _PropHookChangeLookupRoot_;
    procedure RegisterInIdeLAZARUS;
  end;

implementation

const //< тут возможно придется определять относительно ВЕРСИИ ЛАЗАРУСА
  _c_IDECommand_TFU_IdeCODE=ecToggleFormUnit;


procedure tLazExt_aBTF_ObjectInspector.myFNC;
begin
    {$ifDEF _EventLOG_}
    DEBUG('GOGOGO','----------------------------------------------------------');
    {$endIf}

   _do_BTF_ObjectInspector_;// _OIV_GET.BringToFront;


end;


{$ifDEF _EventLOG_}
const
   _cPleaseReport_=
        LineEnding+
        'EN: Please report this error to the developer.'+LineEnding+
        'RU: Пожалуйста, сообщите об этой ошибке разработчику.'+
        LineEnding;
{$endIf}

constructor tLazExt_aBTF_ObjectInspector.Create;
begin
    {$ifDef _lazExt_aBTF_CodeExplorer_API_001_}
   _IDECommand_TFU_:=NIL;
    {$endIf}
    {$ifDef _lazExt_aBTF_CodeExplorer_API_004_}
   _ide_Window_OIV_:=NIL;
    {$endIf}
    _ideMenuITM_TFUV_onClick_original_:=nil;
    _ide_Window_SEW_:=NIL;
    _ide_Window_DSGNR_:=nil;
    _ide_Window_DSGNR_onActivate_original_:=nil;
end;

destructor tLazExt_aBTF_ObjectInspector.DESTROY;
begin
    inherited;
end;

var CmdMyTool: TIDECommand;
var tmp:TIDECommand;
    cat:TIDECommandCategory;
    Key:TIDEShortCut;

procedure StartMyTool(Sender: TObject);
var t:TClass;
    s:string;
begin
(*  if Assigned(SourceEditorManagerIntf.ActiveSourceWindow)
  and SourceEditorManagerIntf.ActiveSourceWindow.Focused then begin
      //ShowMessage('ActiveSourceWindow');
  end;

  if Assigned(SourceEditorManagerIntf.ActiveEditor)  then begin
      //ShowMessage('ActiveEditor');
  end;
*)
   //Screen.ActiveForm;
  //tmp.Execute(nil);

  ShowMessage('ActiveEditor '+'OnExecute:'+addr2txt(@(tmp.OnExecute)));
  ShowMessage('ActiveEditor '+'OnExecuteProc:'+addr2txt(@(tmp.OnExecuteProc)));

(*    if Assigned(Screen.ActiveForm) and (not (Screen.ActiveForm is TSourceEditorWindowInterface)) then begin
        s:='';
        t:=Screen.ActiveForm.ClassParent;
        while Assigned(t) do begin
            s:=s+t.ClassName+#$0d#$0a;
            t:=t.ClassParent;
        end;
        ShowMessage('ActiveEditor '+Screen.ActiveForm.Caption+':'+Screen.ActiveForm.ClassName+#$0d#$0a+s);
    end;
*)
end;

{procedure tLazExt_aBTF_ObjectInspector._aaaaaaaaa(Sender:TObject); //< моя подстава
begin
    ShowMessage('sdfgds fgs df');
end; }


procedure tLazExt_aBTF_ObjectInspector._onRegister_ideMenuITM_TFUV;
var tmp:TIDECommand;
    tmq:TIDEMenuCommand;
begin
    tmp:=IDECommandList.FindIDECommand(_c_IDECommand_TFU_IdeCODE);
    if Assigned(tmp) then begin
        tmq:=_ideMenu_find_(tmp);
        if Assigned(tmq) then begin
           _TFUV_onClick_rePlace(tmq);
        end;
    end;
end;

procedure tLazExt_aBTF_ObjectInspector._PropHookChangeLookupRoot_;
var tmp:TPersistent;
    wnd:TCustomForm;
begin
    tmp:= GlobalDesignHook.LookupRoot;
    if Assigned(tmp) then begin
        wnd:=FormEditingHook.GetDesignerForm(tmp);
        if Assigned(wnd) then begin
           //ShowMessage('qw' + wnd.Caption);
          _DSGNR_SET_(wnd);
        end;

    end;
end;

procedure tLazExt_aBTF_ObjectInspector.RegisterInIdeLAZARUS;
begin
   // _TFU_rePLACE;
   //_ideEvent_register_;
   // _onRegister_ideMenuITM_TFUV;

     GlobalDesignHook.AddHandlerChangeLookupRoot(@_PropHookChangeLookupRoot_);

    _ide_Applctn_Lazarus_onActivate_original_:=Application.OnActivate;
     Application.OnActivate:=@_Lazarus_onActivate_myCustom_;

    // FormEditingHook.

     //es
    (*

    if _IDECommand_TFU_present_ then begin
        Key := IDEShortCut(VK_F12,[],VK_UNKNOWN,[]);
        CmdMyTool:=RegisterIDECommand(_IDECommand_TFU_.Category,_IDECommand_TFU_.LocalizedName,_IDECommand_TFU_.Name, Key, @_aaaaaaaaa, @StartMyTool);
        tmp:=_IDECommand_TFU_;
        //-------
       //_IDECommand_TFU_.ClearShortcutA;
       //_IDECommand_TFU_.ClearShortcutB;
       // ShowMessage('ActiveEditor '+'OnExecute:'+addr2txt(_IDECommand_TFU_.OnExecute));
       // ShowMessage('ActiveEditor '+'OnExecuteProc:'+addr2txt(_IDECommand_TFU_.OnExecuteProc)););
    end;


//   _IDECommand_TFU_FIND_;
//    tmp:=IDECommandList.FindIDECommand(ecToggleFormUnit);
//    tmp.ClearShortcutA;
//    tmp.ClearShortcutB;
   //_ideEvent_register_;
    //Cat:=IDECommandList.FindCategoryByName(CommandCategoryViewName{CommandCategoryToolMenuName});

    RegisterIDEMenuCommand(mnuView{itmSecondaryTools}, CmdMyTool.LocalizedName, CmdMyTool.LocalizedName, nil, nil, CmdMyTool);

    *)
end;

{%region --- CodeExplorer Window IDECommand ----------------------- /fold}

{todo: план развития
    - НАЙТИ способ ПРЯМОГО обращения к окну, что лежит в переменной
      $(LazarusDir)/ide/codeexplorer.pas->CodeExplorerView:TCodeExplorerView
    - написать заявку на добавление в IDEIntf или самому сделать правку
}

{$ifDef _lazExt_aBTF_CodeExplorer_API_001_}

{info: жестко спрятанное Окно.
    присутствует ТОЛЬКО в исходниках `$(LazarusDir)/ide/codeexplorer.pas`
    единтсвенный способ достучаться до него нашёл только через комманду IDE.
    это конечноже через ЗАДНИЦА.
}

                          //  itmViewToggleFormUnit
procedure tLazExt_aBTF_ObjectInspector._TFU_rePLACE;
begin
   _IDECommand_TFU_:=IDECommandList.FindIDECommand(_c_IDECommand_TFU_IdeCODE);
   _TFU_rePlace_OnExecuteMethod(_IDECommand_TFU_);
    {$ifDEF _EventLOG_}
    if Assigned(_IDECommand_TFU_)
    then DEBUG('OK','IDECommand_TFU "ToggleFormUnit" FOUND'+addr2txt(pointer(_IDECommand_TFU_)))
    else DEBUG('ER','IDECommand_TFU "ToggleFormUnit" NOT found')
    {$endIf}
end;

//------------------------------------------------------------------------------

// ЗАМЕНЯЕМ `OnExecuteMethod` на собственное
procedure tLazExt_aBTF_ObjectInspector._TFU_rePlace_OnExecuteMethod(const ideCommand:TIDECommand);
var p:pointer;
begin
    if Assigned(ideCommand) and (ideCommand.OnExecute<>@_SEW_onDeactivate_myCustom) then begin
        {$ifDEF _EventLOG_}
        p:=@(ideCommand.OnExecute);
        DEBUG('befo','ideCommand.OnExecute'+addr2txt(pointer(p^)));
        p:=@(ideCommand.OnExecuteProc);
        DEBUG('befo','ideCommand.OnExecuteProc'+addr2txt(pointer(p^)));
        {$endIf}
       _IDECommand_TFU_OnExecuteMethod_original:=ideCommand.OnExecute;
        ideCommand.OnExecute:=@_TFU_OnExecuteMethod_myCustom;
        {$ifDEF _EventLOG_}
        DEBUG('_TFU_rePlace_OnExecuteMethod','rePALCE ideCommand'+addr2txt(ideCommand));
        //ShowMessage(addr2txt(Addr(_IDECommand_TFU_OnExecuteMethod_original)));
        p:=@(ideCommand.OnExecute);
        DEBUG('afte','ideCommand.OnExecute'+addr2txt(pointer(p^)));
        p:=@(ideCommand.OnExecuteProc);
        DEBUG('afte','ideCommand.OnExecuteProc'+addr2txt(pointer(p^)));
        {$endIf}
    end
    else begin
        {$ifDEF _EventLOG_}
        DEBUG('_TFU_rePlace_OnExecuteMethod','SKIP ideCommand'+addr2txt(ideCommand));
        {$endIf}
    end
end;

// ВОСТАНАВЛИВАЕМ `OnExecuteMethod` на то что было
procedure tLazExt_aBTF_ObjectInspector._TFU_reStore_OnExecuteMethod(const ideCommand:TIDECommand);
begin
    if Assigned(ideCommand) and (ideCommand.OnExecute=@_SEW_onDeactivate_myCustom) then begin
        ideCommand.OnExecute:=_ide_Window_SEW_onDeactivate_original;
       _IDECommand_TFU_OnExecuteMethod_original:=NIL;
        {$ifDEF _EventLOG_}
        DEBUG('_TFU_reStore_OnExecuteMethod','ideCommand'+addr2txt(ideCommand));
        {$endIf}
    end
    else begin
        {$ifDEF _EventLOG_}
        DEBUG('_TFU_reStore_OnExecuteMethod','SKIP ideCommand'+addr2txt(ideCommand));
        {$endIf}
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

{function tLazExt_aBTF_ObjectInspector._IDECommand_TFU_present_:boolean;
begin
    result:=Assigned(_IDECommand_TFU_);
    if not result then begin
       _IDECommand_TFU_FIND_;
        result:=Assigned(_IDECommand_TFU_);
    end;
end;}

{function tLazExt_aBTF_ObjectInspector._IDECommand_TFU_execute_:boolean;
begin
    if _IDECommand_TFU_present_ then begin
        result:=_IDECommand_TFU_.Execute(nil);
        {$ifDEF _EventLOG_}
        if result then DEBUG('OK','IDECommand_OpnCEV.execute')
                  else DEBUG('ER','IDECommand_OpnCEV.execute');
        {$endIf}
    end
end;}

procedure tLazExt_aBTF_ObjectInspector._TFU_OnExecuteMethod_myCustom(Sender:TObject); //< моя подстава
begin
    {$ifDEF _EventLOG_}
    DEBUG('GOGOGO');
    {$endIf}
    //if Assigned(_IDECommand_TFU_OnExecuteMethod_original) then begin
    // /  _IDECommand_TFU_OnExecuteMethod_original(Sender);
    //end;
    ShowMessage('GOGOGO');
end;



{$endIf}

{%endRegion}

{%region --- Active SourceEditorWindow ---------------------------- /fold}

{Идея: отловить момент "выхода" из окна редактирования.
    Используем "грязны" метод: аля "сабКлассинг", заменяем на СОБСТВЕННУЮ
    реализацию событие `onDeactivate`.
}

// НАШЕ событие, при `onDeactivate` ActiveSrcWND
procedure tLazExt_aBTF_ObjectInspector._SEW_onDeactivate_myCustom(Sender:TObject);
begin
    {$ifDEF _EventLOG_}
    DEBUG('_SEW_onDeactivate_myCustom','--->>> Sender'+addr2txt(Sender));
    {$endIf}

    // отмечаем что ВЫШЛИ из окна
   _ide_Window_SEW_:=NIL;
   _ideEvent_Editor_:=NIL;
    // восстановить событие `onDeactivate` на исходное, и выполнияем его
    if Assigned(Sender) then begin
        if Sender is TSourceEditorWindowInterface then begin
           _SEW_reStore_onDeactivate(tForm(Sender));
            with TSourceEditorWindowInterface(Sender) do begin
                if Assigned(OnDeactivate) then OnDeactivate(Sender);
                {$ifDEF _EventLOG_}
                DEBUG('OK','TSourceEditorWindowInterface('+addr2txt(sender)+').OnDeactivate executed');
                {$endIf}
            end;
        end
        else begin
            {$ifDEF _EventLOG_}
            DEBUG('ER','Sender is NOT TSourceEditorWindowInterface');
            {$endIf}
        end;
    end
    else begin
        {$ifDEF _EventLOG_}
        DEBUG('ER','Sender==NIL');
        {$endIf}
    end;

    {$ifDEF _EventLOG_}
    DEBUG('_SEW_onDeactivate_myCustom','---<<<');
    {$endIf}
end;

//------------------------------------------------------------------------------

// ЗАМЕНЯЕМ `onDeactivate` на собственное
procedure tLazExt_aBTF_ObjectInspector._SEW_rePlace_onDeactivate(const wnd:tForm);
begin
    if Assigned(wnd) and (wnd.OnDeactivate<>@_SEW_onDeactivate_myCustom) then begin
       _ide_Window_SEW_onDeactivate_original:=wnd.OnDeactivate;
        wnd.OnDeactivate:=@_SEW_onDeactivate_myCustom;
        {$ifDEF _EventLOG_}
        DEBUG('_SEW_rePlace_onDeactivate','rePALCE wnd'+addr2txt(wnd));
        {$endIf}
    end
    else begin
        {$ifDEF _EventLOG_}
        DEBUG('_SEW_rePlace_onDeactivate','SKIP wnd'+addr2txt(wnd));
        {$endIf}
    end
end;

// ВОСТАНАВЛИВАЕМ `onDeactivate` на то что было
procedure tLazExt_aBTF_ObjectInspector._SEW_reStore_onDeactivate(const wnd:tForm);
begin
    if Assigned(wnd) and (wnd.OnDeactivate=@_SEW_onDeactivate_myCustom) then begin
        wnd.OnDeactivate:=_ide_Window_SEW_onDeactivate_original;
       _ide_Window_SEW_onDeactivate_original:=NIL;
        {$ifDEF _EventLOG_}
        DEBUG('_SEW_reStore_onDeactivate','wnd'+addr2txt(wnd));
        {$endIf}
    end
    else begin
        {$ifDEF _EventLOG_}
        DEBUG('_SEW_reStore_onDeactivate','SKIP wnd'+addr2txt(wnd));
        {$endIf}
    end;
end;

//------------------------------------------------------------------------------

procedure tLazExt_aBTF_ObjectInspector._SEW_SET(const wnd:TSourceEditorWindowInterface);
begin
    if wnd<>_ide_Window_SEW_ then begin
        if Assigned(_ide_Window_SEW_)
        then begin
           _SEW_reStore_onDeactivate(_ide_Window_SEW_);
            {$ifDEF _EventLOG_}
            DEBUG('ERROR','_SEW_SET inline var _ide_Window_SEW_<>NIL');
            {$endIf}
        end;
       _SEW_rePlace_onDeactivate(wnd);
       _ide_Window_SEW_:=wnd;
    end;
end;

{%endRegion}

{%region --- ВСЯ СУТь --------------------------------------------- /fold}

{$ifDef _lazExt_aBTF_CodeExplorer_API_002_}
(*
// открыть и вытащить на передний план окно `CodeExplorerView`
function tLazExt_aBTF_ObjectInspector._do_BTF_CodeExplorer_do_wndCE_OPN:boolean;
begin
    result:=_IDECommand_TFU_present_ and _IDECommand_TFU_execute_;
end;

// переместить на передний план окно `ActiveSourceWindow`
function tLazExt_aBTF_ObjectInspector._do_BTF_CodeExplorer_do_wndSE_BTF:boolean;
var tmp:TSourceEditorWindowInterface;
begin
    tmp:=SourceEditorManagerIntf.ActiveSourceWindow;
    if Assigned(tmp) then begin
        tmp.BringToFront;
        result:=true;
        {$ifDEF _EventLOG_}
        DEBUG('ok','ActiveSourceWindow.BringToFront');
        {$endIf}
    end
    else begin
        result:=false;
        {$ifDEF _EventLOG_}
        DEBUG('er','ActiveSourceWindow.BringToFront');
        {$endIf}
    end;
end;
*)
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tLazExt_aBTF_ObjectInspector._do_BTF_CodeExplorer_use_ideLaz:boolean;
begin // Еники Беники, костыли и велики ...
    // вызываем окно `CodeExplorerView`, оно встанет на ПЕРЕДНИЙ план
    // потом на передний план перемещаем окно `ActiveSourceWindow`
    //---
    // все это приводит к излишним дерганиям и как-то через Ж.
   _SEW_reStore_onDeactivate(_ide_Window_SEW_);
    result:=_do_BTF_CodeExplorer_do_wndCE_OPN
            and
            _do_BTF_CodeExplorer_do_wndSE_BTF;
   _SEW_rePlace_onDeactivate(_ide_Window_SEW_);
end;

{$endIf}

//==============================================================================

{$ifDef _lazExt_aBTF_CodeExplorer_API_003_}

function tLazExt_aBTF_ObjectInspector._do_BTF_ObjectInspector_use_winAPI:boolean;
var dwp:HDWP;
    OIv:tForm;
    var i:integer;
begin
    OIv:=_OIV_GET;
    if Assigned(OIv) and Assigned(_ide_Window_DSGNR_) then begin

        {$ifDef lazExt_aBTF_ObjectInspector_Auto_SHOW}
        if not OIv.Visible then begin
           OIv.SendToBack;
           OIv.Visible:=true;
        end;
        {$endIf}


        if oiv.Parent=_ide_Window_DSGNR_.Parent then begin
           {$ifDEF _EventLOG_}
                   DEBUG('++++++++++','++++++++++++++++++++');
           {$endIf}
           i:=_ide_Window_DSGNR_.Parent.GetControlIndex(_ide_Window_DSGNR_);

           DEBUG('++++++++++',inttostr(i));


    //      _ide_Window_DSGNR_.Parent.SetControlIndex(OIv,i-1);
        end
        else begin
            dwp:=BeginDeferWindowPos(1);
            DeferWindowPos(dwp,OIv.Handle,_ide_Window_DSGNR_.Handle,0,0,0,0,SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
            result:=EndDeferWindowPos(dwp);
        end;

        if not OIv.Visible then begin
           {$ifDEF _EventLOG_}
                   DEBUG('--------','------------------');
           {$endIf}
        end;

    end
    else begin
        result:=false;
        {$ifDEF _EventLOG_}
        if not Assigned(_ide_Window_DSGNR_) then DEBUG('EVENT','_ide_Window_DSGNR_==nil');
        if not Assigned(OIv)                then DEBUG('EVENT','_ide_Window_OIV_==nil');
        {$endIf}
    end;
end;

{$endIf}

//==============================================================================

function tLazExt_aBTF_ObjectInspector._do_BTF_ObjectInspector_:boolean;
begin
    {$ifDef lazExt_aBTF_CodeExplorer_WinAPI_mode}
        result:=_do_BTF_ObjectInspector_use_winAPI;
    {$else} //< "стандартными" средствами IDE lazarus
    //    result:=_do_BTF_CodeExplorer_use_ideLaz;
    {$endIf}
    result:=_do_BTF_ObjectInspector_use_winAPI;
    {$ifDEF _EventLOG_}
    if result then DEBUG('BTF_ObjectInspector','OK')
              else DEBUG('BTF_ObjectInspector','ER');
    {$endIf}
end;

{%endRegion}

{%region --- ide_Window_CEV : API_004 ----------------------------- /fold}

{$ifDef _lazExt_aBTF_CodeExplorer_API_004_}

procedure tLazExt_aBTF_ObjectInspector._OIV_onClose_myCustom_(Sender:TObject; var CloseAction:TCloseAction);
begin
    {$ifDEF _EventLOG_}
    DEBUG('_OIV_onClose_myCustom_','--->>> Sender'+addr2txt(Sender));
    {$endIf}

    if Sender=_ide_Window_OIV_ then begin
        // отмечаем что ВЫШЛИ из окна
       _ide_Window_OIV_:=NIL;
        // восстановить событие `onDeactivate` на исходное, и выполнияем его
        if Assigned(Sender) then begin
            if Sender is TForm then begin
               _OIV_reStore_onClose(tForm(Sender));
                with tForm(Sender) do begin
                    if Assigned(OnClose) then OnClose(Sender,CloseAction);
                    {$ifDEF _EventLOG_}
                    DEBUG('OK','TForm('+addr2txt(sender)+').onClose executed');
                    {$endIf}
                end;
            end
            else begin
                {$ifDEF _EventLOG_}
                DEBUG('ER','Sender is NOT TForm');
                {$endIf}
            end;
        end
        else begin
            {$ifDEF _EventLOG_}
            DEBUG('ER','Sender==NIL');
            {$endIf}
        end;
    end
    else begin
        {$ifDEF _EventLOG_}
        DEBUG('ER','Sender<>_ide_Window_OIV_');
        {$endIf}
    end;

    {$ifDEF _EventLOG_}
    DEBUG('_OIV_onClose_myCustom_','---<<<');
    {$endIf}
end;

//------------------------------------------------------------------------------

procedure tLazExt_aBTF_ObjectInspector._OIV_rePlace_onClose(const wnd:tForm);
begin
    if Assigned(wnd) and (wnd.OnClose<>@_OIV_onClose_myCustom_) then begin
       _ide_Window_OIV_onClose_original_:=wnd.OnClose;
        wnd.OnClose:=@_OIV_onClose_myCustom_;
        {$ifDEF _EventLOG_}
        DEBUG('_OIV_rePlace_onClose','rePALCE wnd'+addr2txt(wnd));
        {$endIf}
    end
    else begin
        {$ifDEF _EventLOG_}
        DEBUG('_OIV_rePlace_onClose','SKIP wnd'+addr2txt(wnd));
        {$endIf}
    end
end;

procedure tLazExt_aBTF_ObjectInspector._OIV_reStore_onClose(const wnd:tForm);
begin
    if Assigned(wnd) and (wnd.OnClose=@_OIV_onClose_myCustom_) then begin
        wnd.OnClose:=_ide_Window_OIV_onClose_original_;
       _ide_Window_OIV_onClose_original_:=NIL;
        {$ifDEF _EventLOG_}
        DEBUG('_OIV_reStore_onClose','wnd'+addr2txt(wnd));
        {$endIf}
    end
    else begin
        {$ifDEF _EventLOG_}
        DEBUG('_OIV_reStore_onClose','SKIP wnd'+addr2txt(wnd));
        {$endIf}
    end;
end;

//------------------------------------------------------------------------------

procedure tLazExt_aBTF_ObjectInspector._CEV_SET_(const wnd:tForm);
begin
    if wnd<>_ide_Window_OIV_ then begin
        if Assigned(_ide_Window_OIV_)
        then begin
           _OIV_reStore_onClose(_ide_Window_OIV_);
            {$ifDEF _EventLOG_}
            DEBUG('ERROR','_CEV_SET_ inline var _ide_Window_OIV_==NIL');
            ShowMessage('_SEW_SET inline var _ide_Window_SEW_<>NIL'+_cPleaseReport_);
            {$endIf}
        end;
       _OIV_rePlace_onClose(wnd);
       _ide_Window_OIV_:=wnd;
    end;
end;

{$endIf}

{%endRegion}

{%region --- ide_Window_CEV : API_005 ----------------------------- /fold}

{$ifDef _lazExt_aBTF_CodeExplorer_API_005_}

const //< тут возможно придется определять относительно ВЕРСИИ ЛАЗАРУСА
  cWndOIV_className='TObjectInspectorDlg';

function tLazExt_aBTF_ObjectInspector._OIV_find_inSCREEN_:TForm;
var i:integer;
    f:TForm;
begin
    result:=nil;
    for i:=0 to Screen.FormCount-1 do begin
        f:=Screen.Forms[i];
        {$ifDEF _EventLOG_}
        DEBUG('_OIV_find_inSCREEN','Find in SCREEN '+f.ClassName);
        {$endIf}
        if f is TObjectInspectorDlg then begin
            result:=f;
            {$ifDEF _EventLOG_}
            DEBUG('_OIV_find_inSCREEN','FOUND '+cWndOIV_className+addr2txt(f));
            {$endIf}
            break;
        end;
    end;
end;


// исчем ЭКЗЕМПЛЯР окна
//  поиск по ИМЕНИ класса в хранилище открытых окон `Screen.Form`
function tLazExt_aBTF_ObjectInspector._OIV_find_:TForm;
begin
    {$ifDef _lazExt_aBTF_CodeExplorer_API_004_}
    if not Assigned(_ide_Window_OIV_) then begin
        result:=_OIV_find_inSCREEN;
       _CEV_SET_(result);
    end
    else begin
        result:=_ide_Window_OIV_;
    end;
    {$else}
    result:=_OIV_find_inSCREEN_;
    {$endIf}
end;

//------------------------------------------------------------------------------

function tLazExt_aBTF_ObjectInspector._OIV_GET:TForm;
begin
    result:=_OIV_find_;
    {$ifDef lazExt_aBTF_CodeExplorer_Auto_SHOW}
    if (not Assigned(result))or(not result.Visible) then begin
        {$ifDEF _EventLOG_}
        DEBUG('CEV','NOT FOUND, mast by CREATE');
        {$endIf}
        // вызываем окно `CodeExplorerView`, оно встанет на ПЕРЕДНИЙ план
        // все это приводит к излишним дерганиям и как-то через Ж.
       _SEW_reStore_onDeactivate(_ide_Window_SEW_);
       _IDECommand_TFU_execute_;
       _SEW_rePlace_onDeactivate(_ide_Window_SEW_);
        // теперь сного его поисчем
        result:=_OIV_find_;
        {$ifDEF _EventLOG_}
        if not Assigned(result) then begin
            DEBUG('CEV','NOT FOUND !!! BIG ERROR: possible name "'+cWndOIV_className+'" is WRONG');
            ShowMessage('_OIV_GET:NOT FOUND !!! BIG ERROR: possible name "'+cWndOIV_className+'" is WRONG'+_cPleaseReport_);
        end;
        {$endIf}
    end;
    {$endIf}
end;

{$endIf}

{%endRegion}

{%region --- IdeEVENT semEditorActivate --------------------------- /fold}

// основное рабочее событие
procedure tLazExt_aBTF_ObjectInspector._ideEvent_exeEvent_;
var tmpSourceEditor:TSourceEditorInterface;
begin
    {*1> причины использования _ideEvent_Editor_
        механизм с приходится использовать из-за того, что
        при переключение "Вкладок Редактора Исходного Кода" вызов данного
        события происходит аж 3(три) раза. Используем только ПЕРВЫЙ вход.
        -----
        еще это событие происходит КОГДА идет навигация (прыжки по файлу)
    }
    if Assigned(SourceEditorManagerIntf) then begin //< запредельной толщины презерватив
        tmpSourceEditor:=SourceEditorManagerIntf.ActiveEditor;
        if Assigned(tmpSourceEditor) then begin //< чуть потоньше, но тоже толстоват
            if (tmpSourceEditor<>_ideEvent_Editor_) then begin
                // МОЖНО попробовать выполнить ПОЛЕЗНУЮ нагрузку
                if _do_BTF_ObjectInspector_
                then _ideEvent_Editor_:=tmpSourceEditor
                else _ideEvent_Editor_:=NIL;
            end
            else begin
                {$ifDEF _EventLOG_}
                DEBUG('SKIP','already processed');
                {$endIf}
            end;
        end
        else begin
           _ideEvent_Editor_:=nil;
            {$ifDEF _EventLOG_}
            DEBUG('ER','ActiveEditor is NULL');
            {$endIf}
        end;
    end
    else begin
        {$ifDEF _EventLOG_}
        DEBUG('ER','IDE not ready');
        {$endIf}
    end;
end;

//------------------------------------------------------------------------------

procedure tLazExt_aBTF_ObjectInspector._ideEvent_semEditorActivate(Sender:TObject);
begin
    {$ifDEF _EventLOG_}
    DEBUG('ideEVENT:semEditorActivate','--->>>'+' sender'+addr2txt(Sender));
    {$endIf}

    if assigned(_ide_Window_SEW_) //< запускаемся только если окно
    then _ideEvent_exeEvent_      //  редактирования в ФОКУСЕ
    else begin
        {$ifDEF _EventLOG_}
        DEBUG('SKIP','ActiveSourceWindow is UNfocused');
        {$endIf}
    end;

    {$ifDEF _EventLOG_}
    DEBUG('ideEVENT:semEditorActivate','---<<<');
    {$endIf}
end;

procedure tLazExt_aBTF_ObjectInspector._ideEvent_semWindowFocused(Sender:TObject);
begin
    {$ifDEF _EventLOG_}
    DEBUG('ideEVENT:semWindowFocused','--->>>'+' sender'+addr2txt(Sender));
    {$endIf}

    if Assigned(Sender) and (Sender is TSourceEditorWindowInterface) then begin
       _SEW_SET(TSourceEditorWindowInterface(Sender));
        if Assigned(_ide_Window_SEW_) then begin
           _ideEvent_exeEvent_;
        end
        else begin
            {$ifDEF _EventLOG_}
            DEBUG('SKIP WITH ERROR','BIG ERROR: ower _ide_Window_SEW_ found');
            {$endIf}
        end;
    end
    else begin
        {$ifDEF _EventLOG_}
        DEBUG('SKIP','Sender undef');
        {$endIf}
    end;

    {$ifDEF _EventLOG_}
    DEBUG('ideEVENT:semWindowFocused','---<<<');
    {$endIf}
end;

//------------------------------------------------------------------------------

procedure tLazExt_aBTF_ObjectInspector._ideEvent_register_;
begin
    SourceEditorManagerIntf.RegisterChangeEvent(semWindowFocused,  @_ideEvent_semWindowFocused);
    //SourceEditorManagerIntf.RegisterChangeEvent(semEditorActivate, @_ideEvent_semEditorActivate);
end;

{%endRegion}


function tLazExt_aBTF_ObjectInspector._ideMenu_find_inSection(const ideCommand:TIDECommand; ideMenuSection:TIDEMenuSection):TIDEMenuCommand;
var i:integer;
  tmp:TIDEMenuItem;
begin
    result:=nil;
    for i:=0 to ideMenuSection.Count-1 do begin
        tmp:=ideMenuSection.Items[i];
        if not Assigned(tmp) then begin end
       else
        if tmp is TIDEMenuCommand then begin
            if TIDEMenuCommand(tmp).Command=ideCommand then begin
                result:=TIDEMenuCommand(tmp);
                BREAK;
            end;
        end
       else
        if tmp is TIDEMenuSection then begin
            result:=_ideMenu_find_inSection(ideCommand,TIDEMenuSection(tmp));
            if Assigned(result) then BREAK;
        end;
    end;
end;

function tLazExt_aBTF_ObjectInspector._ideMenu_find_(const ideCommand:TIDECommand):TIDEMenuCommand;
var i:integer;
  tmp:TIDEMenuItem;
begin
    result:=nil;
    for i:=0 to IDEMenuRoots.Count-1 do begin
        tmp:=IDEMenuRoots.Items[i];
        if not Assigned(tmp) then begin end
       else
        if tmp is TIDEMenuSection then begin
            result:=_ideMenu_find_inSection(ideCommand,TIDEMenuSection(tmp));
            if Assigned(result) then BREAK;
        end;
    end;
end;

procedure  tLazExt_aBTF_ObjectInspector._TFUV_onClick_myCustom_(Sender:TObject);
begin
    if Assigned(_ideMenuITM_TFUV_onClick_original_) then begin
      _ideMenuITM_TFUV_onClick_original_(Sender);
       {$ifDEF _EventLOG_}
       DEBUG('EXECUTE','ideMenuITM_TFUV_onClick_original processed');
       {$endIf}
    end;
    myFNC;
end;

procedure tLazExt_aBTF_ObjectInspector._TFUV_onClick_rePlace(const ideMenuItem:TIDEMenuCommand);
begin
    if Assigned(ideMenuItem) then begin
      _ideMenuITM_TFUV_onClick_original_:=ideMenuItem.OnClick;
       ideMenuItem.OnClick:=@_TFUV_onClick_myCustom_;
       {$ifDEF _EventLOG_}
       DEBUG('replace','TFUV_onClick');
       {$endIf}
    end;
end;

(*function tLazExt_aBTF_ObjectInspector.enumerate_menuItemITEM(const ideMenuITEM:TIDEMenuSection):boolean;
var i:integer;
  tmp:TIDEMenuItem;
begin
    for i:=0 to ideMenuITEM.Count-1 do begin
        tmp:=ideMenuITEM.Items[i];
//        DEBUG('MENU_i',tmp.Name);

        if tmp is TIDEMenuCommand then begin

            //TIDEMenuCommand(tmp).Name;
            if TIDEMenuCommand(tmp).Command =  _IDECommand_TFU_ then begin
                DEBUG('MENU_C',tmp.Name+addr2txt(TIDEMenuCommand(tmp).Command));
            end;

           //TIDEMenuCommand(tmp).Command.
        end;

        if tmp is TIDEMenuSection then begin
            //DEBUG('MENU_III',tmp.Name);
            enumerate_menuItemITEM(TIDEMenuSection(tmp));
        end;
    end;
end;   *)

 (*
function tLazExt_aBTF_ObjectInspector.enumerate_menuItem:boolean;
var i:integer;
    ideMenuSection:TIDEMenuSection;
begin
   // if _IDECommand_TFU_<>nil then begin
        for i:=0 to IDEMenuRoots.Count-1 do begin
            ideMenuSection:=IDEMenuRoots.Items[i];
            DEBUG('MENU_S',ideMenuSection.Name);
            enumerate_menuItemITEM(ideMenuSection);
        end;
   // end;
//    Items[Index: integer]: TIDEMenuSection
end; *)

//_ide_Window_DSGNR_:TCustomForm;
//_ide_Window_DSGNR_onActivate_original_:TNotifyEvent;
procedure tLazExt_aBTF_ObjectInspector._DSGNR_onActivate_myCustom_(Sender:TObject);
begin
    if Assigned(_ide_Window_DSGNR_onActivate_original_) then begin
      _ide_Window_DSGNR_onActivate_original_(sender);
       {$ifDEF _EventLOG_}
       DEBUG('DSGNR','onActivate_original');
       {$endIf}
    end;
    myFNC;
end;

procedure tLazExt_aBTF_ObjectInspector._DSGNR_rePlace_onActivate_(const wnd:TCustomForm);
begin
    if Assigned(wnd) and (wnd.OnActivate<>@_DSGNR_onActivate_myCustom_) then begin
       _ide_Window_DSGNR_onActivate_original_:=wnd.OnActivate;
        wnd.OnActivate:=@_DSGNR_onActivate_myCustom_;
        {$ifDEF _EventLOG_}
        DEBUG('_DSGNR_rePALCE_onActivate_','wnd'+addr2txt(wnd)+' '+addr2txt(pointer((@_ide_Window_DSGNR_onActivate_original_)^))+ '->'+addr2txt(pointer((@wnd.OnActivate)^)));
        {$endIf}
    end
    else begin
        {$ifDEF _EventLOG_}
        DEBUG('_DSGNR_rePALCE_onActivate_','SKIP wnd'+addr2txt(wnd)+' now'+addr2txt(pointer((@wnd.OnActivate)^)));
        {$endIf}
    end
end;

procedure tLazExt_aBTF_ObjectInspector._DSGNR_reStore_onActivate_(const wnd:TCustomForm);
begin
    if Assigned(wnd) and (wnd.OnActivate=@_DSGNR_onActivate_myCustom_) then begin
        {$ifDEF _EventLOG_}
        DEBUG('_DSGNR_reSTORE_onActivate_','wnd'+addr2txt(wnd)+' '+addr2txt(pointer((@wnd.OnActivate)^))+'->'+addr2txt(pointer((@_ide_Window_DSGNR_onActivate_original_)^)));
        {$endIf}
        wnd.OnActivate:=_ide_Window_DSGNR_onActivate_original_;
    end
    else begin
        {$ifDEF _EventLOG_}
        DEBUG('_DSGNR_reSTORE_onActivate_','SKIP wnd'+addr2txt(wnd)+' now'+addr2txt(pointer((@wnd.OnActivate)^)));
        {$endIf}
    end;
   _ide_Window_DSGNR_onActivate_original_:=NIL;
end;

procedure tLazExt_aBTF_ObjectInspector._DSGNR_SET_(const wnd:TCustomForm);
begin
    if _ide_Window_DSGNR_<>wnd then begin
        if Assigned(_ide_Window_DSGNR_) then begin
           _DSGNR_reStore_onActivate_(_ide_Window_DSGNR_);
        end;
       _ide_Window_DSGNR_:=wnd;
        if Assigned(_ide_Window_DSGNR_) then begin
           _DSGNR_rePlace_onActivate_(_ide_Window_DSGNR_);
        end;
    end;
end;


procedure tLazExt_aBTF_ObjectInspector._Lazarus_onActivate_myCustom_(Sender:TObject);
begin
   {$ifDEF _EventLOG_}
   DEBUG('_Lazarus_onActivate_myCustom_','_Lazarus_onActivate_myCustom_');
   {$endIf}
   if Assigned(_ide_Applctn_Lazarus_onActivate_original_)
   then _ide_Applctn_Lazarus_onActivate_original_(Sender);
end;

end.
