#!/usr/bin/env nextflow

// Define the parameters
params.reads = "/Volumes/matthews/AHR_HFD_study_corrected/Ahrko_X204SC24012427-Z01-F003_1/01.RawData_all_files/all_fastq/*_{1,2}.fq.gz"
params.transcriptome = "/Users/siddhaduio.no/Desktop/All_omics_tools/GRCm39.cDNA.salmon.index/"
params.outdir = "/Volumes/matthews/AHR_HFD_study_corrected/Ahrko_X204SC24012427-Z01-F003_1/01.RawData_all_files/all_fastq/results"



process QUANT {
    tag "$pair_id"
    publishDir params.outdir

    input:
    path transcriptome
    tuple val(pair_id), path(reads)

    output:
    path pair_id

    script:
    """
    salmon quant --libType A --index $transcriptome -1 ${reads[0]} -2 ${reads[1]} -o $pair_id
    """
}


workflow {
index_ch=Channel.fromPath(params.transcriptome)

read_pairs_ch = channel.fromFilePairs( params.reads, checkIfExists: true )

QUANT(params.transcriptome,read_pairs_ch)


}


// nextflow run nextflow_pipeline_test.nf
