PIOA	EQU		$CC10
PIOB	EQU		$CC11
PIOC	EQU		$CC12
PIOR	EQU		$CC13

BSTA	EQU		$0004			;BASICプログラムスタートアドレス
BEND	EQU		$0006			;BASICプログラムエンドアドレス
HEND	EQU		$0008			;配列エンドアドレス
V2END	EQU		$000A			;2文字変数アドレス
SEND	EQU		$000C			;文字列変数アドレス
BTPNT	EQU		$001A			;BASICコマンドポインタ $F898
CTPNT	EQU		$001C			;BASICステートメントポインタ $F8C9

KBUF	EQU		$0030			;キーバッファ ～$0075(70Byte)
FLG		EQU		$00E3			;SD読込用 FLG 0:BASIC 1:マシン語
ADRS	EQU		$00E4			;SD読込用 開始アドレス
LENG	EQU		$00E6			;SD読込用 読込バイト数
XSAVE	EQU		$00E8			;Xレジスタ保存
XSAVE2	EQU		$00EA			;Xレジスタ保存
ADRSK	EQU		$00EC			;KSCN2 KTBL算出用/SD読込用 終了アドレス計算用
XSAVEK	EQU		$00EE			;KSCN2用 Xレジスタ保存
PRGVER	EQU		$00F0			;PROG形式バージョン
ADRS2	EQU		$00F2			;SD読込用 開始アドレス退避

KEYDAT	EQU		$C800			;キーデータ取得
KEYSEL	EQU		$C801			;Bit0-Bit3に0-8を出力して$C800のBit0-Bit4のデータを取得

BEEP	EQU		$F018			;BEEP
INPUT	EQU		$E4F2			;1文字入力(カーソルブリンク、エコーバックあり) A=キーデータ Bレジスタ破壊
KSCAN	EQU		$F7A9			;キー入力(エコーバックあり) A=キーデータ(何も押されていなければ$00) Bレジスタ破壊
SPC		EQU		$F3BA			;空白表示
PRINT	EQU		$F3BC			;1文字出力 A=アスキーコード Aレジスタ保存

;ソース内記述汎用ルーチン
;AZLCNV							;大文字変換 Aレジスタのアルファベット小文字を大文字に変換
;STRPRN							;文字列出力 (X)から$00までの文字列を表示
;PRHEX							;Aレジスタの内容を16進数文字列として表示
;SHEX2							;(X),(X+1)の2バイトアスキーコード文字列を16進数にしてAレジスタへ
;								;		'0'～'9','A'～'F'以外が含まれていたらA=0 C=1
;SHEX							;Aレジスタのアスキーコードを16進数にしてAレジスタへ
;								;		'0'～'9','A'～'F'以外ならA=0 C=1
;KSCN2							;キー入力(エコーバックなし) A=キーデータ(何も押されていなければ$00) Bレジスタ破壊
;								;		CTRLキー未対応

;A=USR($xxxx,X,A) 引値 第2パラメータ:Xレジスタ 第3パラメータ:Aレジスタ  戻り値:上位バイト:Bレジスタ 下位バイト:Aレジスタ

		ORG		$D000

		FCB		$00				;プリンタ制御ROMの有無識別コード
*
START
		JMP		INIT			;INITMコマンドジャンプ先
		JMP		DUMMY			;プリンタ一文字出力ジャンプ先
		JMP		INIT			;HCOPYコマンドジャンプ先
		JMP		LOAD
		JMP		BSAVE
		JMP		MSAVE
		JMP		FILES

INIT	STX		XSAVE			;コマンド文字列終了位置を保存
		JSR		PIOINI			;8255初期化

		LDAA	BTPNT
		CMPA	#$F8
		BNE		INI2
		LDX		#BTBL
		STX		BTPNT			;BASICコマンドポインタをBTBLに変更
		LDX		#CTBL
		STX		CTPNT			:BASICステートメントポインタをCBTLに変更
		LDX		#SDMSG			;'JR-100_SD READY OK!'
		BRA		INI3
INI2	STX		XSAVE			;コマンド文字列終了位置を保存
		LDX		#$F898
		STX		BTPNT			;BASICコマンドポインタを元に戻す
		LDX		#$F8C9
		STX		CTPNT			:BASICステートメントポインタを元に戻す
		LDX		#CMTMSG			;'CMT OK!'
INI3	JSR		STRPRN
		LDX		XSAVE
		RTS

DUMMY
		RTS

;----------------- BASICプログラム、機械語プログラム LOAD ---------------------------
LOAD
		LDAA	#$80			;コマンド$80を送信
		JSR		SNDBYTE			;Aレジスタのコマンドコードを送信
		JSR		RCVBYTE			;状態取得($00=OK)
		TSTA
		BNE		ERRJ

FN0		LDAB	#$20			;(X)からのファイル名32Byteを送信
FN1		LDAA	X
		INX
		CMPA	#'"'			;ダブルコーテーションは除去
		BEQ		FN1
		CMPA	#':'			;コロンだったら32Byte以下でも終了
		BEQ		FN10
		TSTA					;$00だったら32Byte以下でも終了
		BEQ		FN10
		JSR		SNDBYTE
		DECB
		BNE		FN1
		CLRA
		JSR		SNDBYTE			;$00を送信
		BRA		FN12

FN10	DEX
		STX		XSAVE			;コマンド文字列終了位置を保存
		CLRA
FN11	JSR		SNDBYTE			;32Byteに満たない分を$00送信
		DECB
		BNE		FN11
		JSR		SNDBYTE			;$00送信
		BRA		FN14

FN12	DEX
FN13	LDAA	X				;32Byteを超えてまだ文字列があるようなら':'又は$00が出てくるまでXレジスタを進める
		INX
		CMPA	#':'
		BNE		FN13
		TSTA
		BNE		FN13
		DEX
		STX		XSAVE			;コマンド文字列終了位置を保存

FN14
		JSR		RCVBYTE			;状態取得($00=OK)
		TSTA
		BNE		ERRJ
		BRA		FN2

