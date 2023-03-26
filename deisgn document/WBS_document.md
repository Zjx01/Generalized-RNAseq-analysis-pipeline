Generalized RNA-seq pipeline

- Activity 1: Set up GitHub repository
  - [X] Task 1.1: Set up GitHub repository
  - [X] Task 1.2: Create high-level description document
  - [X] Task 1.3: Create code structure
- Activity 2: Build prototype I
  - Activity 2.1 : Refine design to describe tasks
    - [X] Task 2.1.1: Break project into activities
    - [X] Task 2.1.2: Break project into tasks
  - Activity 2.2: Define high-level functions
    - [X] Task 2.2.1: Define read in data function
    - [X] Task 2.2.2: Define data processing function: check_genecovered_quality, check_totalcov_quality, check_RPKM and check_sample_distance 
    - [X] Task 2.2.3: Define data analysis and visualization function
  - Activity 2.3: Implement read data and save output in the analsyis
    - [X] Task 2.3.1: Implement data readin function
    - [X] Task 2.3.2: Implement seq data processing function: perform quality control and return the differentially expressed genes in the input samples
         - [X] the first implemmentation would be with a mockup input and a simple statement reporting whether the data is successfully processed, and at least one copy of real data should be loaded to test the function.
         - [X] the preprocessed data would be further visualized for similarity using heatmap and PCA plot
         - [X] find the 

    - [X] Task 2.3.3: Implement pathway analysis: to found the possible pathways underlying the differenntially expressed genes
          - [X] Bar Plot Analysis on enriched gene set
          - [X] Dot Plot Analysis on enriched gene set
          - [X] Gene network on enriched gene set
          - [] Heatmap on enriched gene set
          - [] etc
 
  - Activity 2.4: Generate a happy path i,plementation for the project
  - Activity 2.5: Test prototype 
  - Activity 2.6: Add the Commandline interface and Graphic user interface
- Activity 3: Build prototype II
