with open("scripts/IDs/ID_list.txt") as f:
	sra_numbers=f.read().splitlines()



rule download_sra:
	input:
		"scripts/IDs/ID_list.txt"
	output:
		"raw"
	script:
		"scripts/DownloadSRA.py"


	
rule kb_index:
	input:
		"reference/ref.fa.gz"
	output:
		"reference/ref_kallisto_index.idx"
	shell:
		"kallisto index -i {output} -k 31 {input}"


	
rule kb_quant:
	input:
		"raw/{sra_numbers}_1.fastq",
		"raw/{sra_numbers}_2.fastq",
		"reference/ref_kallisto_index.idx"
	output:
		"kallisto_out/{sra_numbers}"
	log:
		"kallisto_out/log/{sra_numbers}.txt"
	shell:
		"kallisto quant -i {input[2]} -o {output} {input[0]} {input[1]} &> {log}"