ERRJ	JMP		ERR
		
FN2		JSR		RCVBYTE			;'P'
		JSR		RCVBYTE			;'R'
		JSR		RCVBYTE			;'O'
		JSR		RCVBYTE			;'G'
		JSR		RCVBYTE			;フォーマットバージョン受信
		CMPA	#$01
		BEQ		VER1			;フォーマットバージョン1
		CMPA	#$02
		BEQ		VER2			;フォーマットバージョン2
		LDAA	#$F4
		JMP		ERRJ			;フォーマットバージョンエラー

VER2	JMP		VER21
;------------------------- PROGフォーマットバージョン1形式LOAD ---------------------
VER1	JSR		RCVBYTE			;SKIP フォーマットバージョン 2nd Byte
		JSR		RCVBYTE			;SKIP フォーマットバージョン 3rd Byte
		JSR		RCVBYTE			;SKIP フォーマットバージョン 4th Byte
		JSR		RCVBYTE			;FNAME_SIZE 1stByte
		TAB
		JSR		RCVBYTE			;SKIP FNAME_SIZE 2ndByte
		JSR		RCVBYTE			;SKIP FNAME_SIZE 3rdByte
		JSR		RCVBYTE			;SKIP FNAME_SIZE 4thByte
		LDX		#KBUF			;SDから送られてきたファイル名を格納
LD1		JSR		RCVBYTE			;FNAME
		STAA	X
		INX
		DECB
		BNE		LD1
		CLRA
		STAA	X				;ファイル名の最後に$00を追加
		
		JSR		RCVBYTE			;読み込みアドレス 1stByte
		STAA	ADRS+1
		STAA	ADRS2+1
		JSR		RCVBYTE			;読み込みアドレス 2ndByte
		STAA	ADRS
		STAA	ADRS2
		JSR		RCVBYTE			;SKIP 3rdByte
		JSR		RCVBYTE			;SKIP 4thByte
		
		JSR		RCVBYTE			;読み込みByte数1st受信
		STAA	LENG+1
		JSR		RCVBYTE			;読み込みByte数2nd受信
		STAA	LENG
		JSR		RCVBYTE			;SKIP 3rd
		JSR		RCVBYTE			;SKIP 4th
		
		JSR		RCVBYTE			;FLAG 1stByte 0:BASIC 1:マシン語
		STAA	FLG

		TSTA
		BNE		LD2
		LDX		#BSMSG			;BASICプログラムLOAD表示
		JSR		STRPRN
		LDX		#LDMSG			;'LOADING '
		JSR		STRPRN
		LDX		#KBUF			;ファイル名
		JSR		STRPRN
		BRA		LD3
LD2		LDX		#BNMSG			;マシン語LOAD表示
		JSR		STRPRN
		LDX		#LDMSG			;'LOADING '
		JSR		STRPRN
		LDX		#KBUF			;ファイル名
		JSR		STRPRN
		LDAA	#'('
		JSR		PRINT
		LDAA	ADRS			;読み込み開始アドレス表示
		JSR		PRHEX
		LDAA	ADRS+1
		JSR		PRHEX

		LDAA	#'-'
		JSR		PRINT

		LDAA	LENG+1
		ADDA	ADRS+1
		STAA	ADRSK+1
		LDAA	LENG
		ADCA	ADRS
		STAA	ADRSK
		LDX		ADRSK
		DEX
		STX		ADRSK			;(ADRSK) <- 読み込み開始アドレス+読み込みByte数-1
		
		LDAA	ADRSK			;読み込み終了アドレス表示
		JSR		PRHEX
		LDAA	ADRSK+1
		JSR		PRHEX
		LDAA	#')'
		JSR		PRINT
LD3		LDX		#CRLF			;CRLF
		JSR		STRPRN

		JSR		RCVBYTE			;SKIP 2ndByte
		JSR		RCVBYTE			;SKIP 3rdByte
		JSR		RCVBYTE			;SKIP 4thByte

;------------------- 実データ受信 --------------------------------
LOP1	LDX		ADRS
		JSR		RCVBYTE			;1Byte受信
		STAA	X				;(X) <- A
		INX						;X <- X+1
		STX		ADRS
		
		LDX		LENG
		DEX
		STX		LENG			;(LENG) <- (LENG) -1
		BNE		LOP1			;(LENG)が0になるまでループ

		LDAA	FLG				;FLG CHECK 1(マシン語)なら終了
		TSTA
		BNE		LOP2
		
		LDX		ADRS			;0ならBASICパラメータをセット
		DEX
		STX		BEND			;BASICプログラムエンドアドレスセット
		INX
		STX		HEND			;配列エンドアドレスセット
		INX
		STX		V2END			;2文字変数アドレスセット
		INX
		STX		SEND			;文字列変数アドレスセット

LOP2	LDX		XSAVE			;コマンド文字列終了位置を復帰
		RTS

ERRV	LDAA	#$F4
		JMP		ERRJ

;------------------------- PROGフォーマットバージョン2形式LOAD ---------------------
VER21	JSR		RCVBYTE			;SKIP フォーマットバージョン 2nd Byte
		JSR		RCVBYTE			;SKIP フォーマットバージョン 3rd Byte
		JSR		RCVBYTE			;SKIP フォーマットバージョン 4th Byte
		JSR		RCVBYTE			;'P'
		JSR		RCVBYTE			;'N'
		JSR		RCVBYTE			;'A'
		JSR		RCVBYTE			;'M'
		JSR		RCVBYTE			;セクションSIZE 1stByte
		JSR		RCVBYTE			;セクションSIZE 2ndByte
		JSR		RCVBYTE			;セクションSIZE 3rdByte
		JSR		RCVBYTE			;セクションSIZE 4thByte

		JSR		RCVBYTE			;FNAME_SIZE 1stByte
		TAB
		JSR		RCVBYTE			;SKIP FNAME_SIZE 2ndByte
		JSR		RCVBYTE			;SKIP FNAME_SIZE 3rdByte
		JSR		RCVBYTE			;SKIP FNAME_SIZE 4thByte
		LDX		#KBUF			;SDから送られてきたファイル名を格納
