import re;
fh=open('lecs','r')
lines=fh.readlines()
fh.close()
fh=open('README.md','w')
printt=['TOC\n', '---\n' ,'|Lec ID| Lec Name|\n' ,'| ---| --- |\n']
for line in lines:
	title=re.sub(r'## UNIT \d+\.\d+','',line.strip())
	idd=re.sub(r'(## UNIT \d+\.\d+).*$',r'\1',line.strip())
	toprint='|' +  idd + '|' + '['+ title  +']'+ '(notes.md#' + line.replace('##','').strip().replace(' ','-').replace('##','').replace('.','').lower()  +')'+ '|\n'
	printt.append(toprint);
fh.writelines(printt)