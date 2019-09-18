#Script 1 - Operators
a = seq(from = 5, to=14, by=1)
b=a[1]
c=a[7]
b>c
b<c
b>=c
x=a[2]
y=a[6]
z=a[9]

((z+x)*(z+y))/2
10*(x-y)
#the R operator for negation is !
b%%c #modulus function
b^c #exponential function
b%/%c #integer division function

"%lukesop%"=function(a,b){(a*2)+(b*3)}
b%lukesop%c

"me"->g

h=1;i=2;j=3
h;i;j

2^4000 #higher number than console can compute
-2^4000 #-inf
0/0 #nan = Not a number
k=NA #Object with no value assigned

#Script 1 - Conditional Statement

animals=function(x){
  if(x=="l")
    "squid"
  else if(x=="m")
    'elephant'
  else if(x=="n")
    'kangaroo'
  else if(x=="o")
    'komodo dragon'
}
animals("l")
animals("m")
animals("n")
animals("o")

#Script 1 - Object Data Types
l=1:10 #integer
m="Exam" #character
n=double(length = 3) #double-numeric
o=as.factor(c("light","heavy")) #factor w/ two levels

#Script 1 - Data Storage Stuctures
p = array(data=1:24, dim = c(3,4,2))
q = matrix(data = 1:10,nrow = 5,ncol = 2,)
#a matrix consists of 1 or 2 dimensions, where an array can have more than 2

r=q[4,1]
s=p[2,2,2]
