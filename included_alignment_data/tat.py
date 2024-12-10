 #install pandas, seaborn, matplotlib
#to run: python env_alignment_matrix.py in terminal 

import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

tat_data = [
    [100.00, 67.33, 69.31, 36.36, 44.12],
    [67.33, 100.00, 73.27, 39.39, 42.65],
    [69.31, 73.27, 100.00, 35.35, 39.71],
    [36.36, 39.39, 35.35, 100.00, 63.92],
    [44.12, 42.65, 39.71, 63.92, 100.00],
]

# Labels for the rows and columns
tat_labels = ["SIVcpz-tat", "HIV1-B-tat", "HIV1-C-tat", "HIV2-A-tat", "HIV2-B-tat"]


tat = pd.DataFrame(tat_data, index=tat_labels, columns=tat_labels)


plt.figure(figsize=(10, 8))
sns.heatmap(tat, annot=True, cmap="coolwarm", fmt=".2f", linewidths=0.5)

plt.title("Tat Percent Identity Heatmap ")
plt.xlabel("Amino-Acid Sequences")
plt.ylabel("Amino-Acid Sequences")

plt.savefig("env_percent_identity_heatmap.png", dpi=300)
plt.show()
