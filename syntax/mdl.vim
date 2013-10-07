" Vim syntax file
" Language:	Pascal
" Version: 2.8
" Last Change:	2004/10/17 17:47:30
" Maintainer:  Xavier Crégut <xavier.cregut@enseeiht.fr>
" Previous Maintainer:	Mario Eusebio <bio@dq.fct.unl.pt>

" Contributors: Tim Chase <tchase@csc.com>,
"	Stas Grabois <stsi@vtrails.com>,
"	Mazen NEIFER <mazen.neifer.2001@supaero.fr>,
"	Klaus Hast <Klaus.Hast@arcor.net>,
"	Austin Ziegler <austin@halostatue.ca>,
"	Markus Koenig <markus@stber-koenig.de>

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif


syn case ignore
syn sync lines=250

syn keyword mdlBoolean		true false
syn keyword mdlConditional	if else then
syn keyword mdlConstant		nil maxint
syn keyword mdlLabel		case goto label
syn keyword mdlOperator		and div downto in mod not of or packed with
syn keyword mdlRepeat		do for do repeat while to until
syn keyword mdlStatement	procedure function
syn keyword mdlStatement	program begin end const var type
syn keyword mdlStruct		record
syn keyword mdlType		array boolean char integer file pointer real set
syn keyword mdlType		string text variant


    " 20011222az: Added new items.
syn keyword mdlTodo contained	TODO FIXME XXX DEBUG NOTE

    " 20010723az: When wanted, highlight the trailing whitespace -- this is
    " based on c_space_errors; to enable, use "mdl_space_errors".
if exists("mdl_space_errors")
    if !exists("mdl_no_trail_space_error")
        syn match mdlSpaceError "\s\+$"
    endif
    if !exists("mdl_no_tab_space_error")
        syn match mdlSpaceError " \+\t"me=e-1
    endif
endif



" String
"if !exists("mdl_one_line_string")
"  syn region  mdlString matchgroup=mdlString start=+'+ end=+'+ contains=mdlStringEscape
"  if exists("mdl_gpc")
    syn region  mdlString matchgroup=mdlString start=+"+ end=+"+ contains=mdlStringEscapeGPC
"  else
"    syn region  mdlStringError matchgroup=mdlStringError start=+"+ end=+"+ contains=mdlStringEscape
"  endif
"else
"  "wrong strings
"  syn region  mdlStringError matchgroup=mdlStringError start=+'+ end=+'+ end=+$+ contains=mdlStringEscape
"  if exists("mdl_gpc")
"    syn region  mdlStringError matchgroup=mdlStringError start=+"+ end=+"+ end=+$+ contains=mdlStringEscapeGPC
"  else
"    syn region  mdlStringError matchgroup=mdlStringError start=+"+ end=+"+ end=+$+ contains=mdlStringEscape
"  endif
"
"  "right strings
"  syn region  mdlString matchgroup=mdlString start=+'+ end=+'+ oneline contains=mdlStringEscape
"  " To see the start and end of strings:
"  " syn region  mdlString matchgroup=mdlStringError start=+'+ end=+'+ oneline contains=mdlStringEscape
"  if exists("mdl_gpc")
"    syn region  mdlString matchgroup=mdlString start=+"+ end=+"+ oneline contains=mdlStringEscapeGPC
"  else
"    syn region  mdlStringError matchgroup=mdlStringError start=+"+ end=+"+ oneline contains=mdlStringEscape
"  endif
"end
syn match   mdlStringEscape		contained "''"
syn match   mdlStringEscapeGPC		contained '""'


" syn match   mdlIdentifier		"\<[a-zA-Z_][a-zA-Z0-9_]*\>"


if exists("mdl_symbol_operator")
  syn match   mdlSymbolOperator      "[+\-/*=]"
  syn match   mdlSymbolOperator      "[<>]=\="
  syn match   mdlSymbolOperator      "<>"
  syn match   mdlSymbolOperator      ":="
  syn match   mdlSymbolOperator      "[()]"
  syn match   mdlSymbolOperator      "\.\."
  syn match   mdlSymbolOperator       "[\^.]"
  syn match   mdlMatrixDelimiter	"[][]"
  "if you prefer you can highlight the range
  "syn match  mdlMatrixDelimiter	"[\d\+\.\.\d\+]"
endif

