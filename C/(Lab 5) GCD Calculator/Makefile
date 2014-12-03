main: app/main.c libmylib.so
	gcc -o main app/main.c -L. -lmylib  -ldl

libmylib.so:
	gcc -shared -o libmylib.so lib/div.c lib/exp.c lib/gcd.c lib/mul.c

	


	
