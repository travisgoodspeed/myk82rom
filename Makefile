all: rom20x6.bin rom20x7.bin rom.bin lutleft.txt lutright.txt
	md5sum -c md5.txt

rom.bin: rom20x7.bin
# Convert to presumed big-endianness.
	python3 flip.py <rom20x7.bin >rom.bin

rom20x6.txt: rom20x6.tif rom20x6.tif.json
# -d does a DRC, and ought to fail if the result is wrong.
# Rerun with -V if you need to figure out a failure.
	maskromtool rom20x6.tif -a rom20x6.txt -platform offscreen -e
rom20x6.bin: rom20x6.txt
	gatorom -w 32 --decode-cols-left rom20x6.txt -o rom20x6.bin
#	maskromtool rom20x6.tif -o rom20x6.bin -platform offscreen -e
rom20x7.txt: rom20x7.tif rom20x7.tif.json
# -d does a DRC, and ought to fail if the result is wrong.
# Rerun with -V if you need to figure out a failure.
	maskromtool rom20x7.tif -a rom20x7.txt -platform offscreen -e 
rom20x7.bin: rom20x7.txt
#	gatorom -w 32 --decode-cols-left rom20x7.txt -o rom20x7.bin
	maskromtool rom20x7.tif -o rom20x7.bin -platform offscreen -e


solve: rom20x6.txt
	gatorom -w 32 --solve --solve-string "00,00,00,20,00,00,00,20,00,00,00,20,00,00,00,20" rom20x6.txt

open:
# Just opens in a GUI.
	maskromtool rom20x7.tif
clean:
	rm -f lut*.txt rom*.txt *.bin
diff: rom20x6.txt rom20x7.txt
	diff rom20x6.txt rom20x7.txt

# There are two identical LUTs, so we can compare for equality.
lutleft.txt: lutleft.bmp
	maskromtool lutleft.bmp -a lutleft.txt -platform offscreen -e
lutright.txt: lutright.bmp
	maskromtool lutright.bmp -a lutright.txt -platform offscreen -e


