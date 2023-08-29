# WSI-Pipeline

This repository contains a Nextflow workflow designed to process whole slide images (WSI) through a comprehensive image processing pipeline. The workflow involves anonymizing the images, applying quality control using HistoQC, and performing image enhancement using HistoBlur. The pipeline is managed using Nextflow, Docker, and WSL, ensuring seamless execution across different environments.

## Requirements

Before you begin, make sure you have the following prerequisites installed on your system:

- [Docker](https://www.docker.com/get-started) (required for containerized processes)
- [Nextflow](https://www.nextflow.io/docs/latest/getstarted.html) (required for workflow execution)

### Windows Subsystem for Linux (WSL) 2

To set up a Linux environment on your Windows machine, you can install Windows Subsystem for Linux (WSL) 2. This allows you to run a Linux distribution alongside your Windows system.

Open PowerShell as an administrator and run the following command to install WSL 2 with the Ubuntu 20.04 distribution:

```powershell
wsl --install -d Ubuntu-20.04

## Installation
