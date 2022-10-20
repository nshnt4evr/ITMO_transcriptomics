import subprocess

# samples
with open("scripts/IDs/ID_list.txt") as f:
    sra_numbers = f.read().splitlines()

# this will extract the .sra files from above into a folder named 'fastq'
for sra_id in sra_numbers:
    print ("Generating fastq for: " + sra_id)
    fasterq_dump = "~/sratoolkit.3.0.0-ubuntu64/bin/fasterq-dump -O ~/icml/raw " + sra_id 
    print ("The command used was: " + fasterq_dump)
    subprocess.call(fasterq_dump, shell=True)