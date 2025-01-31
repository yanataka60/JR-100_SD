;2025.1.31 MEXECのアドレス指定で$を読み飛ばしに修正

PIOA	EQU		$CD00
PIOB	EQU		$CD01
PIOC	EQU		$CD02
PIOR	EQU		$CD03

KCODE	EQU		$0001			;キースキャン結果
JOYSTK1	EQU		$0002			;JOYSTICK1スキャン結果
JOYSTK2	EQU		$0003			;JOYSTICK2スキャン結果
EXEPNT	EQU		$0043			;BASIC実行中の現在ポインタ
BUFPNT	EQU		$0057			;キーバッファ 最終ポインタ
PNT1	EQU		$006D			;PNT2+1
PNT2	EQU		$006F			;BASIC使用最終アドレス(変数領域含む) 変数未使用時はPNT3と同値
PNT3	EQU		$0071			;変数領域先頭アドレス(BASICプログラム最終アドレス+1)
HEXDAT	EQU		$0075			;STR2HEX用16進数データ
STRPNT	EQU		$00A1			;STR2HEX用16進文字列ポインタ
FTYPE	EQU		$00C8			;CMT用ファイルタイプ $00:BASIC $01:マシン語
SDBLK	EQU		$00C9			;SD用ブロックNo
SDSRT	EQU		$00CA			;SD用開始アドレス
SDLNG	EQU		$00CC			;SD用保存バイト数
SDEXE	EQU		$00CE			;SD用実行アドレス
SDNPNT	EQU		$00D0
SDNAME	EQU		$00D2
LBUFF	EQU		$018E			;キーバッファ
KSCAN	EQU		$E8CB			;キースキャン $0001:キーデータ(キャラクタコード) $0002:JOYSTICK1 $0003:JOYSTICK2
LINPUT	EQU		$EAD0			;Xレジスタからのメッセージを表示して1行入力 メッセージの終端は$FF 入力文字列は$018E～(80文字)
PRINT	EQU		$EBE7			;Aレジスタのアスキーコードを出力
								;   $0008:$00 CRT $01～$7F PRT $80～$FF CRT+PRT $000E:カラーアトリビュート
								;   X,A,Bは保持
HEX2AS	EQU		$EEE7			;(X)の16進数をアスキーコードに変換してABレジスタへ A:上位4ビット B:下位4ビット
STR2HEX	EQU		$FB19			;($00A1-$00A2)から始まる16進数文字列を16進数データに変換して($0075-$0076)に格納する
								;   デミリタは$20,$2C等
								;   B=$00 変換完了 $0D 変換不可 X:16進数文字列の終了位置+1


;MONITER Gコマンドの後ろにファイルネームを指定 $0193(LBUFF+5)から取得

;ソース内記述汎用ルーチン
;AZLCNV							;大文字変換 Aレジスタのアルファベット小文字を大文字に変換
;STRPRN							;文字列出力 (X)から$00までの文字列を表示

		ORG		$8000

*
LAU		JMP		LAUNCH
ULDJ	JMP		ULOAD			;USR関数でLOAD 直後のREM文でファイル名指定
;CMDJ	JMP		CMD

;---------------- LAUNCHER ---------------------
LAUNCH	JSR		PIOINI			;8255初期化
		LDX		#TITLE_MSG
		JSR		STRPRN
LAU1	LDX		#SDMES
		JSR		LINPUT
		LDX		#LBUFF-1
		JSR		CMD1
		CMPA	#'!'			;!コマンドならリターン
		BEQ		LAU2
		BRA		LAU1
LAU2	RTS

;----------------- COMMAND ------------------------
;CMD		LDX		#LBUFF+5-1
CMD1	INX
		LDAA	X
		JSR		AZLCNV
		CMPA	#' '			;最初のSPACEは除去
		BEQ		CMD1

		CMPA	#'M'			;MEXEC MSAVE
		BEQ		CMD2
		CMPA	#'L'			;LOAD
		BEQ		CMD3
		CMPA	#'S'			;SDDIR SAVE
		BEQ		CMD4
		CMPA	#'G'			;GO
		BEQ		GCMD2
		CMPA	#'!'			;EXIT LAUNCHER
		BEQ		EXIT
		BRA		CMDERR

