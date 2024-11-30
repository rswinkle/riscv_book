
DOCS = info.adoc ch0.adoc ch1.adoc ch2.adoc ch3.adoc ch4.adoc ch5.adoc ch6.adoc ch7.adoc refs.adoc

all: pdfbook htmlbook epubbook

html: ${DOCS}
	asciidoctor ${DOCS}
	mv *.html build/

pdfbook: ${DOCS}
	asciidoctor-pdf -a is_pdf book.adoc -o riscv_book.pdf

htmlbook: ${DOCS}
	asciidoctor book.adoc -o riscv_book.html

epubbook: ${DOCS}
	asciidoctor-epub3 -a ebook-validate book.adoc -o riscv_book.epub

clean:
	rm riscv_book.pdf
	rm riscv_book.epub
	rm riscv_book.html
	rm build/*.html
	rm build/*.pdf