LV1		JSR		RCVBYTE			;FNAME
		STAA	X
		INX
		DECB
		BNE		LV1
		CLRA
		STAA	X				;ファイル名の最後に$00を追加
		
		JSR		RCVBYTE			;SKIP 'P'
		JSR		RCVBYTE			;SKIP 'B'
		JSR		RCVBYTE			;'I' or 'A'
		TAB
		JSR		RCVBYTE			;SKIP 'N' or 'S'
		CMPB	#'I'
		BNE		LVBAS
;------------ PROGフォーマットバージョン2形式 BINARY LOAD ---------------------
LVBIN	LDAA	#$01
		STAA	FLG
		JSR		RCVBYTE			;セクションSIZE 1stByte
		JSR		RCVBYTE			;セクションSIZE 2ndByte
		JSR		RCVBYTE			;セクションSIZE 3rdByte
		JSR		RCVBYTE			;セクションSIZE 4thByte
		JSR		RCVBYTE			;読み込みアドレス 1stByte
		STAA	ADRS+1
		STAA	ADRS2+1
		JSR		RCVBYTE			;読み込みアドレス 2ndByte
		STAA	ADRS
		STAA	ADRS2
		JSR		RCVBYTE			;SKIP 3rdByte
		JSR		RCVBYTE			;SKIP 4thByte
		BRA		LV5

ERRV2	LDAA	#$F4
		JMP		ERRJ

;------------ PROGフォーマットバージョン2形式 BASIC LOAD ---------------------
LVBAS	CMPB	#'A'
		BNE		ERRV2
		CLRA
		STAA	FLG
		JSR		RCVBYTE			;セクションSIZE 1stByte
		JSR		RCVBYTE			;セクションSIZE 2ndByte
		JSR		RCVBYTE			;セクションSIZE 3rdByte
		JSR		RCVBYTE			;セクションSIZE 4thByte
		LDAA	#$02			;BASICなら読込開始アドレスは$0246固定
		STAA	ADRS+1
		STAA	ADRS2+1
		LDAA	#$46
		STAA	ADRS
		STAA	ADRS2
		
LV5		JSR		RCVBYTE			;読み込みByte数1st受信
		STAA	LENG+1
		JSR		RCVBYTE			;読み込みByte数2nd受信
		STAA	LENG
		JSR		RCVBYTE			;SKIP 3rd
		JSR		RCVBYTE			;SKIP 4th
		
		LDAA	FLG
		TSTA
		BNE		LV2
		LDX		#BSMSG			;BASICプログラムLOAD表示
		JSR		STRPRN
		LDX		#LDMSG			;'LOADING '
		JSR		STRPRN
		LDX		#KBUF			;ファイル名
		JSR		STRPRN
		BRA		LV3
LV2		LDX		#BNMSG			;マシン語LOAD表示
		JSR		STRPRN
		LDX		#LDMSG			;'LOADING '
		JSR		STRPRN
		LDX		#KBUF			;ファイル名
		JSR		STRPRN
		LDAA	#'('
		JSR		PRINT
		LDAA	ADRS			;読み込み開始アドレス表示
		JSR		PRHEX
		LDAA	ADRS+1
		JSR		PRHEX

		LDAA	#'-'
		JSR		PRINT

		LDAA	LENG+1
		ADDA	ADRS+1
		STAA	ADRSK+1
		LDAA	LENG
		ADCA	ADRS
		STAA	ADRSK
		LDX		ADRSK
		DEX
		STX		ADRSK			;(ADRSK) <- 読み込み開始アドレス+読み込みByte数-1
		
		LDAA	ADRSK			;読み込み終了アドレス表示
		JSR		PRHEX
		LDAA	ADRSK+1
		JSR		PRHEX
		LDAA	#')'
		JSR		PRINT
LV3		LDX		#CRLF			;CRLF
		JSR		STRPRN
		JMP		LOP1

ERR
		STX		XSAVE
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
		JSR		PRHEX
		LDX		#MSG99

ERRR	JSR		STRPRN
		LDX		XSAVE
		RTS

;--------------------- BASICプログラム SAVE ------------------------------------------
BSAVE
		LDAA	#$81			;コマンド$81を送信
		JSR		SNDBYTE			;Aレジスタのコマンドコードを送信
		JSR		RCVBYTE			;状態取得($00=OK)
		TSTA
		BNE		ERRJ2

		STX		XSAVE			;コマンド文字列終了位置を保存
		LDAB	#$20			;(X)からのファイル名32Byteを送信
BSV1	LDAA	X
		INX
		CMPA	#'"'			;ダブルコーテーションは除去
		BEQ		BSV1
		CMPA	#':'			;コロンなら$00にして送信
		BNE		BSV10
		CLRA
BSV10	JSR		SNDBYTE
		DECB
		BNE		BSV1
		CLRA
		JSR		SNDBYTE			;$00送信

		JSR		RCVBYTE			;状態取得($00=OK)
		TSTA
		BNE		ERRJ2			;$00以外ならエラー
		BRA		BSV2

ERRJ2	JMP		ERR
		
BSV2	CLRA
		JSR		SNDBYTE			;継続コード$00を送信
		BSR		FNSEND			;ファイルネームをPROG形式用に送信

		LDAA	BSTA+1			;BASICスタートアドレス下位バイトを送信
		JSR		SNDBYTE
		LDAA	BSTA			;BASICスタートアドレス上位バイトを送信
		JSR		SNDBYTE

		LDX		BSTA
		STX		ADRS			;BASICスタートアドレスを(ADRS)にコピー
		LDAA	BEND+1
		SUBA	BSTA+1
		STAA	LENG+1
		LDAA	BEND
		SBCA	BSTA
		STAA	LENG			;BASICエンドアドレス-BASICスタートアドレスを計算して(LENG)に格納
		LDX		LENG
		INX						;BEND - BSTART +1
		STX		LENG

		LDAA	LENG+1			;ファイルサイズ下位バイトを送信
		JSR		SNDBYTE
		LDAA	LENG			;ファイルサイズ上位バイトを送信
		JSR		SNDBYTE

		CLRA					;BASICプログラムであること(0)を送信
		JSR		SNDBYTE

		LDX		#SVMSG			;SAVE表示
		JSR		STRPRN

		BSR		BDSEND			;BASICプログラムを送信
		RTS

