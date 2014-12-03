SRC_FILES = sphere.o sumFloats.o volCylinder.o sine.o

main: main.c libmyLib.so
	gcc -o main main.c -L. -lmyLib -lm

libmyLib.so: ${SRC_FILES}
	gcc -shared -o libmyLib.so ${SRC_FILES}

sphere.o: sphere.c
	gcc -fPIC -c sphere.c

sumFloats.o: sumFloats.c
	gcc -fPIC -c sumFloats.c

volCylinder.o: volCylinder.c
	gcc -fPIC -c volCylinder.c

sine.o: sine.c
	gcc -fPIC -c sine.c
