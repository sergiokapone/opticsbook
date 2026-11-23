#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Генерує index.html (головна сторінка посібника для GitHub Pages) зі змісту OpticsProblems.toc.

Запуск (після збірки PDF і HTML-версії):  python -I make_site.py
Зміст сторінки (частини, розділи, підрозділи) береться з OpticsProblems.toc, тому збігається з книгою.
Розділи ведуть на сторінки онлайн-версії online/<ім'я>.html (їх імена задає PAGE_NAMES у html/tools/publish_html.py).
"""
import re
from html import escape
from pathlib import Path

HERE = Path(__file__).resolve().parent
TOC = HERE / "OpticsProblems.toc"
OUT = HERE / "index.html"
SITE = "https://sergiokapone.github.io/opticsbook/"
# i-й розділ (за номером у змісті) -> сторінка онлайн-версії
PAGES = {1: "geomopt", 2: "photometry", 3: "dispersion", 4: "interference", 5: "difraction", 6: "polarisation"}
ENTRY = re.compile(r"\\contentsline \{(\w+)\}\{(.*)\}\{(\d+)\}\{[^}]*\}%?\s*$")


def tex2html(s: str) -> str:
    s = s.replace("---", "—").replace("--", "–").replace("~", " ")
    s = re.sub(r"\\hspace \{[^}]*\}", " ", s)
    s = re.sub(r"\$([^$]*)\$", lambda m: "<i>%s</i>" % escape(m.group(1).strip()), s)
    return s.strip()


def parse():
    parts, cur_part, cur_ch = [], None, None
    for line in TOC.read_text(encoding="utf-8", errors="replace").splitlines():
        m = ENTRY.match(line)
        if not m:
            continue
        kind, body, _ = m.groups()
        nm = re.match(r"\\numberline \{([^}]*)\}(.*)$", body)
        num, title = (nm.group(1), nm.group(2)) if nm else ("", body)
        title = tex2html(title)
        if kind == "part":
            cur_part = {"title": title, "chapters": []}
            parts.append(cur_part)
        elif kind == "chapter" and num.isdigit() and cur_part is not None:
            cur_ch = {"num": int(num), "title": title, "sections": []}
            cur_part["chapters"].append(cur_ch)
        elif kind == "section" and cur_ch is not None and num:
            cur_ch["sections"].append((num, title))
    return parts


def page(parts) -> str:
    cards = []
    for p in parts:
        cards.append('<h3 class="part">%s</h3>' % p["title"])
        for ch in p["chapters"]:
            href = "online/%s.html" % PAGES.get(ch["num"], "") if ch["num"] in PAGES else "online/"
            secs = "".join("<li><span>%s</span> %s</li>" % (n, t) for n, t in ch["sections"])
            cards.append(
                '<article class="ch"><h4><a href="%s"><span class="n">%d</span>%s</a></h4><ul>%s</ul></article>'
                % (href, ch["num"], ch["title"], secs))
    toc = "\n".join(cards)
    return TEMPLATE.replace("@@TOC@@", toc).replace("@@SITE@@", SITE)


TEMPLATE = """<!DOCTYPE html>
<html lang="uk">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Оптика. Практичний курс | Навчальний посібник</title>
<meta name="description" content="Навчальний посібник для практичних занять з оптики: геометрична оптика, фотометрія, дисперсія, інтерференція, дифракція, поляризація. Задачі з відповідями.">
<link rel="canonical" href="@@SITE@@">
<meta property="og:title" content="Оптика. Практичний курс">
<meta property="og:description" content="Навчальний посібник для практичних занять з оптики. Читати онлайн або завантажити PDF.">
<meta property="og:type" content="website">
<meta property="og:url" content="@@SITE@@">
<style>
:root{--navy:#002e64;--blue:#0064aa;--ink:#1d2330;--paper:#f6f8fb;--card:#fff;--rule:#d5dce8;color-scheme:light dark}
@media (prefers-color-scheme:dark){:root{--ink:#e6eaf2;--paper:#10151f;--card:#171e2b;--rule:#2b3547;--blue:#6fb0ee}}
*{box-sizing:border-box}
body{margin:0;background:var(--paper);color:var(--ink);font:17px/1.6 "Segoe UI",system-ui,-apple-system,Roboto,sans-serif}
.hero{background:linear-gradient(135deg,#002e64,#0064aa);color:#fff;text-align:center;padding:3.2rem 1.2rem 3rem}
.hero h1{margin:0;font-size:clamp(2rem,6vw,3.2rem);letter-spacing:.01em}
.hero .sub{margin:.3rem 0 0;font-size:1.25rem;opacity:.9}
.hero .by{margin:1.1rem 0 1.6rem;opacity:.85;font-size:.98rem}
.btns{display:flex;flex-wrap:wrap;gap:.7rem;justify-content:center}
.btn{display:inline-block;padding:.65rem 1.5rem;border-radius:999px;font-weight:600;text-decoration:none;border:2px solid #fff;color:#fff}
.btn.primary{background:#fff;color:var(--navy)}
.btn:hover{background:rgba(255,255,255,.2)}.btn.primary:hover{background:#e6f0fb}
main{max-width:62rem;margin:0 auto;padding:2rem 1.2rem 3rem}
h2{color:var(--navy);border-bottom:2px solid var(--rule);padding-bottom:.3rem;margin:2.2rem 0 1rem}
@media (prefers-color-scheme:dark){h2{color:#9db4ff}}
.about p{text-align:justify;hyphens:auto}
.part{margin:1.8rem 0 .6rem;color:var(--blue);font-size:1.05rem;text-transform:uppercase;letter-spacing:.05em}
.toc{display:grid;grid-template-columns:repeat(auto-fill,minmax(17rem,1fr));gap:1rem}
.part,.toc-h{grid-column:1/-1}
.ch{background:var(--card);border:1px solid var(--rule);border-top:3px solid var(--navy);border-radius:6px;padding:.8rem 1rem}
.ch h4{margin:0 0 .4rem;font-size:1.05rem}
.ch h4 a{color:inherit;text-decoration:none}.ch h4 a:hover{color:var(--blue)}
.ch .n{display:inline-block;min-width:1.7rem;margin-right:.4rem;color:var(--blue)}
.ch ul{margin:0;padding:0;list-style:none;font-size:.88rem;color:var(--ink);opacity:.85}
.ch li{padding:.1rem 0}.ch li span{color:var(--blue);margin-right:.3rem}
.authors{display:flex;flex-wrap:wrap;gap:1.2rem;justify-content:center}
.au{display:flex;flex-direction:column;align-items:center;text-align:center;width:16rem;padding:1rem;background:var(--card);border:1px solid var(--rule);border-radius:8px;text-decoration:none;color:inherit}
.au:hover{border-color:var(--blue)}
.au img{width:130px;height:130px;border-radius:50%;object-fit:cover;margin-bottom:.6rem;border:3px solid var(--navy)}
.au span{font-size:.85rem;opacity:.8}
footer{text-align:center;padding:1.4rem 1rem 2.2rem;font-size:.9rem;opacity:.75}
</style>
</head>
<body>
<header class="hero">
<h1>Оптика</h1>
<p class="sub">Практичний курс</p>
<p class="by">В. В. Іванова, С. М. Пономаренко · КПІ ім. Ігоря Сікорського</p>
<div class="btns">
<a class="btn primary" href="online/">Читати онлайн</a>
<a class="btn" href="OpticsProblems.pdf">Завантажити PDF</a>
</div>
</header>
<main>
<section class="about">
<h2>Про посібник</h2>
<p>Навчальний посібник призначений для практичних занять з курсу оптики як розділу загальної фізики. Він є результатом багаторічного досвіду роботи зі студентами Фізико-технічного інституту, які набувають фаху прикладної фізики. У книзі значна частина теоретичних відомостей викладена в обсязі, достатньому для розв’язування задач. Кожний розділ супроводжується прикладами, які ілюструють і поглиблюють розуміння принципів та законів оптики, а також прикладами суто практичного застосування. Особливу увагу приділено опануванню підходів до розв’язання задач прикладного характеру.</p>
<p>Основою матеріалу став посібник В. В. Іванової «Задачі з загальної фізики. Оптика» (2012), суттєво оновлений, розширений і доповнений теоретичними відомостями та оригінальними задачами. Посібник може бути корисним студентам інших фізичних та інженерних спеціальностей.</p>
</section>
<section>
<h2>Автори</h2>
<div class="authors">
<a class="au" href="https://apd.ipt.kpi.ua/kafedra/stuff/ivanova/"><img src="authors/ivanova.jpg" alt="Віта Вікторівна Іванова" width="130" height="130"><b>Віта Вікторівна Іванова</b><span>кандидат технічних наук, доцент кафедри прикладної фізики</span></a>
<a class="au" href="https://apd.ipt.kpi.ua/kafedra/stuff/ponomarenko/"><img src="authors/ponomarenko.jpg" alt="Сергій Миколайович Пономаренко" width="130" height="130"><b>Сергій Миколайович Пономаренко</b><span>кандидат фізико-математичних наук, доцент кафедри прикладної фізики</span></a>
</div>
</section>
<section>
<h2>Зміст</h2>
<div class="toc">
@@TOC@@
</div>
</section>
</main>
<footer>© В. В. Іванова, С. М. Пономаренко, КПІ ім. Ігоря Сікорського</footer>
</body>
</html>
"""

if __name__ == "__main__":
    OUT.write_text(page(parse()), encoding="utf-8", newline="\n")
    print("written", OUT)