CMD2	INX
		LDAA	X
		JSR		AZLCNV
		CMPA	#'E'			;MEXEC
		BEQ		MEXEC2
		CMPA	#'S'			;MSAVE
		BEQ		MSAVE2
		BRA		CMDERR

CMD3	INX
		LDAA	X
		JSR		AZLCNV
		CMPA	#'O'			;LOAD
		BEQ		LOAD2
		BRA		CMDERR

CMD4	INX
		LDAA	X
		JSR		AZLCNV
		CMPA	#'D'			;SDDIR
		BEQ		SDDIR2
		CMPA	#'A'			;SAVE
		BEQ		SAVE2
		BRA		CMDERR
		
CMDERR
		LDX		#MSG_CMD
		JSR		STRPRN
		RTS

LOAD2	JMP		LOAD
MEXEC2	JMP		MEXEC
MSAVE2	JMP		MSAVE
SDDIR2	JMP		SDDIR
SAVE2	JMP		SAVE
ULOAD2	JMP		ULOAD
GCMD2	JMP		GCMD
EXIT	RTS


ERRJ
		JMP		ERRRTN

LOAD
		INX						;'A'読み飛ばし
		INX						;'D'読み飛ばし
		JSR		SPDEL			;最初のSPACEは除去
FN01
;		JSR		PIOINI			;8255初期化

		LDAA	#$83			;コマンド$83を送信
		JSR		CSND
		TSTA
		BNE		ERRJ

;-------------------- CJRヘッダブロック受信 -------------------
		JSR		RCVBYTE			;$02
		JSR		RCVBYTE			;$2A
		JSR		RCVBYTE			;$00
		JSR		RCVBYTE			;$1A
		JSR		RCVBYTE			;$FF
		JSR		RCVBYTE			;$FF
		
		LDAB	#$10
		LDX		#LBUFF			;SDから送られてきたファイル名を格納
LD1		JSR		RCVBYTE			;FNAME
		STAA	X
		INX
		DECB
		BNE		LD1
		CLRA
		STAA	X
		
		JSR		RCVBYTE			;ファイルタイプ
		STAA	FTYPE
		TSTA
		BNE		LD11
		LDX		#BSMSG
		JSR		STRPRN
		BRA		LD12
LD11	LDX		#BNMSG
		JSR		STRPRN
LD12	LDX		#LDMSG
		JSR		STRPRN
		LDX		#LBUFF
		JSR		STRPRN
		
		JSR		RCVBYTE			;ボーレート
		
		JSR		RCVBYTE			;$FF
		JSR		RCVBYTE			;$FF
		JSR		RCVBYTE			;$FF
		JSR		RCVBYTE			;$FF
		JSR		RCVBYTE			;$FF
		JSR		RCVBYTE			;$FF
		JSR		RCVBYTE			;$FF
		JSR		RCVBYTE			;$FF
		JSR		RCVBYTE			;チェックサム

;---------------- CJRデータブロック受信 ------------------------
LD2		JSR		RCVBYTE			;$02
		JSR		RCVBYTE			;$2A
		JSR		RCVBYTE			;ブロックナンバー
		STAA	SDBLK
		CMPA	#$FF
		BEQ		FOOTER
		JSR		RCVBYTE			;データサイズ
		TAB
		JSR		RCVBYTE			;ロードアドレス上位
		STAA	SDSRT
		JSR		RCVBYTE			;ロードアドレス下位
		STAA	SDSRT+1
		LDX		SDSRT
		LDAA	SDBLK
		CMPA	#$01			;ブロックナンバー01の時だけ、ロードアドレスを実行アドレスとして保存
		BNE		LD3
		STX		SDEXE
LD3		JSR		RCVBYTE			;データ受信
		STAA	X
		INX
		DECB
		BNE		LD3
		JSR		RCVBYTE			;チェックサム
		BRA		LD2
		
;------------------ CJRフッターブロック受信 -------------------------
FOOTER	JSR		RCVBYTE			;$FF
		JSR		RCVBYTE			;ロード終了アドレス+1上位
		JSR		RCVBYTE			;ロード終了アドレス+1下位
		DEX
		STX		SDSRT
		TST		FTYPE
		BNE		LD4
