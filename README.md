# National JR-100にSD-CARDとのロード、セーブ機能

![JR-100_SD](https://github.com/yanataka60/JR-100_SD/blob/main/JPEG/TITLE.jpg)

　JR-100でSD-CARDからPROG形式ファイルのロード、セーブ機能を実現するものです。

　CMTからの読み込み実行に数分掛かっていたゲームも数十秒で実行できます。

　接続は、JR-100本体後ろの拡張端子に直接挿して使います。

　なお、Arduino、ROM、GALへ書き込むための機器が別途必要となります。

　オプションとしてジョイスティックポート、拡張RAM($4000～$7FFF)も装備できます。

### 2025.2.26 PIOに6821を使ったRev2.1ではPIOアクセス時の画面ノイズが発生しないので6821版を正式版とし、8255版は8255フォルダに移動しました。なお、開発に使用した3台のJR-100では6821版、8255版ともに安定動作していますが、8255版は動作不安定であると報告された機体でも6821版は安定動作しているとの動作報告がありました。

## 回路図
　KiCadフォルダ内のJR-100_SD.pdfを参照してください。

[回路図](https://github.com/yanataka60/JR-100_SD/blob/main/Kicad/JR-100_SD.pdf)

![JR-100_SD](https://github.com/yanataka60/JR-100_SD/blob/main/Kicad/JR-100_SD_1.jpg)

## 部品
|番号|品名|数量|備考|
| ------------ | ------------ | ------------ | ------------ |
|J1(J2)|50Pカードエッジコネクタ|1|せんごくネット通販 HRS CR22A-50D-2.54DSなど|
|J4|コネクタ 2Pin|1|ピンヘッダで代用するときはGNDと間違えないよう1Pinで5Vだけにしたほうが良い|
|J5|DCジャック|1|秋月電子通商 MJ-179PHなど|
||J6、J7のいずれか|||
|J6|Micro_SD_Card_Kit|1|秋月電子通商 AE-microSD-LLCNV (注1) (注2)|
|J7|MicroSD Card Adapter|1|Arduino等に使われる5V電源に対応したもの (注2)|
|U1|GAL22V10|1||
|U3|ROM 2764/28C64相当品|1||
|U5|6821|1|若松通商 HD46821P等|
|U6|Arduino_Pro_Mini_5V|1|Atmega328版を使用 168版は不可。(注3)|
|C1,C2,C5|積層セラミックコンデンサ 0.1uF|3||
|C6|電解コンデンサ 16v100uF|1||
|S1|3Pスライドスイッチ|1|秋月電子通商 SS12D01G4など|
||ピンヘッダ|2Pin分|Arduino_Pro_MiniにはA4、A5用のピンヘッダが付いていないため別途調達が必要です 秋月電子通商 PH-1x40SGなど|
||ピンソケット(任意)|26Pin分|Arduino_Pro_Miniを取り外し可能としたい場合に調達します 秋月電子通商 FHU-1x42SGなど|

JR-100_SDに外部から電源を供給する場合
|番号|品名|数量|備考|
| ------------ | ------------ | ------------ | ------------ |
||ACアダプター 5V|1|秋月電子通商 M050200-A010JPなど|

RAM($4000～$7FFF)を拡張する場合
|番号|品名|数量|備考|
| ------------ | ------------ | ------------ | ------------ |
|U4|RAM 62256相当品|1||
|C3|積層セラミックコンデンサ 0.1uF|1||

ジョイスティックポートを付ける場合
|番号|品名|数量|備考|
| ------------ | ------------ | ------------ | ------------ |
|J3|D-SUB 9Pオス基板取付型|1|マルツ 3223DB9RP1S2など|
|U2|74LS366|1||
|C4|積層セラミックコンデンサ 0.1uF|1||
|R1-R5|10KΩ|5||

リセットスイッチを使う場合
|番号|品名|数量|備考|
| ------------ | ------------ | ------------ | ------------ |
|SW1|タクトスイッチ|1|秋月電子通商 DTS-63-N-Vなど|
|J8|コネクタ 1Pin|1|リセット用ご自分の環境に合わせてください|

　　　注1)秋月電子通商　AE-microSD-LLCNVのJ1ジャンパはショートしてください。

　　　注2)J6又はJ7のどちらかを選択して取り付けてください。

### 　　注3)Arduino Pro MiniはA4、A5ピンも使っています。

### MicroSD Card Adapterを使う
　J7に取り付けます。

　MicroSD Card Adapterについているピンヘッダを除去してハンダ付けするのが一番確実ですが、J4の穴にMicroSD Card Adapterをぴったりと押しつけ、裏から多めにハンダを流し込むことでハンダ付けをする方法もあります。なお、この方法の時にはしっかりハンダ付けが出来たかテスターで導通を確認しておいた方が安心です。

　ハンダ付けに自信のない方はJ2の秋月電子通商　AE-microSD-LLCNVをお使いください。AE-microSD-LLCNVならパワーLED、アクセスLEDが付いています。

![MicroSD Card Adapter](https://github.com/yanataka60/JR-100_SD/blob/main/JPEG/MicroSD%20Card%20Adapter.JPG)

## ROMへの書込み
　ROMフォルダ内のSD.binをROMライター(TL866II Plus等)を使って2764又は28C64に書き込みます。

　2764(8KByteROM)を使っていますが、JR-100_SDからアクセスされるのは4KByte分です。

## Arduinoプログラム
　Arduino IDEを使ってArduinoフォルダのJR-100_SDフォルダ内JR-100.inoを書き込みます。

　SdFatライブラリを使用しているのでArduino IDEメニューのライブラリの管理からライブラリマネージャを立ち上げて「SdFat」をインストールしてください。

　「SdFat」で検索すれば見つかります。「SdFat」と「SdFat - Adafruit Fork」が見つかりますが「SdFat」のほうを使っています。

注)Arduinoを基板に直付けしている場合、Arduinoプログラムを書き込むときは、JR-100本体とは接続を外し、GAL22V10を外したうえで書き込んでください。

## GALへの書込み
　Wincuplフォルダ内のJR100.jedをROMライター(TL866II Plus等)を使ってGAL22V10に書き込みます。

#### ~~2025.1.20 8255が正常にアクセスできない個体があると報告がありましたので修正しました。以前のプログラムで正常に動作していれば書き込み直す必要はありません。~~

## 接続
　JR-100本体後ろの拡張端子に挿し込みます。

![JR-100_SD Back](https://github.com/yanataka60/JR-100_SD/blob/main/JPEG/JR-100_SD(5).jpg)

## 電源の供給
　JR-100の拡張端子には+5Vが出ていないため、JR-100_SDには別途電源を供給する必要があります。

　私は純正の電源アダプタではなく、別に入手したスイッチング電源を使用しているため、内部電源として本体内の+5Vが供給されているピンから線を引き出してJR-100_SDに供給しています。

　純正の電源アダプタを使用している方が内部から+5Vを引き出し内部電源としてJR-100_SDへ供給する場合、もしかすると電力不足で誤動作するかもしれません。

　もし、動作異常が起こるようであれば別に5V電源アダプタを用意し、外部電源として供給してください。

#### 2025.1.20 純正の電源アダプタを借りて試したところ、内部から引き出した+5Vで問題なく動作しました。

## リセットスイッチ
　リセットスイッチはJ8コネクタに接続された信号線をGNDに落とすためだけのスイッチです。

　リセットスイッチとして利用するためには、本体内部からリセット用の信号線を引き出してくる必要があります。

　引き出し方についてはWeb等で調べてください。

## SD-CARD
　出来れば8GB以下のSDカードを用意してください。

　ArduinoのSdFatライブラリは、SD規格(最大2GB)、SDHC規格(2GB～32GB)に対応していますが、SDXC規格(32GB～2TB)には対応していません。

　また、SDHC規格のSDカードであっても32GB、16GBは相性により動作しないものがあるようです。

　FAT16又はFAT32が認識できます。NTFSは認識できません。

　ルートに置かれた拡張子が「.PRG」のPROG形式ファイルのみ認識できます。(PROG形式以外のファイル、フォルダも表示されますがLOADの対象になりません)

　ファイル名は「.PRG」を含めて31文字まで、ただし半角カタカナ、及び一部の記号はArduinoが認識しないので使えません。パソコンでファイル名を付けるときはアルファベット、数字および空白でファイル名をつけてください。

## PROG形式
　けむしろうさん作JR-100エミュレータver2で採用されているファイル形式です。

https://yorumomiji.sakura.ne.jp/contents/jr-100-emulator

　PROG形式の詳細については、ページ中ほどの「JR-100エミュレータver2ユーザーズガイド」から「ファイル形式」「PROG形式」を参照してください。

　ただし、現在公開されているJR-100エミュレータver2.4.0は、PROG形式フォーマットバージョン2が採用されておりフォーマットバージョン1と互換性がありません。

　JR-100_SDではフォーマットバージョン1に対応、フォーマットバージョン2は単一セクションのみのPRGファイル読み込みだけ対応しています。

#### 注)複数セクションが含まれるフォーマットバージョン2 PRGファイルは読み込ませないでください。最初のセクションの読込が終了した後、Arduinoは次のセクションを送出しようとして待機状態となり、電源を入れ直すか、RESETするまで正常に動作しなくなります。

　エミュレータで使う本体ROMデータはPROG形式フォーマットバージョン1で動作しますのでJR-100_SDからMSAVEすれば簡単に作成できます。

## 使い方

### JR-100_SDの準備
　JR-100を起動したらHCOPYコマンド(CTRL+B)を実行します。

　「JR-100_SD READY OK!」と表示されたらSD-CARDにアクセスできます。

　もう一度HCOPYコマンド(CTRL+B)を実行すると「CMT READY OK!」と表示されCMTに戻ります。

　HCOPYコマンド(CTRL+B)を実行する度にJR-100_SDとCMTが切り替わります。

### BASICコマンド

　~SDへのアクセス中に画面にノイズが出ますが、異常ではありません。ノイズが出ないようにする方法が不明なためそのままにしてあります。~(2025.2.20 PIOを6821にすることで解消されました。)

#### SDDIR[CR]又はSDDIR "文字列"[CR]
　SDDIR[CR]とするとSD-CARDルートディレクトリにあるファイルの一覧を表示します。

　SDDIR "文字列"[CR]とするとSD-CARDルートディレクトリにあるその文字列から始まるファイルの一覧を表示します。

　10件表示したところで指示待ちになるので打ち切るならRETURNを入力すると打ち切られ、Bキーで前の10件に戻ります。それ以外のキーで次の10件を表示します。

　LOADしたいファイルを見つけたら左端の数字のキーを押せばLOADされます。

　BASICプログラムか、機械語プログラムかは自動で判断します。

　表示される順番は、登録順となりファイル名アルファベッド順などのソートした順で表示することはできません。

#### LOAD "DOSファイル名"[CR]
　指定したDOSフィル名のプログラムをSD-CARDからLOADします。

　BASICプログラムか、機械語プログラムかは自動で判断し、どちらをLOADしているかメッセージに表示します。

　また、機械語プログラムのLOAD時には読み込み開始アドレス、読み込み終了アドレスも表示されます。

　MLOADコマンドは使えませんのでLOADコマンドを使用してください。

　ファイル名の最後の「.PRG」も有っても無くても構いません。

　例)

　　LOAD "TEST" -> DOSファイル名「TEST.PRG」を読み込みます。

　　LOAD "TEST.BAS" -> DOSファイル名「TEST.BAS.PRG」を読み込みます。

　　LOAD "TEST.BAS.CMT" -> DOSファイル名「TEST.BAS.PRG」を読み込みます。

#### MEXEC[CR]
　機械語プログラムをLOADした後、A=USR($xxxx)[CR]として機械語プログラムを実行する代わりに実行アドレスが読み込み開始アドレスと同じ場合にはMEXEC[CR]とすることで機械語プログラムを実行できます。

#### SAVE "DOSファイル名"[CR]
　BASICプログラムを指定したDOSフィル名でSD-CARDに上書きSAVEします。

　ファイル名の省略は出来ません。

　ファイル名の最後の「.PRG」は有っても無くても構いません。

　指定したDOSファイル名の最初の16文字がPROG形式の中に保存されるファイル名として使われます。

　BASICプログラムであることを識別するためDOSファイル名に「.BAS」を含ませることを推奨します。

　例)

