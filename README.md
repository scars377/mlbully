React Template
==
---

- 網址:
- 主機:
- repo:


- 專案:
- 創意:
- 設計:
- 前端:
- 後端:



---

關於此文件
--
本文件使用 [`markdown`](http://markdown.tw/) 格式
各編輯器應該都有 `markdown-preview` 套件，建議安裝這類套件來閱讀



環境設置
--
1.	安裝 [`nodejs`](https://nodejs.org/en/)
2.	在命令視窗內執行 `npm i -g gulp`
3.	在命令視窗內執行 `npm i`


-	`npm i -g gulp` 會全域安裝 `Gulp`，就可使用 `gulp` 指令
-	`npm i` 會安裝本專案使用的開發套件



開發
--
1.	開啟命令視窗
2.	執行 `gulp`
3.	開始編輯 `src/` 內的檔案
4.	在 <http://localhost:3000/> 即時檢視編譯結果


-	`gulp` 會即時編譯到記憶體(使用 `webpack-dev-server`)，而不是硬碟中某個資料夾
-	如果 port 3000 沖到的話請修改 `gulpfile.js` 裡面的 `webpack-dev-server` 任務



發佈
--
1.	執行 `gulp p` 編譯
2.	執行 `ftp.cmd` 上傳


- 用 `gulp p` 會編譯到 `dist/`，並 diff 到 `dist_remote/`
- `ftp.cmd` 會上傳 `dist_remote/`

- 執行 `gulp pp` 會直接編譯後上傳(省一個步驟)





其他 Gulp Tasks
--
- `gulp imagemin` 或 `gulp m`
	將 `assets/img-src/` 內的圖片壓縮到 `assets/img/`

- `gulp fontmin` 或 `gulp f`
	將 `assets/font-src/` 內的字型壓縮到 `assets/font/` (限定 `.ttf`)
	如果有同名的 `.txt` 則會使用裡面的字元作 webfont 的最小化

- `gulp rm`
	移除 `node_modules/`
	要移除專案前使用，因為套件的檔案名稱可能太長，造成 Windows 無法刪除





使用技術
--
- [CoffeeScript](http://coffee-script.org/) - 編譯為 JavaScript，較簡潔。
	搭配 React 時副檔名為 `.cjsx`
- [Jade](http://jade-lang.com/) - HTML 模版引擎
- [SCSS](http://sass-lang.com/) - 編譯為 CSS
- [CSS Modules](https://github.com/css-modules/css-modules) - 模組化的 CSS
- [Webpack+Gulp](https://webpack.github.io/docs/usage-with-gulp.html) - 開發及打包工具


## modules

- gulp
	- `gulp`
	- `gulp-load-plugins` : 在 gulpfile 裡面可以用 `$.{packge}` 來呼叫 `gulp-{package}`
	- `gulp-if` : gulp.src 取出 -> gulp-if 判斷副檔名 -> 交給對應的函式處理
	- `gulp-size` : show 出 pipe 過來的檔案大小 (可列舉檔案)
	- `gulp-bom` : 將 html 轉為 aspx 時，加 bom 用
	- `gulp-changed` : 過濾掉沒有變更的檔案
	- `imagemin-mozjpeg` : imagemin
	- `imagemin-pngquant` : imagemin


- webpack
	- `webpack`
	- `webpack-dev-server` : 即時編譯到記憶體中並 host server，有各種功能
	- loaders, 當 require 一個檔案時要用哪種 loader 來處理
		- coffee
			- `coffee-loader`: .coffee to module
			- `coffee-jsx-loader`: .cjsx to module
		- stylus
			- `stylus-loader`: .styl to .css
			- `postcss-loader`: .css post-processor
				- `autoprefixer` : 自動加 vendors prefixes
				- `doiuse` : 告知你某 css 中有沒有哪個語法在某 browser 不支援
			- `css-loader`: .css to style object
			- `style-loader`: inject style object to document
		- jade
			- `jade-html-loader`: .jade to html
		- assets
			- `json-loader`: .json to object
			- `file-loader`: save as file
			- `url-loader`: save as data-url or file
		- hot
			- `react-hot-loader` : 熱抽換 react 組件
			- `react` : 給 `react-hot-loader` 用


- 其他
	- `coffee-react-transform`: 讓 coffeelint 可以看懂 jsx
	- `coffee-script`: 讓 gulp 可以 require coffee
