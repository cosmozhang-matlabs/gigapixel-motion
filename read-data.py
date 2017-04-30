import numpy
import json

ROWS = 4
COLS = 4

filenames = ["mosaic-20170416/config_415.json", "mosaic-20170416/config_622.json", "mosaic-20170416/config_875.json"]
workingDistances = [415, 621, 877]
matnames = [("off_%d" % d) for d in workingDistances]
outfilename = "./get_data.m"

of = open(outfilename, "w")
for idx in range(len(filenames)):
    filename = filenames[idx]
    matname = matnames[idx]
    f = open(filename, "r")
    result = json.load(f)['images']
    offsets = [[[0,0] for i in range(COLS)] for j in range(ROWS)]
    for item in result:
        r = item['row']
        c = item['col']
        x = item['x']
        y = item['y']
        offsets[r][c] = [x,y]
    f.close()
    # of.write("%s = %s;\n" % (matname, json.dumps(offsets)))
    of.write("%s = zeros(%d,%d,2);\n" % (matname, ROWS, COLS))
    for i in range(ROWS):
        for j in range(COLS):
            of.write("%s(%d,%d,:) = [%d,%d];\n" % (matname, i+1, j+1, offsets[i][j][0], offsets[i][j][1]))
    # of.write("%s(:,:,2) = -%s(:,:,2);\n" % (matname, matname))
of.close()