;------------------- ファイルネームをPROG形式用に送信 ----------------------
FNSEND	LDX		XSAVE			;コマンド文字列終了位置を復帰
		CLRB
FNS3	LDAA	X				;ファイルネーム文字数をカウント
		INX
		CMPA	#'"'			;ダブルコーテーションは飛ばす
		BEQ		FNS3
		INCB
		CMPA	#':'			;コロンが見つかったら終了
		BEQ		FNS4
		CMPA	#','			;コンマが見つかったら終了
		BEQ		FNS4
		TSTA					;$00が見つかったら終了
		BEQ		FNS4
		CMPB	#$11			;ファイルネームが16文字以上だったら終了
		BEQ		FNS4
		BRA		FNS3
FNS4	DECB
		TBA
		
		JSR		SNDBYTE			;FNAME_SIZE 1stByte
		LDX		XSAVE
FNS5	LDAA	X				;ファイルネーム文字数分のファイルネームを送信
		INX
		CMPA	#'"'			;ダブルコーテーションは飛ばす
		BEQ		FNS5
		JSR		SNDBYTE			;ファイルネーム文字数分を送信
		DECB
		BNE		FNS5
		
FNS6	LDAA	X				;ファイルネームが16文字以上だった場合、コンマ、コロン又は$00が見つかるまでコマンド文字列終了位置を修正
		INX
		CMPA	#':'
		BEQ		FNS7
		CMPA	#','
		BEQ		FNS7
		TSTA
		BEQ		FNS7
		BRA		FNS6
FNS7	DEX
		STX		XSAVE
		RTS

;----------- (ADRS)から(LENG)バイトを送信 -----------------------
BDSEND	LDX		ADRS			;ファイルサイズ分を送信
		LDAA	X				;A <- (ADRS)
		JSR		SNDBYTE			;1Byte送信
		INX						;X <- X+1
		STX		ADRS			;(ADRS) <- (ADRS)+1
		
		LDX		LENG			;X <- (LENG)
		DEX						;X <- X-1
		STX		LENG			;(LENG) <- (LENG)-1
		BNE		BDSEND			;(LENG)が0になるまでループ
		RTS

;------------------ 機械語プログラムをSAVE ------------------------
MSAVE
		LDAA	#$81			;コマンド$81を送信
		JSR		SNDBYTE			;Aレジスタのコマンドコードを送信
		JSR		RCVBYTE			;状態取得($00=OK)
		TSTA
		BNE		ERRJ3

		STX		XSAVE			;コマンド文字列終了位置を保存
		LDAB	#$20			;(X)からのファイル名32Byteを送信
MSV1	LDAA	X
		INX
		CMPA	#'"'			;ダブルコーテーションは除去
		BEQ		MSV1
		CMPA	#':'			;コロンなら$00にして送信
		BEQ		MSV2
		CMPA	#','			;コンマなら$00にして送信
		BEQ		MSV2
		BRA		MSV10
MSV2	CLRA
MSV10	JSR		SNDBYTE
		DECB
		BNE		MSV1
		CLRA
		JSR		SNDBYTE			;$00送信

		JSR		RCVBYTE			;状態取得($00=OK)
		TSTA
		BNE		ERRJ3			;$00以外ならエラー
		BRA		MSV3

ERRJ3	JMP		ERR
		
MSV3	LDX		XSAVE			;コマンド文字列終了位置を復帰
MSV4	LDAA	X				;ファイルネーム部分を読み飛ばし
		INX
		CMPA	#':'			;コロンが見つかったら終了
		BEQ		MSV5
		CMPA	#','			;コンマが見つかったら終了
		BEQ		MSV5
		TSTA					;$00が見つかったら終了
		BEQ		MSV5
		BRA		MSV4
MSV5	LDAA	X
		CMPA	#'$'			;'$'は読み飛ばす
		BNE		MSV6
		INX
MSV6	JSR		SHEX2			;16進数2桁のアスキーコードを16進数に変換
		BCS		ERRJ4			;16進数2桁を表すアスキーコードで無ければエラー
		STAA	ADRS			;開始アドレス上位バイトにセット
		JSR		SHEX2			;16進数2桁のアスキーコードを16進数に変換
		BCS		ERRJ4			;16進数2桁を表すアスキーコードで無ければエラー
		STAA	ADRS+1			;開始アドレス下位バイトにセット
		LDAA	X
		CMPA	#','			;コンマは読み飛ばす
		BNE		MSV8
		INX
MSV8	LDAA	X
		CMPA	#'$'			;'$'は読み飛ばす
		BNE		MSV9
		INX
MSV9	JSR		SHEX2			;16進数2桁のアスキーコードを16進数に変換
		BCS		ERRJ4			;16進数2桁を表すアスキーコードで無ければエラー
		STAA	LENG			;終了アドレス上位バイトにセット
		JSR		SHEX2			;16進数2桁のアスキーコードを16進数に変換
		BCS		ERRJ4			;16進数2桁を表すアスキーコードで無ければエラー
		STAA	LENG+1			;終了アドレス下位バイトにセット
		STX		XSAVE2			;コマンド文字列終了位置を保存

		LDAA	LENG+1
		SUBA	ADRS+1
		STAA	LENG+1
		LDAA	LENG
		SBCA	ADRS
		BCS		ERRJ4
		STAA	LENG			;終了アドレス-開始アドレスを計算して(LENG)に格納
		LDX		LENG
		INX						;LENG - ADRS +1
		STX		LENG

		CLRA
		JSR		SNDBYTE			;継続コード$00を送信
		JSR		FNSEND			;ファイルネームをPROG形式用に送信

		LDAA	ADRS+1			;BASICスタートアドレス下位バイトを送信
		JSR		SNDBYTE
		LDAA	ADRS			;BASICスタートアドレス上位バイトを送信
		JSR		SNDBYTE

		LDAA	LENG+1			;ファイルサイズ下位バイトを送信
		JSR		SNDBYTE
		LDAA	LENG			;ファイルサイズ上位バイトを送信
		JSR		SNDBYTE

		LDAA	#$01			;機械語プログラムであること(1)を送信
		JSR		SNDBYTE

		LDX		#SVMSG			;SAVE表示
		JSR		STRPRN

		JSR		BDSEND			;機械語データを送信
		RTS

