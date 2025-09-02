using Weave

input_file = "demo.jl"
output_file = "kvadratura_porocilo.pdf"

weave(input_file, out_path=output_file, doctype="md2pdf")