　　SAVE "TEST" -> 「TEST.PRG」で保存される。

　　SAVE "TEST.BAS" -> 「TEST.BAS.PRG」で保存される。

#### MSAVE "DOSファイル名",$xxxx,$yyyy[CR]
　16進数4桁で指定する$xxxxから$yyyyまでの機械語プログラムを指定したDOSフィル名でSD-CARDに上書きSAVEします。

　ファイル名の省略は出来ません。

　ファイル名の最後の「.PRG」は有っても無くても構いません。

　指定したDOSファイル名の最初の16文字がPROG形式の中に保存されるファイル名として使われます。

　機械語プログラムであることを識別するためDOSファイル名に「.BIN」を含ませることを推奨します。

　例)

　　MSAVE "TEST",$E000,$FFFF -> 「TEST.PRG」で保存される。

　　MSAVE "TEST.BIN",$E000,$FFFF -> 「TEST.BIN.PRG」で保存される。

#### A=USR($DF00)[CR]【メモリテスト】
　RAMをテストします。

　アドレス$0246からエラーが発生するまでRAMに$55を書き込み、$55が読みだせるか、次に$AAを書き込み、$AAが読みだせるか、テストを行います。

　RAMにエラーが無い場合、拡張RAMを実装していなければ$4000、拡張RAMを実装していれば$8000でエラーとなり終了します。

