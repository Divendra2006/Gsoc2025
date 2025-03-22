# **Interactive Visualization**
---
## **Easy Solution**

### **Overview**
- Demonstrates the use of the Liminal package for interactive visualization.
- Utilizes **linked brushing** to explore relationships between t-SNE embedding and a grand tour.

### **Key Features**
- **Dimensionality Reduction** : t-SNE to analyze data
- **Interactive Visualization** : Linked brushing to understand cluster structures and possible distortions.

---
---
## **Medium Solution**

### **Overview**
- Implements a Shiny app using the Detourr package for interactive 2D scatter plots.
- Analyzes the flea dataset with two different tour paths: grand_tour and little_tour.
- Utilizes a linking brush to highlight corresponding data points across different tour views.

### **Key Features**
- **Linked Brushing** : Display both tours side by side with linked brushing between the two views to explore relationships within the data.
- **Tour Techniques** : Compares grand tour and little tour methods.

### **Visualization of Linking & Brushing**
We display two different 2D projections of the dataset using **grand tour** and **little tour** techniques.

[Watch the video](medium/assets/demo.gif)
---
---
## **Hard Solution**

### **Overview**
This Shiny app visualizes the Palmer Penguins dataset using t-SNE. The app allows users to interactively explore the dataset by adjusting the perplexity parameter and selecting which features to include in the analysis. Each point in the t-SNE plot represents a penguin, colored by species, and the plot helps reveal clusters of similar penguins based on the selected features.

### **Key Features**
- **Controls** : 
  - Adjust the perplexity parameter of t-SNE.
  - Select which features (e.g., bill length, bill depth, flipper length, body mass) to include in 
            the analysis.
- **Visualization** :
  - The t-SNE plot updates automatically when the perplexity or feature selection changes.
  - Points are colored by species (Adelie, Chinstrap, or Gentoo) to highlight clusters.

  **1. t-SNE with Perplexity = 30**
  - **Features** :bill length, bill depth, flipper length, body mass  .
  - 
      ![perplexity_30](https://github.com/user-attachments/assets/27cad7f4-a03b-492d-9196-f266bf9a07df)


   **2. t-SNE with Perplexity = 45**
  - **Features**:bill length, bill depth .
  - 
      ![perplexity_45](https://github.com/user-attachments/assets/ef8ef32f-a8e9-449d-8a56-50c853a531c3)

 
---
