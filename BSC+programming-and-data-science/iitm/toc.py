
fh=open('lecs','r')
lines=fh.readlines()
fh.close()
fh=open('README.md','w')
printt=['TOC\n', '---\n' ,'|Lec ID| Lec Name|\n' ,'| ---| --- |\n']
for line in lines:
	toprint='|' +  line[6:11].replace('-' ,'').replace(':','').strip() + '|' + '['+ line[12:].strip() + ']' + '(notes.md#' + line[3:].strip().replace('.','').lower().replace(' ' ,'-') + ')' + '|\n'
	printt.append(toprint);
fh.writelines(printt)