　それ以外のアドレスで停止すればそのアドレスに問題があります。

#### A=USR($DE00,$xxxx)[CR]【メモリダンプ】
　16進数4桁で指定するアドレス$xxxxから64Byte分のメモリをダンプします。

　64Byte表示したところで指示待ちになるので次の64Byteを表示するならSPACEキー又はNキー、前の64Byteを表示するならBキー、それ以外のキーでBASICに戻ります。

#### A=USR($DD00,$xxxx)[CR]【メモリエディット】
　16進数4桁で指定するアドレス$xxxxからメモリに書き込みます。

　アドレス$xxxxを表示して指示待ちになるので書き込みたいデータを16進数で入力してください。

　止めたい時はRETURNキーを押せばBASICに戻ります。

## I/Oポートのデコードについて
　JR-100_SDにおいてジョイスティックポート、6821(8255)、拡張RAM、拡張ROMのアドレスデコードはすべてGAL22V10で行っていますが、ピン数の関係で16Bitすべてのアドレス線をデコードすることが出来ていません。

　拡張RAM、拡張ROMのアドレスデコードに問題はありませんが、ジョイスティックポート、6821(8255)は以下の扱いになります。

　ジョイスティックポート回路の参考にさせていただいた「にがMSX～JR-100用ジョイスティックインターフェイスの製作～」ではジョイスティックIOは$CC02となっていますが、JR-100_SDでは$CC00～$CC0Fのどこをアクセスしても同じ扱いです。

