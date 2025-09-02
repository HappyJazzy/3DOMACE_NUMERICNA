using Weave

# Define the input and output file paths
input_file = "demo.jl"
output_file = "demo_report.pdf"

# Weave the document and generate the PDF report
weave(input_file, out_path=output_file, doctype="md2pdf")