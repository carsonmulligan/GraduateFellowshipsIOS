import json

def reformat_fellowships(input_file, output_file):
    # Load the existing fellowships data
    with open(input_file, 'r', encoding='utf-8') as file:
        data = json.load(file)

    # Extract the fellowships list
    fellowships = data['fellowships']

    # Reformat the fellowships to ensure they are valid JSON objects
    formatted_fellowships = []
    for fellowship in fellowships:
        formatted_fellowships.append({
            "name": fellowship['name'],
            "description": fellowship['description'],
            "url": fellowship['url'],
            "due_date": fellowship['due_date'],
            "value": fellowship['value']
        })

    # Save the reformatted fellowships to a new JSON file
    with open(output_file, 'w', encoding='utf-8') as file:
        json.dump(formatted_fellowships, file, ensure_ascii=False, indent=2)

# Usage
input_file = 'GraduateFellowships/fellowships.json'  # Path to the original file
output_file = 'GraduateFellowships/fellowships_lg.json'  # Path to the new file
reformat_fellowships(input_file, output_file)