;----------- BASIC LOAD 後処理 ------------------
		LDX		SDSRT
		STX		PNT3
		STX		PNT2
		INX
		STX		PNT1
		RTS
;----------- マシン語 LOAD 後処理 ------------------
LD4		LDAA	#'('
		JSR		PRINT
		LDX		#SDEXE
		JSR		PRHEX			;スタートアドレス表示
		LDX		#SDEXE+1
		JSR		PRHEX
		LDAA	#'-'
		JSR		PRINT
		LDX		#SDSRT			;エンドアドレス表示
		JSR		PRHEX
		LDX		#SDSRT+1
		JSR		PRHEX
		LDAA	#')'
		JSR		PRINT
		RTS
		
ERRJ2
		JMP		ERRRTN

;--------------- BASIC プログラム SAVE ----------------------------
SAVE
		INX						;'V'読み飛ばし
		INX						;'E'読み飛ばし
		JSR		SPDEL			;最初のSPACEは除去
;		JSR		PIOINI			;8255初期化

		LDAA	#$84			;コマンド$84、ファイルネームを送信
		JSR		CSND
		TSTA
		BNE		ERRJ2

		CLRA
		JSR		SNDBYTE			;継続コード送信
		LDAA	PNT2+1			;BASICプログラム最終アドレス(下位バイト)
		SUBA	#$01
		STAA	SDLNG+1
		LDAA	PNT2			;BASICプログラム最終アドレス(上位バイト)
		SBCA	#$08
		STAA	SDLNG
		LDX		SDLNG
		INX
		STX		SDLNG			;ファイルサイズ計算(PNT2-$0801+1)
		BEQ		SV99			;BASICプログラムが無ければ終了
		CLRA					;ファイルタイプ(0:BASIC)
		JSR		SNDBYTE
		LDX		#$0801			;BASICプログラム先頭アドレス
		STX		SDSRT
;----------------- SAVEデータ送信 ------------------------
SV1		LDAA	SDSRT			;SAVE開始アドレス送信
		JSR		SNDBYTE
		LDAA	SDSRT+1
		JSR		SNDBYTE
		LDAA	SDLNG			;SAVEデータサイズ送信
		JSR		SNDBYTE
		LDAA	SDLNG+1
		JSR		SNDBYTE

SV2		LDX		SDSRT
		LDAA	X				;SAVEデータ送信
		JSR		SNDBYTE
		INX
		STX		SDSRT
		LDX		SDLNG			;SDLNG-1
		DEX
		STX		SDLNG			;SDLNGが0になるまでループ
		BNE		SV2
		LDX		#SVMSG			;SAVE終了MSG
		JSR		STRPRN
		
SV99	RTS

ERRJ3
		JMP		ERRRTN

;---------------- 機械語プログラム SAVE -------------------------------
MSAVE
		INX						;'A'読み飛ばし
		INX						;'V'読み飛ばし
		INX						;'E'読み飛ばし
		JSR		SPDEL			;最初のSPACEは除去

		JSR		DLLDEL
		STX		STRPNT
		JSR		STR2HEX			;文字列からSAVE開始アドレスを取得
		TSTB
		BNE		ADDERR
		LDAA	HEXDAT
		STAA	SDSRT
		LDAA	HEXDAT+1
		STAA	SDSRT+1
		INX
		JSR		DLLDEL
		STX		STRPNT
		JSR		STR2HEX			;文字列からSAVE終了アドレスを取得
		TSTB
		BNE		ADDERR

		INX
;		JSR		PIOINI			;8255初期化
		LDAA	#$84
		JSR		CSND			;コマンド$84、ファイルネームを送信
		TSTA
		BNE		ERRJ3

		LDAA	HEXDAT+1		;SAVE最終アドレス(下位バイト)
		SUBA	SDSRT+1
		STAA	SDLNG+1
		LDAA	HEXDAT			;SAVE最終アドレス(上位バイト)
		SBCA	SDSRT
		BCS		ADDERR2
		STAA	SDLNG
		LDX		SDLNG
		INX
		STX		SDLNG			;ファイルサイズ計算(HEXDAT-SDSRT+1)
		LDX		SDSRT

		CLRA
		JSR		SNDBYTE			;継続コード送信

		LDAA	#$01			;ファイルタイプ(1:機械語)
		JSR		SNDBYTE
		BRA		SV1

