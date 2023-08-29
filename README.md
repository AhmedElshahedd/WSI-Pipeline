# WSI-Pipeline

This repository contains a Nextflow workflow designed to process whole slide images (WSI) through a comprehensive image processing pipeline. The workflow involves anonymizing the images, applying quality control using HistoQC, and performing image enhancement using HistoBlur. The pipeline is managed using Nextflow, Docker, and WSL, ensuring seamless execution across different environments.

## Requirements

Before you begin, make sure you have the following prerequisites installed on your system:

- [Docker](https://www.docker.com/get-started) (required for containerized processes)
- [Nextflow](https://www.nextflow.io/docs/latest/getstarted.html) (required for workflow execution)
- [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/install) (required for Linux environment on Windows)

## Installation

1. Clone This Repository

   ```bash
   git clone https://github.com/AhmedElshahedd/WSI-Pipeline.git
