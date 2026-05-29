import json
import yaml

json_file = "services.json"
yaml_file = "services.yaml"

with open(json_file, 'r', encoding='utf-8') as f:
    json_data = json.loads(f.read())

print("JSON:\n",json_data)

with open(yaml_file, "r") as stream:
    try:
        yaml_data = yaml.safe_load(stream)
    except yaml.YAMLError as exc:
        print(exc)


print("YAML:\n",yaml_data)