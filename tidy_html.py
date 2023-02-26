import re
from bs4 import BeautifulSoup as bs

def main():
    with open("index.html", "r") as f:
        soup = bs(f.read(), "html.parser")
        i = 1
        for span in soup.find_all("span"):
            attr = span.attrs.get("class")
            if attr is None:
                continue
            if len(attr) < 2:
                continue
            if (attr[0] == "math") and (attr[1] == "display"):
                span.replace_with(span.text[:-2] + "\\tag{" + str(i) + "}" + span.text[-2:])
                if "label{" in span.text:
                    j = 0
                    for tag_text in span.text.split("label{"):
                        tag_text = tag_text.split("}")[0]
                        if "eq:" not in tag_text:
                            continue
                        for tag in soup.find_all(text=re.compile(tag_text)):
                            replace_tag_text = tag_text
                            current_tag_text = tag.text
                            if current_tag_text[1:-1] != tag_text:
                                continue
                            if current_tag_text[0] == "[" and current_tag_text[-1] == "]":
                                replace_tag_text = "[" + tag_text + "]"
                            tag.replace_with(str(i).join(tag.split(replace_tag_text)))
                        j += 1
                i += 1
    
    html = soup.prettify("utf-8")
    with open("index.html", "wb") as f:
        f.write(html)

if __name__ == "__main__":
    main()


