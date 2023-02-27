import re
from bs4 import BeautifulSoup as bs

def main():
    with open("index.html", "r") as f:
        soup = bs(f.read(), "html.parser")
        i = 1
        eq_references = {}
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
                            eq_references[tag_text] = i
                            if current_tag_text[0] == "[" and current_tag_text[-1] == "]":
                                replace_tag_text = "[" + tag_text + "]"
                            tag.replace_with(str(i).join(tag.split(replace_tag_text)))
                        j += 1
                i += 1
        for link in soup.find_all("a"):
            if link.attrs.get("data-reference-type") is None:
                continue
            if link.attrs.get("data-reference") is None:
                continue
            eq_num = eq_references.get(link.attrs.get("data-reference"))
            if eq_num is None:
                continue
            link.attrs["href"] = "#" + str(eq_num)
            link.attrs["data-reference"] = eq_num
    
    html = soup.prettify("utf-8")
    with open("index.html", "wb") as f:
        f.write(html)

    # read file
    with open("index.html", 'r') as fp:
        # read an store all lines into list
        lines = fp.readlines()
    
    # Write file
    with open("index.html", 'w') as fp:
        # iterate each line
        for number, line in enumerate(lines):
            if (number < 122) or (number > 140):
                fp.write(line)

if __name__ == "__main__":
    main()


