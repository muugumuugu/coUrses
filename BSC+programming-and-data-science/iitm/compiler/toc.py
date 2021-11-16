
fh=open('lecs','r')
lines=fh.readlines()
fh.close()
fh=open('toc.md','w')
printt=['TOC\n', '---\n' ,'|Lec Name|\n' ,'|---|\n']
for line in lines:
	toprint='|' + "["+ line[1:].strip().lower().replace(" " ,"-")+"](" + line[1:].strip()+")" + '|' + '\n'
	printt.append(toprint);
fh.writelines(printt)