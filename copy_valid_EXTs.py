# Python 2.6
#
# This quick and dirty program searched through text files up to 60GB in
# size. Once it found a line starting with the correct string, it would 
# add the file to the valid list. At the end, the script will copy the
# valid files, print how long it took the script to complete, and create
# a text file with a list of the original filenames.
#
# PERFORMANCE: The CentOS machine that this was ran on was able to 
#              search through 500k lines of text each second. 

import glob, os, shutil, time

time_start = time.time()
os.chdir("/media/data")
count = 0
file_list = []

# Generate the file list
for file in glob.glob("*.EXT"):
  file_list.append(file)

# Search through the files and find the valid ones.
# Add them to the list.
valid_list = []
for file in file_list:
  print ""
  print "PROCESSED %d FILES", % count
  count += 1
  fh = open(file, "r")
  line_count = 0
  for line in fh:
    line_count += 1
    if (line_count%1000000 == 0):
      print line_count
    if line.startswith("*,Stop"):
      print 'I FOUND THE "STOP TEST" FILE!!!'
      valid_list.append(file)
      fh.close()
      break
    else: continue
print valid_list
print len(valid_list)


print ""
print "Starting to copy files"
for file in valid_list:
  print "Copying", file
  shutil.copy(file, "/media/data/EXT Data/"+"LV_"+file)

time_total = time.time() - time_start
minutes = int(str(time_total // 60)[:-2])
seconds = int(str(time_total % 60)[:2])
print "Time spent %d minutes and %d seconds." % (minutes, seconds)

# Create a text file that lists all the valid files.
fh = open("/media/data/EXT Data/valid_EXT_files.txt", "w")
for file in valid_list:
  fh.write(file+"\n")
fh.close()
