wartool: wartool.o
	$(CC) -o $@ $^ -lz -lpng -lm

clean:
	rm -f wartool wartool.o
