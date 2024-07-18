# The Structure of the Data Folder

The structure of the data folder should be organized as below:

    Data
    │
    ├── w1
    │   ├── useful_data
    │   │	├── centerlines_camera.mat
    │   │	├── centerlines_lab.mat
    │	│   ├── timestamps.mat
    │   │   ├── idx_beyond_edge.mat
    │	
    ├── w2
    │   ├── useful_data
    │   │	├── centerlines_camera.mat
    │   │	├── centerlines_lab.mat
    │	│   ├── timestamps.mat
    │   │   ├── idx_beyond_edge.mat
    │
    ├── w3
    │   ├── useful_data
    │   │	├── centerlines_camera.mat
    │   │	├── centerlines_lab.mat
    │	│   ├── timestamps.mat
    │   │   ├── idx_beyond_edge.mat
    │
    ...

Here, `centerlines_camera.mat` and `centerlines_lab.mat` are essential, while `timestamps.mat` and `idx_beyond_edge.mat` are optional.
