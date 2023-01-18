import json;
import os;
import sys;

def get_env(name: str) -> str:
    try:
        return str(os.environ[name]);
    except:
        return "";

pkg_path = get_env("ED");

if (len(pkg_path) == 0):
    print("ED is empty!", file=sys.stderr);
    exit(1);

file_path = f"{pkg_path}/opt/vscodium/resources/app/product.json";

print(f"Patching file: {file_path}");

# Revert to the official Microsoft Extension Store
# Because open-vsx uses storage.googleapis.com which is blocked in my network #fuckgoogle
with open(file_path, "r") as f:
    config = json.load(f);
    config["extensionsGallery"]["serviceUrl"] = "https://marketplace.visualstudio.com/_apis/public/gallery";
    config["extensionsGallery"]["cacheUrl"] = "https://vscode.blob.core.windows.net/gallery/index";
    config["extensionsGallery"]["itemUrl"] = "https://marketplace.visualstudio.com/items";

    # also pretend that this is an official Microsoft build
    config["nameLong"] = "Visual Studio Code";

    # enable api proposals for GitHub Copilot
    #config["extensionEnabledApiProposals"]["GitHub.copilot"] = ["inlineCompletions", "textDocumentNotebook", "inlineCompletionsAdditions"];

with open(file_path, "w") as f:
    json.dump(config, f, indent=2);