ERRJ4
		LDAA	#$FF			;打ち切りコードを送信
		JSR		SNDBYTE
		LDX		#MSG_AD			;アドレスエラー表示
		JSR		STRPRN
		LDX		XSAVE
		RTS

;------------------ SDファイル一覧表示 ---------------------------
ERRJ5	JMP		ERR				;ERROR処理へジャンプ

FILES
*「SDIR」処理
SDIR_PRG
		LDAA	#$82			;コマンド$82を送信
		JSR		SNDBYTE			;Aレジスタのコマンドコードを送信
		JSR		RCVBYTE			;状態取得(00H=OK)
		TSTA
		BNE		ERRJ5			;ERROR

		STX		XSAVE			;コマンド文字列終了位置を保存
		LDAB	#$20			;(X)からのファイル名32Byteを送信
SDR1	LDAA	X
		INX
		CMPA	#'"'			;ダブルコーテーションは除去
		BEQ		SDR1
		CMPA	#':'			;コロンなら$00にして送信
		BEQ		SDR2
		CMPA	#','			;コンマなら$00にして送信
		BEQ		SDR2
		BRA		SDR10
SDR2	CLRA
SDR10	JSR		SNDBYTE			;1文字送信
		DECB
		BNE		SDR1
		CLRA
		JSR		SNDBYTE			;$00送信
		STX		XSAVE			;コマンド文字列終了位置を保存

		JSR		RCVBYTE			;状態取得($00=OK)
		TSTA
		BNE		ERRJ5			;$00以外ならエラー
		
DL1		LDX		#KBUF			;Arduinoから送られてくる文字列を#KBUFへ格納
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
		LDAA	#$0A
		STAA	X
		INX
		
		CLRA
		STAA	X
		INX
		LDX		#KBUF
		JSR		STRPRN			;1行表示
DL33	BRA		DL1

DL4		JSR		RCVBYTE			;状態取得(00H=OK)して終了
		LDX		XSAVE
		RTS

DL9		LDX		#KBUF			;文字列を取得
DL91	JSR		RCVBYTE			;#KBUFへ文字列格納
		JSR		AZLCNV			;大文字に変換
		STAA	X
		INX
		TSTA					;$00を受信するまで受信処理
		BNE		DL91
;		LDX		#KBUF
;		JSR		STRPRN
		JSR		RCVBYTE			;$FF終了コード読み飛ばし
		JSR		RCVBYTE			;状態取得読み飛ばし
		LDX		#KBUF
		LDAA	#$80			;コマンド$80を送信、そのままLOADコマンド実行
		JSR		SNDBYTE			;Aレジスタのコマンドコードを送信
		JSR		RCVBYTE			;状態取得($00=OK)
		TSTA
		BNE		ERRJ6			;ERRORになるはずはないが念のため
		JMP		FN0
		
DL5		STX		XSAVE2
		LDX		#MSGKEY			;SEL:0-9 NXT:ANY BCK:B BRK:RET
		JSR		STRPRN			;文字列表示
		LDX		XSAVE2
DL6		JSR		KSCN2			;キーボートスキャン
		TSTA
		BEQ		DL6				;何か入力されるまでループ
		PSHA
		JSR		BEEP
		PULA
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
		JMP		DL2
		
SDIR99	RTS
ERRJ6	JMP		ERR

;--------------- MEXECUTE 機械語読み込みアドレスを実行アドレスとしてジャンプ -------
MEXEC	LDX		ADRS2
		JMP		X

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

;------------------- Aレジスタの内容を16進数文字列として表示 -------------------------
PRHEX	PSHA
		ANDA	#$F0			;上位4ビットを変換
		LSRA
		LSRA
		LSRA
		LSRA
		BSR		PRHX1
		PULA
		ANDA	#$0F			;下位4ビットを変換
		BSR		PRHX1
		RTS
		
PRHX1	CMPA	#$0A
		BCS		PH2
		ADDA	#$37			;A～F
		BRA		PH3
PH2		ADDA	#$30			;0～9
PH3		JSR		PRINT
		RTS
		

;----- (X),(X+1)の2バイトアスキーコード文字列を16進数にしてAレジスタへ -----------------
;                          '0'～'9','A'～'F'以外が含まれていたらA=0 C=1
SHEX2	LDAA	X
		BSR		SHEX
		BCS		SH21			;ERRORなら中断
		TAB
		ASLB
		ASLB
		ASLB
		ASLB					;Bレジスタに送って16倍
		INX
		LDAA	X
		BSR		SHEX
		BCS		SH21			;ERRORなら中断
		ABA						;Bレジスタを加算
		INX
SH21	RTS

;----------------- Aレジスタのアスキーコードを16進数にしてAレジスタへ  --------------------
;                          '0'～'9','A'～'F'以外ならA=0 C=1
SHEX	CMPA	#'0'
		BCS		SH2
		CMPA	#':'
		BCS		SH1
		CMPA	#'A'
		BCS		SH2
		CMPA	#'G'
		BCS		SH3
		BRA		SH2
		
SH1		SUBA	#$30			;0～9
		BRA		SH4
SH2		CLRA					;ERROR
		SEC
		BRA		SH4
SH3		SUBA	#$37			;A～F
SH4		RTS

