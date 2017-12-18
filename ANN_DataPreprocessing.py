f = open("temp.csv","r")
str=f.read()
f1=open("means.csv","w")
li=str.split('\n')
i=1
while len(li) > 9:
ti=li[:10]
try:
ti=[float(x) for x in ti]
except ValueError,e:
print ("error",e,"on line",i)
li=li[10:]
m=sum(ti)/10
print(m,file=f1)
i=i+1
f.close()
f1.close()
