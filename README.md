# About this
Emacs setting file for my mac (GUI & CUI)

GUIバージョンとCUIバージョンでバイトコンパイルした時に挙動が違う？（CUIでバイトコンパイルするとGUIでエラーが起きる）ので
アップデート時にはGUI側で以下を実行
- M-: (byte-recompile-directory package-user-dir nil 'force)