;--------- キー入力(エコーバックなし) A=キーデータ(何も押されていなければ$00) Bレジスタ破壊 CTRLキー未対応 --------
KSCN2	STX		XSAVEK
		LDX		#KEYDAT
		CLRB
KSC0	TBA
		STAA	1,X				;KEYSEL($C801)に出力
		LDAA	X				;KEYDAT($C800)のデータを取得
		ANDA	#$1F
		CMPA	#$1F			;何か押されている？
		BNE		KSC1
		INCB					;押されていなければ次のスキャン
		CMPB	#$09			;$00～$08まで検査
		BNE		KSC0
		CLRA					;何も押されていなければ$00でリターン
		BRA		KSC15

KSC1	PSHA					;何か押されていた時の処理
		ASLB					;B <- B*8
		ASLB
		ASLB
		LDX		#KTBL
		STX		ADRSK			;(ADRSK) <- KTBL
		LDAA	ADRSK+1
		ABA
		STAA	ADRSK+1
		LDAA	ADRSK
		ADCA	#$00
		STAA	ADRSK			;(ADRSK) <- (ADRSK) + B
		PULA
		LDX		ADRSK
		ASRA
		BCC		KSC2
		ASRA
		BCC		KSC3
		ASRA
		BCC		KSC4
		ASRA
		BCC		KSC5
		ASRA
		BCC		KSC6
KSC2	LDAA	X				;D0列を取得
		BRA		KSC15
KSC3	LDAA	1,X				;D1列を取得
		CMPA	#$FF			;SHIFTキーが押されていたらもう一度スキャン
		BEQ		KSC7
		BRA		KSC15
KSC4	LDAA	2,X				;D2列を取得
		BRA		KSC15
KSC5	LDAA	3,X				;D3列を取得
		BRA		KSC15
KSC6	LDAA	4,X				;D4列を取得

KSC15	LDX		XSAVEK
		RTS

KSC7	LDX		#KEYDAT			;SHIFTキーが押されていた時のスキャン
		LDAB	#$01
KSC8	TBA
		STAA	1,X				;KEYSEL($C801)に出力
		LDAA	X				;KEYDAT($C800)のデータを取得
		ANDA	#$1F
		CMPA	#$1F			;何か押されている？
		BNE		KSC9
		INCB					;押されていなければ次のスキャン
		CMPB	#$09			;$00～$08まで検査
		BNE		KSC8
		CLRA					;SHIFTキー以外押されていなければ$00でリターン
		BRA		KSC15
KSC9	PSHA					;SHIFTキー以外押されていた時の処理
		ASLB					;B <- B*8
		ASLB
		ASLB
		LDX		#KTBL2
		STX		ADRSK			;(ADRSK) <- KTBL2
		LDAA	ADRSK+1
		ABA
		STAA	ADRSK+1
		LDAA	ADRSK
		ADCA	#$00
		STAA	ADRSK			;(ADRSK) <- (ADRSK) + B
		PULA
		LDX		ADRSK
		ASRA
		BCC		KSC10
		ASRA
		BCC		KSC11
		ASRA
		BCC		KSC12
		ASRA
		BCC		KSC13
		ASRA
		BCC		KSC14
KSC10	LDAA	X				;D1列を取得
		BRA		KSC15
KSC11	LDAA	1,X				;D1列を取得
		BRA		KSC15
KSC12	LDAA	2,X				;D2列を取得
		BRA		KSC15
KSC13	LDAA	3,X				;D3列を取得
		BRA		KSC15
KSC14	LDAA	4,X				;D4列を取得
		BRA		KSC15

;--------------- KEY TABLE -------------------------
KTBL	FCB		$00,$FF,'Z','X','C',$00,$00,$00
		FCB		'A','S','D','F','G',$00,$00,$00
		FCB		'Q','W','E','R','T',$00,$00,$00
		FCB		'1','2','3','4','5',$00,$00,$00
		FCB		'6','7','8','9','0',$00,$00,$00
		FCB		'Y','U','I','O','P',$00,$00,$00
		FCB		'H','J','K','L',';',$00,$00,$00
		FCB		'V','B','N','M',$2C,$00,$00,$00
		FCB		'.',' ',':',$0D,'-',$00,$00,$00
		
;--------------- SHIFT用 KEY TABLE ------------------
KTBL2	FCB		$00,$00,$00,$00,$00,$00,$00,$00
		FCB		$00,$00,$00,$00,$00,$00,$00,$00
		FCB		$00,$00,$00,$00,$00,$00,$00,$00
		FCB		'!','"','#','$','%',$00,$00,$00
		FCB		'&',$27,')','(','^',$00,$00,$00
		FCB		$00,'@','\','[',']',$00,$00,$00
		FCB		$00,$00,'?','/','+',$00,$00,$00
		FCB		$00,$00,$00,'-','<',$00,$00,$00
		FCB		'>',' ','*',$0D,'=',$00,$00,$00
		
;--------------- MESSAGE -------------------------
SDMSG	FCC		/JR-100_SD READY OK!/
		FCB		$0A,$0D,$00

CMTMSG	FCC		/CMT OK!/
		FCB		$0A,$0D,$00

BSMSG	FCB		$0A,$0D
		FCC		/BASIC /
		FCB		$00

BNMSG	FCB		$0A,$0D
		FCC		/BINARY /
		FCB		$00

LDMSG	FCC		/LOADING /
		FCB		$00

SVMSG	FCB		$0A,$0D
		FCC		/SAVEING/
		FCB		$0A,$0D,$00

CRLF	FCB		$0A,$0D,$00

MSG_F0
		FCC		/SD-CARD INITIALIZE ERROR/
		FCB		$0D,$0A,$00
		
MSG_F1
		FCC		/NOT FIND FILE/
		FCB		$0D,$0A,$00
		
MSG_F3
		FCC		/FILE EXIST/
		FCB		$0D,$0A,$00
	
MSG_F4
		FCC		/PROG FORMAT VERSION ERROR/
		FCB		$0D,$0A,$00
	