ADDERR2
		LDAA	#$FF
		JSR		SNDBYTE			;打ち切りコード送信
ADDERR	LDX		#MSG_AD
		JSR		STRPRN
		RTS

;--------------- MEXECUTE 機械語読み込みアドレスを実行アドレスとしてジャンプ -------
MEXEC	LDX		SDEXE
		JSR		X
		RTS

;--------------- GO COMMAND -------------------------
GCMD
		JSR		SPDEL			;最初のSPACEは除去
		JSR		DLLDEL
		STX		STRPNT
		JSR		STR2HEX			;文字列から実行開始アドレスを取得
		TSTB
		BNE		ADDERR
		LDAA	HEXDAT
		STAA	SDEXE
		LDAA	HEXDAT+1
		STAA	SDEXE+1
		BRA		MEXEC

;------------------ SDファイル一覧表示 ---------------------------
ERRJ5
		JMP		ERRRTN
SDDIR
		INX						;'D'読み飛ばし
		INX						;'I'読み飛ばし
		INX						;'R'読み飛ばし
		JSR		SPDEL			;最初のSPACEは除去
;		JSR		PIOINI			;8255初期化

		LDAA	#$82			;コマンド$82を送信

		JSR		CSND
		TSTA
		BNE		ERRJ5

DL1		LDX		#LBUFF			;Arduinoから送られてくる文字列を#KBUFへ格納
DL2		JSR		RCVBYTE
		JSR		AZLCNV			;大文字に変換
		TSTA
		BEQ		DL3				;$00を受信するまでを一行とする
		CMPA	#$FF
		BEQ		DL4				;$FFを受信したら終了
		CMPA	#$FD
		BEQ		DL9				;$FD受信で文字列を取得してSETLしたことを表示
		CMPA	#$FE
		BEQ		DL5				;$FEを受信したら一時停止して一文字入力待ち
		STAA	X
		INX
		BRA		DL2
		
DL3
		LDAA	#$0D			;$00を受信したら一行分を表示して改行
		STAA	X
		INX
		
		CLRA
		STAA	X
		INX
		LDX		#LBUFF
		JSR		STRPRN			;1行表示
DL33	BRA		DL1

DL4		JSR		RCVBYTE			;状態取得(00H=OK)して終了
		RTS

DL9		LDX		#LBUFF			;文字列を取得
DL91	JSR		RCVBYTE			;#KBUFへ文字列格納
		JSR		AZLCNV			;大文字に変換
		STAA	X
		INX
		TSTA					;$00を受信するまで受信処理
		BNE		DL91
		JSR		RCVBYTE			;$FF終了コード読み飛ばし
		JSR		RCVBYTE			;状態取得読み飛ばし
		LDX		#LBUFF
		JMP		FN01
		
DL5		LDX		#MSGKEY			;SEL:0-9 NXT:ANY BCK:B BRK:RET
		JSR		STRPRN			;文字列表示
DL6		JSR		KSCAN			;キーボートスキャン
		LDAA	KCODE
		TSTA
		BEQ		DL6				;何か入力されるまでループ
		JSR		AZLCNV
		CMPA	#$0D
		BEQ		DL7				;RETURNで打ち切り
		CMPA	#$30			;数字0～9ならそのままArduinoへ送信してSETL処理へ
		BCS		DL61
		CMPA	#$3A
		BCS		DL8			
DL61	CMPA	#$42
		BEQ		DL8				;「B」で前ページ
		CLRA
		BRA		DL8				;それ以外で継続
DL7		LDAA	#$FF
DL8		JSR		SNDBYTE
		JMP		DL1
		
SDIR99	RTS

;----------------- コマンドエラー表示 --------------------------
CMDERR2
		LDX		#MSG2_CMD
		JSR		STRPRN
		RTS

