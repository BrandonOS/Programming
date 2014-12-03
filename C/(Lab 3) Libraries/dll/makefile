LIB_FILES = sphere.o sumFloats.o volCylinder.o sine.o	#Files needed to build the library	

main: main.c libmyLib.so		
	gcc -o main main.c -L. -lmyLib -lm -ldl

libmyLib.so: ${LIB_FILES}
	gcc -shared -o libmyLib.so ${LIB_FILES} -lm

sphere.o: sphere.c
	gcc -fPIC -c sphere.c

sumFloats.o: sumFloats.c
	gcc -fPIC -c sumFloats.c

volCylinder.o: volCylinder.c
	gcc -fPIC -c volCylinder.c

sine.o: sine.c 
	gcc -fPIC -c sine.c
