def modify_content(content):
    """Modify the file content—this example converts text to uppercase."""
    return content.upper()

def read_and_write_file(input_filename, output_filename):
    try:
        with open(input_filename, 'r') as infile:
            content = infile.read()
            modified_content = modify_content(content)
            
        with open(output_filename, 'w') as outfile:
            outfile.write(modified_content)

        print(f"Successfully written modified content to {output_filename}")
    except FileNotFoundError:
        print("Error: File not found.")
    except IOError:
        print("Error: Unable to read or write file.")

#when inputing 
input_file = input("Enter the name of the file to read: ")
output_file = "modified_" + input_file

read_and_write_file(input_file, output_file)