　6821(8255)はSDアクセスプログラム上$CC10～$CC13に配置されているとして記述していますが、$CC14～$CC1Fまでイメージが発生しています。

## ジョイスティック
　MSX用ジョイスティックが使用できます。

## 操作上の注意
　SD-CARDにアクセスしていない時には電源が入ったままでもSD-CARDを抜くことが出来ます。

　再度SD-CARDを挿入した後、SDDIR、LOAD、SAVE等でSD-CARDに3回ほどアクセスすれば復旧します。

　ただし、SD-CARDの抜き差しは電源を切った状態で行うほうがより確実です。

## 謝辞
　基板の作成に当たり以下のデータを使わせていただきました。ありがとうございました。

　　Arduino Pro Mini

　　　https://github.com/g200kg/kicad-lib-arduino

　　AE-microSD-LLCNV

　　　https://github.com/kuninet/PC-8001-SD-8kRAM

　けむしろう様、ファイルフォーマットにPROG形式を採用させていただきました。ありがとうございました。

　　https://asamomiji.jp/contents/jr-100%e3%82%a8%e3%83%9f%e3%83%a5%e3%83%ac%e3%83%bc%e3%82%bf%e7%b7%8f%e5%90%88

　にが様、ジョイスティックポートの回路図を参考に使わさせていただきました。ありがとうございました。

　　http://niga2.sytes.net/msx/JR100_3.html

　くりすと@kurist2010様、HCOPY(CTRL+B)を使ったらどうかという貴重な助言ありがとうございました。

## 追記
2025.1.9 複数セクションを含むフォーマットバージョン2 PRGファイルは扱えないことを追記しました。

2025.1.20 8255が正常にアクセスできない個体があるようなのでGAL22V10のプログラムを修正。SDDIRコマンドの後ろに空白が有ると文字列を認識しないバグを修正。

2025.1.24 動作不安定であるとの動作報告があったことを追記。

2025.1.31 ROMプログラムにJR-200_SD用プログラムをUPDATEしてしまったので元のプログラムを再UPDATE。2025.1.23の時点から修正なし。

2025.2.8 現時点での安定動作確認状況を追加。

2025.2.20 PIOに6821を採用した6821版に移行した。
