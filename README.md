# pkuthss: LaTeX template for dissertations in Peking University

Source: [CasperVector/pkuthss](https://github.com/CasperVector/pkuthss)

## Changes

相比于原模板有以下改动：

* 保留更轻量的目录结构（无 doc/example）
* 将make.bat和Makefile中默认编译方式改为xelatex
* 为目录添加了点线
* 将Bibtex模板由CasperVector改为biblatex-gb7714-2015
* 封面图标文件放在cover/目录（pkuthss.cls已适配路径）

## Environment

参考 [VSCode + LaTeX](https://zhuanlan.zhihu.com/p/108095566)

For TeX compiler:

1. Install TeXLive 2020 [here](https://www.tug.org/texlive/).

For editor:

1. Install Visual Studio Code [here](https://code.visualstudio.com/).
2. Install LaTeX Workshop [here](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop).
3. Install LaTeX Untilities [here](https://marketplace.visualstudio.com/items?itemName=tecosaur.latex-utilities).

For bibliography:

1. Install Zotero [here](https://www.zotero.org/download/).
2. Install ZotFile [here](http://zotfile.com/).
3. Install Better BibTex for Zotero [here](https://github.com/retorquere/zotero-better-bibtex).

Recommend:

Use [MathPix Snip](https://mathpix.com/) to OCR the equations.

## Compile

For Windows, run `make.bat doc`.

For Linux/macOS, run `make doc`.

编译中间文件会输出到 `build/`，根目录仅保留 `thesis.pdf`。

如果直接运行 `xelatex`/`biber`，请确保 `TEXINPUTS` 包含 `misc`：
- macOS/Linux: `.:misc:`
- Windows: `.;misc;`

## Reference

1. [TeX Live + pkuthss 安装使用傻瓜指南 v0.1.6](https://bbs.pku.edu.cn/v2/post-read-single.php?bid=346&type=0&postid=18114839)
2. [CasperVector/pkuthss](https://github.com/CasperVector/pkuthss)
3. [hushidong/biblatex-gb7714-2015](https://github.com/hushidong/biblatex-gb7714-2015)
3. [VSCode + LaTeX](https://zhuanlan.zhihu.com/p/108095566)
4. [使用VSCode编写LaTeX](https://zhuanlan.zhihu.com/p/38178015)
5. [VS Code 与 LaTeX 真乃天作之合](https://www.jianshu.com/p/57f8d1e026f5)

## Appendix

### LaTeX Workshop Setting

```json
{
    "latex-workshop.latex.tools": [
        {
            "name": "xelatex",
            "command": "xelatex",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "%DOC%"
            ]
        }, 
        {
            "name": "biber",
            "command": "biber",
            "args": [
                "-l",
                "zh__pinyin",
                "--output-safechars",
                "%DOCFILE%"
            ],
        }
    ],
    "latex-workshop.latex.recipes": [
        {
            "name": "Compile thesis",
            "tools": [
                "xelatex",
                "biber",
                "xelatex",
                "xelatex"
            ]
        }
    ]
}
```