MSG99
		FCC		/ ERROR/
		FCB		$0D,$0A,$00

MSG_AD
		FCC		/ADDRESS ERROR/
		FCB		$0D,$0A,$00
	
MSGKEY	FCC		/SEL:0-9 NXT:ANY BCK:B BRK:RET/
		FCB		$0D,$0A,$00

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


**** 8255初期化 ****
*PORTC下位BITをOUTPUT、上位BITをINPUT、PORTBをINPUT、PORTAをOUTPUT
PIOINI	LDAA	#$8A
		STAA	PIOR			;PIOR <- $8A
		CLRA
		STAA	PIOA			;PIOA <- $00
		STAA	PIOC			;PIOC <- $00
		RTS


;---------------------- BASICコマンドテーブルを再定義 ------------------
BTBL
		FDB		$E439
		
		FCC		/LIS/
		FCB		'T'+$80
		FDB		$F3C2

		FCC		/RU/
		FCB		'N'+$80
		FDB		$E6AB

		FCC		/RESE/
		FCB		'T'+$80
		FDB		$E400

		FCC		/AUT/
		FCB		'O'+$80
		FDB		$E526

		FCC		/NE/
		FCB		'W'+$80
		FDB		$E41E

		FCC		/LLIS/
		FCB		'T'+$80
		FDB		$F3BF

		FCC		/FIND/
		FCB		'"'+$80
		FDB		$F120

		FCC		/CON/
		FCB		'T'+$80
CTBL
		FDB		$F21E

		FCC		/LE/
		FCB		'T'+$80
		FDB		$F26E

		FCC		/I/
		FCB		'F'+$80
		FDB		$E67B

		FCC		/GOT/
		FCB		'O'+$80
		FDB		$F255
		
		FCC		/GOSU/
		FCB		'B'+$80
		FDB		$F256
		
		FCC		/RE/
		FCB		'T'+$80
		FDB		$F22A
		
		FCC		/NEX/
		FCB		'T'+$80
		FDB		$F2F8
		
		FCC		/FO/
		FCB		'R'+$80
		FDB		$F294
		
		FCC		/THE/
		FCB		'N'+$80
		FDB		$F1FD
		
		FCC		/POK/
		FCB		'E'+$80
		FDB		$EF38
		
		FCC		/REA/
		FCB		'D'+$80
		FDB		$F08B
		
		FCC		/DAT/
		FCB		'A'+$80
		FDB		$F033
		
		FCC		/LOCAT/
		FCB		'E'+$80
		FDB		$F19F
		
		FCC		/PIC/
		FCB		'K'+$80
		FDB		$EF63
		
		FCC		/RESTOR/
		FCB		'E'+$80
		FDB		$F0F3
		
		FCC		/RE/
		FCB		'M'+$80
		FDB		$E652
		
		FCC		/PRIN/
		FCB		'T'+$80
		FDB		$E758

		FCC		/INPU/
		FCB		'T'+$80
		FDB		$F33A

		FCC		/DI/
		FCB		'M'+$80
		FDB		$EC9A

		FCC		/CLEA/
		FCB		'R'+$80
		FDB		$E426

		FCC		/STO/
		FCB		'P'+$80
		FDB		$E545

		FCC		/EN/
		FCB		'D'+$80
		FDB		$E5A3

		FCC		/LPRIN/
		FCB		'T'+$80
		FDB		$E756

		FCC		/OPTIO/
		FCB		'N'+$80
		FDB		$EFEA

		FCC		/BEEP/
		FCB		'0'+$80
		FDB		$F021

		FCC		/BEEP/
		FCB		'1'+$80
		FDB		$F000

		FCC		/BEE/
		FCB		'P'+$80
		FDB		$F018

		FCC		/HCOP/
		FCB		'Y'+$80
		FDB		$E504

		FCC		/LOA/
		FCB		'D'+$80
;		FDB		$F4EF
		FDB		LOAD

		FCC		/MEXE/
		FCB		'C'+$80
;		FDB		$F4E3
		FDB		MEXEC

		FCC		/SAV/
		FCB		'E'+$80
;		FDB		$F508
		FDB		BSAVE
		
		FCC		/MSAVE/
		FCB		'"'+$80
;		FDB		$F517
		FDB		MSAVE

		FCC		/VERIF/
		FCB		'Y'+$80
		FDB		$F4FC

		FCC		/CL/
		FCB		'S'+$80
		FDB		$F47C

		FCC		/SDDI/
		FCB		'R'+$80
		FDB		FILES
		
		FCB		$FF
		FDB		$F26E

		FCC		/RND/
		FCB		'('+$80
		FDB		$EB2C

		FCC		/ABS/
		FCB		'('+$80
		FDB		$E95C

		FCC		/MOD/
		FCB		'('+$80
		FDB		$EB0C

		FCC		/ASC/
		FCB		'('+$80
		FDB		$EFB7

		FCC		/FRE/
		FCB		'('+$80
		FDB		$EF6F

		FCC		/PEEK/
		FCB		'('+$80
		FDB		$EF4D

		FCC		/SGN/
		FCB		'('+$80
		FDB		$EF74

		FCC		/LEN/
		FCB		'('+$80
		FDB		$EFAB

		FCC		/VPOS/
		FCB		'('+$80
		FDB		$F185

		FCC		/HPOS/
		FCB		'('+$80
		FDB		$F175

		FCC		/USR/
		FCB		'('+$80
		FDB		$EB41

		FCC		/VAL/
		FCB		'('+$80
		FDB		$EFBF

		FCB		$FF
		FDB		$EAA5
				
		FCC		/T/
		FCB		'O'+$80
		FDB		$1234

		FCC		/STE/
		FCB		'P'+$80
		FDB		$ABCD

		FCC		/SPC/
		FCB		'('+$80
		FDB		$EF95

		FCC		/TAB/
		FCB		'('+$80
		FDB		$E78F

		FCC		/FLD/
		FCB		'('+$80
		FDB		$EFD3
		
		FCB		$FF
		FDB		$E7C4

		FCC		/HEX$/
		FCB		'('+$80
		FDB		$F147

		FCC		/CHR$/
		FCB		'('+$80
		FDB		$F1EC

		FCC		/LEFT$/
		FCB		'('+$80
		FDB		$EE80

		FCC		/RIGHT$/
		FCB		'('+$80
		FDB		$EE88

		FCC		/MID$/
		FCB		'('+$80
		FDB		$EEA2
		
		FCB		$FF
		FDB		$EEEF

		FCC		/CMODE/
		FCB		'0'+$80
		FDB		$EFF7

		FCC		/CMODE/
		FCB		'1'+$80
		FDB		$EFFA

		FCC		/OVF/
		FCB		'0'+$80
		FDB		$EFF0

		FCC		/OVF/
		FCB		'1'+$80
		FDB		$EFF3
		
		FCB		$FF
		FDB		$EAFD

