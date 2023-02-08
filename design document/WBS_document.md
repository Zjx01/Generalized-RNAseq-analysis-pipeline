Calcium Neuron Imaging 

- Activity 1: Set up GitHub repository
  - [X] Task 1.1: Set up GitHub repository
  - [X] Task 1.2: Create high-level description document
  - [X] Task 1.3: Create code structure
- Activity 2: Build prototype I
  - Activity 2.1 : Refine design to describe tasks
    - [ ] Task 2.1.1: Break project into activities
    - [ ] Task 2.1.2: Break project into tasks
  - Activity 2.2: Define high-level functions
    - [ ] Task 2.2.1: Define read image data function
    - [ ] Task 2.2.2: Define neuron activity check function
    - [ ] Task 2.2.3: Define generate_mask function
  - Activity 2.3: Implement read data and save output and one feature in the analsyis
    - [ ] Task 2.3.1: Implement read image data function
    - [ ] Task 2.3.2: Implement quality and activation check function: compute activity score for neuron detected in the image
          - [ ] check the quality of the input image and ensure the image can continue further analysis
          - [ ] the first implemmentation would be with a mockup input(like a randomly assigned matrix or a simple calcium activated neuron image) and a simple binary output (True/False) whether the imahe passed the foreground and background ratio test
          - [ ] the qualified images will further undergo the activity score calculation to locate the activated neuron cells 

    - [ ] Task 2.3.3: Implement generate mask function: to delineate the shape of activated neuron in the image
  - Activity 2.4: Test prototype 
- Activity 3: Build prototype II
