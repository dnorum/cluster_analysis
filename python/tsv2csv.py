# From GitHub nsonnad/tsv2csv.py, https://gist.github.com/nsonnad/7598574

import sys
import csv

tabin = csv.reader(sys.stdin, dialect=csv.excel_tab)
commaout = csv.writer(sys.stdout, dialect=csv.excel)
for row in tabin:
	commaout.writerow(row)
