Generalized RNA-seq pipeline

- Activity 1: Set up GitHub repository
  - [X] Task 1.1: Set up GitHub repository
  - [X] Task 1.2: Create high-level description document
  - [X] Task 1.3: Create code structure
- Activity 2: Build prototype I
  - Activity 2.1 : Refine design to describe tasks
    - [ ] Task 2.1.1: Break project into activities
    - [ ] Task 2.1.2: Break project into tasks
  - Activity 2.2: Define high-level functions
    - [ ] Task 2.2.1: Define read in data function
    - [ ] Task 2.2.2: Define data processing function 
    - [ ] Task 2.2.3: Define data analysis and visualization function 
  - Activity 2.3: Implement read data and save output in the analsyis
    - [ ] Task 2.3.1: Implement data download function and readin function
    - [ ] Task 2.3.2: Implement seq data processing function: perform quality control and trim and alignment for reads
          - [ ] generated fastq file and performed quality control, followed by trim and alignment for reads
          - [ ] the first implemmentation would be with a mockup input and a simple statement reporting whether the data is successfully processed, and at least one copy of real data should be loaded to test the function.
          - [ ] the preprocessed data would be further searched and visualized for differentially expressed genes between samples 

    - [ ] Task 2.3.3: Implement pathway analysis: to found the possible pathways underlying the differenntially expressed genes
          - [ ] Bar Plot Analysis on enriched gene set
          - [ ] Dot Plot Analysis on enriched gene set
          - [ ] Gene network on enriched gene set
          - [ ] Heatmap on enriched gene set
          - [ ] etc
 
  - Activity 2.4: Define a function to save the generated result into a report and warp up the pipline as a snakemake workflow
  - Activity 2.5: Add the Commandline interface and Graphic user interface
  - Activity 2.6: Test prototype 
- Activity 3: Build prototype II