;---------------------- BASICプログラム中からLOAD -----------------
; A=USR($8003):REM xxxxxのように直後のREMの文字列をファイル名として解釈する。
; 指定は機械語プログラムのみ可。BASICプログラムを指定するとLOADした後暴走する。
ULOAD
		LDX		EXEPNT			;A <- (BASIC実行中の現在ポインタ)
		LDAA	X
		TSTA					;$00ならUSR文の後ろに記述無し
		BEQ		CMDERR2
		CMPA	#':'			;USR文の後ろに文があるか
		BNE		CMDERR2
		INX
		STX		EXEPNT			;BASIC実行中の現在ポインタ更新
		LDAA	X
		CMPA	#$AD			;後ろの文はREM文か
		BNE		CMDERR2
ULD1	INX
		STX		EXEPNT			;BASIC実行中の現在ポインタ更新
		LDAA	X
		JSR		AZLCNV
		CMPA	#' '			;SPACEは除去
		BEQ		ULD1
		
		LDX		#SDNAME
		STX		SDNPNT
ULD2	TSTA					;行が終わるまでをファイル名として取得
		BEQ		ULD9
		JSR		AZLCNV			;大文字変換
		STAA	X				;ファイル名保存
		INX
		STX		SDNPNT			;ファイル名保存ポインタ更新
		LDX		EXEPNT			;BASIC実行中の現在ポインタ更新
		INX
		STX		EXEPNT
		LDAA	X
		LDX		SDNPNT
		BRA		ULD2
		
ULD9
		LDX		#SDNAME			;ファイル名のアドレスをXレジスタにセットしてLOAD処理
		JSR		PIOINI			;8255初期化
		JMP		FN01

;--------------- エラーメッセージ ------------------------------
ERRRTN
		CMPA	#$F0
		BNE		ERR1
		LDX		#MSG_F0
		BRA		ERRR
ERR1	CMPA	#$F1
		BNE		ERR3
		LDX		#MSG_F1
		BRA		ERRR
ERR3	CMPA	#$F3
		BNE		ERR4
		LDX		#MSG_F3
		BRA		ERRR
ERR4	CMPA	#$F4
		BNE		ERR99
		LDX		#MSG_F4
		BRA		ERRR
ERR99
		STAA	SDSRT
		LDX		#SDSRT
		JSR		PRHEX
		LDX		#MSG99

ERRR	JSR		STRPRN
		RTS


**** BUSYをCHECK(1) ****
;PORTC BIT7が1になるまでLOOP
F1CHK	LDAA	PIOC
		ANDA	#$80			;PORTC BIT7 = 1?
		BEQ		F1CHK
		RTS

**** BUSYをCHECK(0) ****
;PORTC BIT7が0になるまでLOOP
F2CHK	LDAA	PIOC
		ANDA	#$80			;PORTC BIT7 = 0?
		BNE		F2CHK
		RTS

**** 1BYTE受信****
*受信データをアキュムレータAにセットしてリターン
RCVBYTE	BSR		F1CHK			;PORTC BIT7が1になるまでLOOP
		LDAA	PIOB			;PORTB -> A
		PSHA
		LDAA	#$05
		STAA	PIOR			;PORTC BIT2 <- 1
		BSR		F2CHK			;PORTC BIT7が0になるまでLOOP
		LDAA	#$04
		STAA	PIOR			;PORTC BIT2 <- 0
		PULA
		RTS

**** 1BYTE送信 ****
*アキュムレータAの内容をPORTA下位4BITに4BITずつ送信
SNDBYTE
		PSHA
		LSRA
		LSRA
		LSRA
		LSRA
		ANDA	#$0F
		BSR		SND4BIT
		PULA
		ANDA	#$0F
		BSR		SND4BIT
		RTS

**** 4BIT送信 ****
*アキュムレータA下位4ビットを送信する
SND4BIT
		STAA	PIOA
		LDAA	#$05
		STAA	PIOR			;PORTC BIT2 <- 1
		BSR		F1CHK			;PORTC BIT7が1になるまでLOOP
		LDAA	#$04
		STAA	PIOR			;PORTC BIT2 <- 0
		BSR		F2CHK
		RTS


