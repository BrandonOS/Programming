
# Make file to create payroll application
SRC_FILES=main.o calGross.o  calFica.o calNet.o newPage.o

payroll: ${SRC_FILES}
	gcc  -Wall -o payroll ${SRC_FILES}

main.o: src/main.c
	gcc -Wall -c -o main.o src/main.c
	
calGross.o: src/calGross.c
	gcc -Wall -c -o calGross.o src/calGross.c
	
calFica.o: src/calFica.c
	gcc -Wall -c -o calFica.o src/calFica.c

calNet.o: src/calNet.c
	gcc -Wall -c -o calNet.o src/calNet.c

newPage.o: src/newPage.c
	gcc -Wall -c -o newPage.o src/newPage.c

clean:
	rm -f ${SRC_FILES}
