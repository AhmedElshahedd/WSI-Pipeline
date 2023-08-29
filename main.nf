#!/usr/bin/env nextflow

// Define the input directory parameter
params.inputDir = file(args[0]) // Get the input directory from command-line argument

// Process 1: Anonymize whole slide images
process anonymizewsi {
    // Specify the Docker image to use
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'docker://ahmedelshahed/wsi-anon:latest' :
        'ahmedelshahed/wsi-anon:latest' }"

    // Output directory for anonymized images
    output:
    val "out-anon"
    
    script:
    """
    docker run -v ${params.inputDir}:/data ahmedelshahed/wsi-anon:latest /bin/bash ./anonymize_dir.sh /data
    """
}

// Process 2: HistoQC
process histoqc {
    // Specify the Docker image to use
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'docker://ahmedelshahed/modified-histoqc:latest' :
        'ahmedelshahed/modified-histoqc:latest' }"

    input:
    val pathDir

    script:
    """
    docker run -v ${params.inputDir}/out-anon:/home ahmedelshahed/modified-histoqc:latest /bin/bash -c '
    source /opt/HistoQC/venv/bin/activate &&
    histoqc_pipeline /home/* -c v2.1 -o /home/HistoQC
    '
    """
}

// Process 3: HistoBlur
process histoblur {
    // Specify the Docker image to use
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'docker://petroslk/histoblur:latest' :
        'petroslk/histoblur:latest' }"

    input:
    val pathDir

    script:
    """
    docker run -v ${params.inputDir}/out-anon:/data petroslk/histoblur:latest /bin/bash -c '
    source /opt/conda/bin/activate &&
    HistoBlur detect -f "/data/*" -m /HistoBlur/pretrained_model/blur_detection_densenet_best_model_10.0X.pth -o /data/HistoBlur
    '
    """
}

workflow {

    // Start with the anonymizewsi process
    anonymizewsi()
    histoqc(anonymizewsi.out)
    histoblur(anonymizewsi.out)
}