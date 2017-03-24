# lua-ibyte
[For LOVE2D] A simple, plaintext data compressor that saves data into the alpha channel of a PNG image file

Included above is a copy of Mary Shelley's "Frankenstein" repeated 4 times to make the file larger (from http://www.gutenberg.org/ebooks/84) in both plaintext (4.27 MB) and compressed as a PNG (1.60 MB) for reference and testing!

Usage is simple, read an ibyte PNG with ibyte.read("path/to/file.png") and it will return the data as a string, or write one with ibyte.write("data as a string", "path/to/output.png") which returns the imageData
