import os

dir=input("dir:\t ").strip()
replace=input("replace: ").strip()
to=input("to:\t ").strip()
#print(dir)

os.chdir(dir)
directories=os.scandir()
for i in directories:
    if i.is_dir():
        #print(dir+i.path[1:])
        files=os.scandir(dir+i.path[1:])
        for f in files:
            if f.is_file:
                file=dir+i.path[1:]+f.path[f.path.rfind("/"):]
                nfile=file[:file.rfind("/")]+"_"+file[file.rfind("/")+1:]
                if replace!="":
                    nfile=nfile.replace(replace,to)
                print(file, "=>", nfile)
                os.system(f'mv "{file}" "{nfile}"')
                #os. (file,nfile)
        try:
            os.rmdir(dir+i.path[1:])
        except Exception as e:
            print(e)
    else:
        file=dir+i.path[1:]
        if replace!="":
            nfile=file.replace(replace,to)
        else:
            nfile=file
        if file!=nfile:
            print(file, "=>", nfile)
            os.system(f'mv "{file}" "{nfile}"')