;------------------ MEMORY EDIT ----------------------------
		ORG		$DD00
		
		STX		ADRS
ME8		LDAA	ADRS
		JSR		PRHEX
		LDAA	ADRS+1
		JSR		PRHEX
		JSR		SPC
		
ME0		BSR		ME1
		BCS		ME6
		TAB
		ASLB
		ASLB
		ASLB
		ASLB					;Bレジスタに送って16倍
		PSHB
		BSR		ME1
		PULB
		BCS		ME6
		ABA
		STAA	X
		INX
		STX		ADRS
		LDAA	ADRS+1
		ANDA	#$07			;次のアドレスが$xxx0又は$xxx8のなら改行してアドレス表示へ
		TSTA
		BEQ		ME7
		JSR		SPC				;次のアドレスが$xxx0又は$xxx8でないなら空白1文字表示
		LDX		ADRS
		BRA		ME0
ME7		LDX		#CRLF
		JSR		STRPRN			;改行
		LDX		ADRS
		BRA		ME8

ME1		JSR		INPUT
		CMPA	#$30
		BCS		ME2
		CMPA	#$3A
		BCS		ME3
		CMPA	#$41
		BCS		ME2
		CMPA	#$47
		BCS		ME4
ME2		CMPA	#$0D
		BEQ		ME5
		LDAA	#$08
		JSR		PRINT
		BRA		ME1
ME3		SUBA	#$30
		RTS
ME4		SUBA	#$37
		RTS
ME5		SEC
		RTS
ME6		RTS

;------------------ MEMORY DUMP USR関数第2パラメータ(Xレジスタ)のアドレスからダンプ -----------------
		ORG		$DE00

		STX		ADRS			;16進コード表示用カウンタ
		STX		LENG			;ASCIIコード表示用カウンタ
		
DPS		LDAB	#$08			;8行を表示
DP0		PSHB
		LDX		ADRS
		LDAA	ADRS			;アドレスを表示
		JSR		PRHEX
		LDAA	ADRS+1
		JSR		PRHEX
		JSR		SPC				;空白表示
		
		LDAB	#$08			;8Byte分を1行表示
DP1		LDAA	X
		JSR		PRHEX			;Aレジスタを16進2桁で表示
		INX
		DECB
		BNE		DP1				;ループ
		STX		ADRS			;1行分最終アドレスを退避
		
		JSR		SPC				;空白表示

		LDX		LENG
		LDAB	#$08			;8Byte分
DP2		LDAA	X
		CMPA	#$20			;$20以下なら'.'($2E)に置き換え
		BCC		DP3
		LDAA	#$2E
DP3		JSR		PRINT
		INX
		DECB
		BNE		DP2
		STX		LENG			;1行分最終アドレスを退避
		
		LDX		#CRLF
		JSR		STRPRN			;改行
		PULB
		DECB
		BNE		DP0				;ループ
		
		LDX		#DPMES			;継続指示メッセージ
		JSR		STRPRN
DP4		JSR		KSCN2			;キー入力待ち
		TSTA
		BEQ		DP4
		CMPA	#' '			;スペースなら次ページ
		BEQ		DPS
		CMPA	#'N'			;'N'なら次ページ
		BEQ		DPS
		CMPA	#'B'			;'B'なら前ページ
		BEQ		DP6
		RTS

DP6		LDAA	ADRS+1			;'B'キーが押されたら(ADRS) <- (ADRS) - $80を計算して格納
		SUBA	#$80
		STAA	ADRS+1
		STAA	LENG+1
		BCC		DP7
		LDAA	ADRS
		DECA
		STAA	ADRS
		STAA	LENG
DP7		BRA		DPS

DPMES	
		FCC		/- NEXT:SPACE BACK:B CANSEL:ANY -/
		FCB		$0D,$0A,$00

;------------------ MEMORY TEST ----------------------------
		ORG		$DF00
		
		LDX		BSTA			;テスト開始アドレス
		STX		ADRS

MEM1	LDX		#CRLF
		JSR		STRPRN

		LDAA	ADRS			;アドレスを表示
		JSR		PRHEX
		LDAA	ADRS+1
		JSR		PRHEX

		JSR		SPC

		LDX		ADRS
		LDAA	#$55			;$55を書き込み
		STAA	X

		JSR		PRHEX
		JSR		SPC

		LDAA	X				;読み出し
		TAB
		JSR		PRHEX
		TBA

		CMPA	#$55			;読出しが$55でなければエラー
		BNE		MSTP

		JSR		SPC

		LDAA	#$AA			;$AAを書き込み
		STAA	X

		JSR		PRHEX
		JSR		SPC

		LDAA	X				;読出し
		TAB
		JSR		PRHEX
		TBA

		CMPA	#$AA			;読出しが$AAでなければエラー
		BNE		MSTP
		INX
		STX		ADRS
		BRA		MEM1			;ループ

MSTP	LDX		#MEMSTP			;STOPメッセージ
		JSR		STRPRN
		RTS

MEMSTP	
		FCB		$0D,$0A
		FCC		/MEMORY TEST STOP!/
		FCB		$0D,$0A,$00
		
		END
