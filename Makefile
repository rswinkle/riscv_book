
DOCS = info.adoc ch0.adoc ch1.adoc ch2.adoc ch3.adoc ch4.adoc ch5.adoc ch6.adoc ch7.adoc refs.adoc

all: pdfbook htmlbook

html: ${DOCS}
	asciidoctor ${DOCS}
	mv *.html build/

pdfbook: ${DOCS}
	asciidoctor-pdf -a is_pdf -d book book.adoc -o mips_book.pdf

htmlbook:
	asciidoctor -d book book.adoc -o mips_book.html

clean:
	rm build/*.html
	rm build/*.pdf

