# README
Android の UserAgent を集めた情報を元に、Chrome や Safari の擬装用 UserAgent リストを生成する。

# 対応ブラウザ
- Safari (Mac) 開発メニュー
- User-agent switcher for Chrome

## Safari で UserAgent を偽装する
次のファイルに UserAgent を追加することで開発メニューから選択できるユーザーエージェントの種類を増やせる

    /Applications/Safari.app/Contents/Resources/UserAgents.plist

Windows は手元に無いの未検証。

## User-agent switcher for Chrome

	settings -> import settings 

取り込み用の XML ファイルを作成し、インポートする。



## 初期設定
bundler を使って関連 gem をインストール

	bundle install 


## 設定ファイル生成

Chrome 

	ruby generate-chrome-user-agent-switcher-xml.rb > user-agents.xml
	
	
Safari 

	ruby generate-safari-user-agent-resource.rb > UserAgents.plist
	

