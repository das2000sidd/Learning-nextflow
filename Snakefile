// practicing implementing snakemake pipeline for chip sequencing for the code I used in my own project


rule bowtie2_map :
	input:
		"/Users/siddhaduio.no/Desktop/PhD_Project_related/Learning_SnakeMake/ChIPSeq_data/samples/{sample}_500_reads.fastq"
	output:
		"/Users/siddhaduio.no/Desktop/PhD_Project_related/Learning_SnakeMake/ChIPSeq_data/mapped_reads/{sample}.bam"
	shell:
		"bowtie2 -p 64 -q -x /Users/siddhaduio.no/Desktop/ALL_DESKTOP_ITEMS_IN_HERE/All_omics_tools/bowtie2-2.4.4-macos-x86_64/hg38_index/human_hg38_index -U {input} | samtools view -Sb - > {output}"
		
		
		
rule samtools_sort:
	input:
		"/Users/siddhaduio.no/Desktop/PhD_Project_related/Learning_SnakeMake/ChIPSeq_data/mapped_reads/{sample}.bam"
	output:
		"/Users/siddhaduio.no/Desktop/PhD_Project_related/Learning_SnakeMake/ChIPSeq_data/sorted_bam/{sample}.sorted.bam"
		
	shell:
		"/Users/siddhaduio.no/Desktop/ALL_DESKTOP_ITEMS_IN_HERE/All_omics_tools/samtools-1.14/samtools sort -o {output} {input}"
		



rule samtools_index:
	input:
		"/Users/siddhaduio.no/Desktop/PhD_Project_related/Learning_SnakeMake/ChIPSeq_data/sorted_bam/{sample}.sorted.bam"
	
	output:
		"/Users/siddhaduio.no/Desktop/PhD_Project_related/Learning_SnakeMake/ChIPSeq_data/sorted_bam/{sample}.sorted.bam.bai"
	
	shell:
		"/Users/siddhaduio.no/Desktop/ALL_DESKTOP_ITEMS_IN_HERE/All_omics_tools/samtools-1.14/samtools index {input}"
