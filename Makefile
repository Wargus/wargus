wartool: wartool.o
	$(CC) -o $@ $^ -lz -lpng

clean:
	rm -f wartool wartool.o
