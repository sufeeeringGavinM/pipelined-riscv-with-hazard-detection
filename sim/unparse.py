input_file = "datamem_out.txt"
output_file = "datamem_words.txt"

bytes_list = []

with open(input_file, "r") as f:
    for line in f:
        line = line.strip()

        if not line:
            continue

        if line.startswith("//"):
            continue

        line = line.split("//")[0].strip()

        if not line:
            continue

        # 🔥 CLEAN INVALID BYTES HERE
        if line.lower() == "xx":
            line = "00"

        # also handle weird cases like "xx" inside text
        if "xx" in line.lower():
            line = line.lower().replace("xx", "00")

        bytes_list.append(line)

words = []

for i in range(0, len(bytes_list), 4):
    chunk = bytes_list[i:i+4]

    # pad missing bytes
    while len(chunk) < 4:
        chunk.append("00")

    # little-endian pack
    word = chunk[3] + chunk[2] + chunk[1] + chunk[0]
    words.append(word.lower())

# 🔥 FINAL SAFETY CLEANUP (CATCH ANY REMAINING BAD WORDS)
for ind, val in enumerate(words):
    if "x" in val:
        words[ind] = val.replace("x", "0")

with open(output_file, "w") as f:
    for w in words:
        f.write(w + "\n")

print(f"{len(words)} words written to {output_file}")