syn match  mdlNumber		"-\=\<\d\+\>"
syn match  mdlFloat		"-\=\<\d\+\.\d\+\>"
syn match  mdlFloat		"-\=\<\d\+\.\d\+[eE]-\=\d\+\>"
syn match  mdlHexNumber	"\$[0-9a-fA-F]\+\>"

if exists("mdl_no_tabs")
  syn match mdlShowTab "\t"
endif

syn region mdlComment	start="(\*\|{"  end="\*)\|}" contains=mdlTodo,mdlSpaceError


if !exists("mdl_no_functions")
  " array functions
  syn keyword mdlFunction	pack unpack

  " memory function
  syn keyword mdlFunction	Dispose New

  " math functions
  syn keyword mdlFunction	Abs Arctan Cos Exp Ln Sin Sqr Sqrt

  " file functions
  syn keyword mdlFunction	Eof Eoln Write Writeln
  syn keyword mdlPredefined	Input Output

  if exists("mdl_traditional")
    " These functions do not seem to be defined in Turbo Pascal
    syn keyword mdlFunction	Get Page Put 
  endif

  " ordinal functions
  syn keyword mdlFunction	Odd Pred Succ

  " transfert functions
  syn keyword mdlFunction	Chr Ord Round Trunc
endif


if !exists("mdl_traditional")

  syn keyword mdlStatement	constructor destructor implementation inherited
  syn keyword mdlStatement	interface unit uses
  syn keyword mdlModifier	absolute assembler external far forward inline
  syn keyword mdlModifier	interrupt near virtual 
  syn keyword mdlAcces	private public 
  syn keyword mdlStruct	object 
  syn keyword mdlOperator	shl shr xor

  syn region mdlPreProc	start="(\*\$"  end="\*)" contains=mdlTodo
  syn region mdlPreProc	start="{\$"  end="}"

  syn region  mdlAsm		matchgroup=mdlAsmKey start="\<asm\>" end="\<end\>" contains=mdlComment,mdlPreProc

  syn keyword mdlType	ShortInt LongInt Byte Word
  syn keyword mdlType	ByteBool WordBool LongBool
  syn keyword mdlType	Cardinal LongWord
  syn keyword mdlType	Single Double Extended Comp
  syn keyword mdlType	PChar


  if !exists ("mdl_fpc")
    syn keyword mdlPredefined	Result
  endif

  if exists("mdl_fpc")
    syn region mdlComment        start="//" end="$" contains=mdlTodo,mdlSpaceError
    syn keyword mdlStatement	fail otherwise operator
    syn keyword mdlDirective	popstack
    syn keyword mdlPredefined self
    syn keyword mdlType	ShortString AnsiString WideString
  endif

  if exists("mdl_gpc")
    syn keyword mdlType	SmallInt
    syn keyword mdlType	AnsiChar
    syn keyword mdlType	PAnsiChar
  endif

  if exists("mdl_delphi")
    syn region mdlComment	start="//"  end="$" contains=mdlTodo,mdlSpaceError
    syn keyword mdlType	SmallInt Int64
    syn keyword mdlType	Real48 Currency
    syn keyword mdlType	AnsiChar WideChar
    syn keyword mdlType	ShortString AnsiString WideString
    syn keyword mdlType	PAnsiChar PWideChar
    syn match  mdlFloat	"-\=\<\d\+\.\d\+[dD]-\=\d\+\>"
    syn match  mdlStringEscape	contained "#[12][0-9]\=[0-9]\="
    syn keyword mdlStruct	class dispinterface
    syn keyword mdlException	try except raise at on finally
    syn keyword mdlStatement	out
    syn keyword mdlStatement	library package 
    syn keyword mdlStatement	initialization finalization uses exports
    syn keyword mdlStatement	property out resourcestring threadvar
    syn keyword mdlModifier	contains
    syn keyword mdlModifier	overridden reintroduce abstract
    syn keyword mdlModifier	override export dynamic name message
    syn keyword mdlModifier	dispid index stored default nodefault readonly
    syn keyword mdlModifier	writeonly implements overload requires resident
    syn keyword mdlAcces	protected published automated
    syn keyword mdlDirective	register mdl cvar cdecl stdcall safecall
    syn keyword mdlOperator	as is
  endif

  if exists("mdl_no_functions")
    "syn keyword mdlModifier	read write
    "may confuse with Read and Write functions.  Not easy to handle.
  else
    " control flow functions
    syn keyword mdlFunction	Break Continue Exit Halt RunError

    " ordinal functions
    syn keyword mdlFunction	Dec Inc High Low

    " math functions
    syn keyword mdlFunction	Frac Int Pi

    " string functions
    syn keyword mdlFunction	Concat Copy Delete Insert Length Pos Str Val

    " memory function
    syn keyword mdlFunction	FreeMem GetMem MaxAvail MemAvail

    " pointer and address functions
    syn keyword mdlFunction	Addr Assigned CSeg DSeg Ofs Ptr Seg SPtr SSeg

    " misc functions
    syn keyword mdlFunction	Exclude FillChar Hi Include Lo Move ParamCount
    syn keyword mdlFunction	ParamStr Random Randomize SizeOf Swap TypeOf
    syn keyword mdlFunction	UpCase

    " predefined variables
    syn keyword mdlPredefined ErrorAddr ExitCode ExitProc FileMode FreeList
    syn keyword mdlPredefined FreeZero HeapEnd HeapError HeapOrg HeapPtr
    syn keyword mdlPredefined InOutRes OvrCodeList OvrDebugPtr OvrDosHandle
    syn keyword mdlPredefined OvrEmsHandle OvrHeapEnd OvrHeapOrg OvrHeapPtr
    syn keyword mdlPredefined OvrHeapSize OvrLoadList PrefixSeg RandSeed
    syn keyword mdlPredefined SaveInt00 SaveInt02 SaveInt1B SaveInt21
    syn keyword mdlPredefined SaveInt23 SaveInt24 SaveInt34 SaveInt35
    syn keyword mdlPredefined SaveInt36 SaveInt37 SaveInt38 SaveInt39
    syn keyword mdlPredefined SaveInt3A SaveInt3B SaveInt3C SaveInt3D
    syn keyword mdlPredefined SaveInt3E SaveInt3F SaveInt75 SegA000 SegB000
    syn keyword mdlPredefined SegB800 SelectorInc StackLimit Test8087

    " file functions
    syn keyword mdlFunction	Append Assign BlockRead BlockWrite ChDir Close
    syn keyword mdlFunction	Erase FilePos FileSize Flush GetDir IOResult
    syn keyword mdlFunction	MkDir Read Readln Rename Reset Rewrite RmDir
    syn keyword mdlFunction	Seek SeekEof SeekEoln SetTextBuf Truncate

    " crt unit
    syn keyword mdlFunction	AssignCrt ClrEol ClrScr Delay DelLine GotoXY
    syn keyword mdlFunction	HighVideo InsLine KeyPressed LowVideo NormVideo
    syn keyword mdlFunction	NoSound ReadKey Sound TextBackground TextColor
    syn keyword mdlFunction	TextMode WhereX WhereY Window
    syn keyword mdlPredefined CheckBreak CheckEOF CheckSnow DirectVideo
    syn keyword mdlPredefined LastMode TextAttr WindMin WindMax
    syn keyword mdlFunction BigCursor CursorOff CursorOn
    syn keyword mdlConstant Black Blue Green Cyan Red Magenta Brown
    syn keyword mdlConstant LightGray DarkGray LightBlue LightGreen
    syn keyword mdlConstant LightCyan LightRed LightMagenta Yellow White
    syn keyword mdlConstant Blink ScreenWidth ScreenHeight bw40
    syn keyword mdlConstant co40 bw80 co80 mono
    syn keyword mdlPredefined TextChar 

    " DOS unit
    syn keyword mdlFunction	AddDisk DiskFree DiskSize DosExitCode DosVersion
    syn keyword mdlFunction	EnvCount EnvStr Exec Expand FindClose FindFirst
    syn keyword mdlFunction	FindNext FSearch FSplit GetCBreak GetDate
    syn keyword mdlFunction	GetEnv GetFAttr GetFTime GetIntVec GetTime
    syn keyword mdlFunction	GetVerify Intr Keep MSDos PackTime SetCBreak
    syn keyword mdlFunction	SetDate SetFAttr SetFTime SetIntVec SetTime
    syn keyword mdlFunction	SetVerify SwapVectors UnPackTime
    syn keyword mdlConstant	FCarry FParity FAuxiliary FZero FSign FOverflow
    syn keyword mdlConstant	Hidden Sysfile VolumeId Directory Archive
    syn keyword mdlConstant	AnyFile fmClosed fmInput fmOutput fmInout
    syn keyword mdlConstant	TextRecNameLength TextRecBufSize
    syn keyword mdlType	ComStr PathStr DirStr NameStr ExtStr SearchRec
    syn keyword mdlType	FileRec TextBuf TextRec Registers DateTime
    syn keyword mdlPredefined DosError

    "Graph Unit
    syn keyword mdlFunction	Arc Bar Bar3D Circle ClearDevice ClearViewPort
    syn keyword mdlFunction	CloseGraph DetectGraph DrawPoly Ellipse
    syn keyword mdlFunction	FillEllipse FillPoly FloodFill GetArcCoords
    syn keyword mdlFunction	GetAspectRatio GetBkColor GetColor
    syn keyword mdlFunction	GetDefaultPalette GetDriverName GetFillPattern
    syn keyword mdlFunction	GetFillSettings GetGraphMode GetImage
    syn keyword mdlFunction	GetLineSettings GetMaxColor GetMaxMode GetMaxX
    syn keyword mdlFunction	GetMaxY GetModeName GetModeRange GetPalette
    syn keyword mdlFunction	GetPaletteSize GetPixel GetTextSettings
    syn keyword mdlFunction	GetViewSettings GetX GetY GraphDefaults
    syn keyword mdlFunction	GraphErrorMsg GraphResult ImageSize InitGraph
    syn keyword mdlFunction	InstallUserDriver InstallUserFont Line LineRel
    syn keyword mdlFunction	LineTo MoveRel MoveTo OutText OutTextXY
    syn keyword mdlFunction	PieSlice PutImage PutPixel Rectangle
    syn keyword mdlFunction	RegisterBGIDriver RegisterBGIFont
    syn keyword mdlFunction	RestoreCRTMode Sector SetActivePage
    syn keyword mdlFunction	SetAllPallette SetAspectRatio SetBkColor
    syn keyword mdlFunction	SetColor SetFillPattern SetFillStyle
    syn keyword mdlFunction	SetGraphBufSize SetGraphMode SetLineStyle
    syn keyword mdlFunction	SetPalette SetRGBPalette SetTextJustify
    syn keyword mdlFunction	SetTextStyle SetUserCharSize SetViewPort
    syn keyword mdlFunction	SetVisualPage SetWriteMode TextHeight TextWidth
    syn keyword mdlType	ArcCoordsType FillPatternType FillSettingsType
    syn keyword mdlType	LineSettingsType PaletteType PointType
    syn keyword mdlType	TextSettingsType ViewPortType

    " string functions
    syn keyword mdlFunction	StrAlloc StrBufSize StrCat StrComp StrCopy
    syn keyword mdlFunction	StrDispose StrECopy StrEnd StrFmt StrIComp
    syn keyword mdlFunction	StrLCat StrLComp StrLCopy StrLen StrLFmt
    syn keyword mdlFunction	StrLIComp StrLower StrMove StrNew StrPas
    syn keyword mdlFunction	StrPCopy StrPLCopy StrPos StrRScan StrScan
    syn keyword mdlFunction	StrUpper
  endif

endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_mdl_syn_inits")
  if version < 508
    let did_mdl_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink mdlAcces		mdlStatement
  HiLink mdlBoolean		Boolean
  HiLink mdlComment		Comment
  HiLink mdlConditional		Conditional
  HiLink mdlConstant		Constant
  HiLink mdlDelimiter		Identifier
  HiLink mdlDirective		mdlStatement
  HiLink mdlException		Exception
  HiLink mdlFloat		Float
  HiLink mdlFunction		Function
  HiLink mdlLabel		Label
  HiLink mdlMatrixDelimiter	Identifier
  HiLink mdlModifier		Type
  HiLink mdlNumber		Number
  HiLink mdlOperator		Operator
  HiLink mdlPredefined		mdlStatement
  HiLink mdlPreProc		PreProc
  HiLink mdlRepeat		Repeat
  HiLink mdlSpaceError		Error
  HiLink mdlStatement		Statement
  HiLink mdlString		String
  HiLink mdlStringEscape	Special
  HiLink mdlStringEscapeGPC	Special
  HiLink mdlStringError		Error
  HiLink mdlStruct		mdlStatement
  HiLink mdlSymbolOperator	mdlOperator
  HiLink mdlTodo		Todo
  HiLink mdlType		Type
  HiLink mdlUnclassified	mdlStatement
  "  HiLink mdlAsm		Assembler
  HiLink mdlError		Error
  HiLink mdlAsmKey		mdlStatement
  HiLink mdlShowTab		Error

  delcommand HiLink
endif


let b:current_syntax = "mdl"

" vim: ts=8 sw=2