;**** 8255初期化 ****
;*PORTC下位BITをOUTPUT、上位BITをINPUT、PORTBをINPUT、PORTAをOUTPUT
PIOINI	LDAA	#$8A
		STAA	PIOR			;PIOR <- $8A
		CLRA
		STAA	PIOA			;PIOA <- $00
		STAA	PIOC			;PIOC <- $00
		RTS
		

;------------------ コマンド送信、ファイルネーム送信 -----------------------
CSND	JSR		SNDBYTE			;Aレジスタのコマンドコードを送信
		JSR		RCVBYTE			;状態取得($00=OK)
		TSTA
		BNE		CSND2

		LDAB	#$20			;(X)からのファイル名32Byteを送信
CSND1	LDAA	X
		INX
		CMPA	#'"'			;ダブルコーテーション除去
		BEQ		CSND1
		JSR		SNDBYTE
		DECB
		BNE		CSND1
		CLRA
		JSR		SNDBYTE			;$00を送信
		JSR		RCVBYTE			;状態取得($00=OK)
CSND2	RTS
		

;------------------- 空白除去 ------------------------
SPDEL	INX
		LDAA	X
		CMPA	#' '			;最初のSPACEは除去
		BEQ		SPDEL
		RTS

;------------------- $除去 ------------------------
DLLDEL	LDAA	X
		CMPA	#'$'			;最初の$は除去
		BNE		DLDEL1
		INX
		BRA		DLLDEL
DLDEL1	RTS

;--------------- Aレジスタのアルファベット小文字を大文字に変換 ----------------
AZLCNV	CMPA	#$61			;a～zなら$20を引いてA～Zに変換
		BCS		AZ1
		CMPA	#$7B
		BCC		AZ1
		SUBA	#$20
AZ1		RTS

;--------------- 文字列出力 ----------------------
;(X)から$00までの文字列を表示
STRPRN
		LDAA	X				;A <- (X)
		CMPA	#$00			;$00なら終了
		BEQ		SP1
		JSR		PRINT			;1文字出力
		INX
		BRA		STRPRN
SP1		RTS

;-------------- (X)の16進数を文字列2桁で表示 ----------
PRHEX	JSR		HEX2AS
		JSR		PRINT
		TBA
		JSR		PRINT
		RTS


TITLE_MSG
		FCB		$0C
		FCC		/  ** JR-200_SD **/
		FCB		$0D,$0D,$00

SDMES	FCB		$0D
		FCC		/SD>/
		FCB		$FF

BSMSG	FCB		$0D
		FCC		/BASIC /
		FCB		$00

BNMSG	FCB		$0D
		FCC		/BINARY /
		FCB		$00

LDMSG	FCC		/LOADING /
		FCB		$00

SVMSG	FCC		/SAVE OK!/
		FCB		$00

MSGKEY	FCC		/SEL:0-9 NXT:ANY BCK:B BRK:RET/
		FCB		$0D,$00

MSG_F0
		FCC		/SD-CARD INITIALIZE ERROR/
		FCB		$0D,$00
		
MSG_F1
		FCC		/NOT FIND FILE/
		FCB		$0D,$00
		
MSG_F3
		FCC		/FILE EXIST/
		FCB		$0D,$00
	
MSG_F4
		FCC		/PROG FORMAT VERSION ERROR/
		FCB		$0D,$00
	
MSG99
		FCC		/ ERROR/
		FCB		$0D,$00

MSG_AD
		FCC		/ADDRESS ERROR/
		FCB		$0D,$00

MSG_CMD
		FCC		/COMMAND FAILED!/
		FCB		$0D
		FCC		/ !     : Return To Monitor/
		FCB		$0D
		FCC		/ LOAD  : Load From SD/
		FCB		$0D
		FCC		/ MEXEC : Binary Execute/
		FCB		$0D
		FCC		/ G     : Binary Execute/
		FCB		$0D
		FCC		/ SAVE  : Save To SD(BASIC)/
		FCB		$0D
		FCC		/ MSAVE : Save To SD(Binary)/
		FCB		$0D
		FCC		/ SDDIR : Find SD File/
		FCB		$0D,$00
	
MSG2_CMD
		FCC		/Syntax ERROR/
		FCB		$0D,$00
	
		END
