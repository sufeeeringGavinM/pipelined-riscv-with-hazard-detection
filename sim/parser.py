def pad_word_file(filename, target_words=4096):
    """Pad 32-bit word memory file with zeros to reach target word count"""
    try:
        with open(filename, "r") as f:
            lines = [line.strip() for line in f.readlines() if line.strip()]
    except FileNotFoundError:
        print(f"Warning: {filename} not found, creating new file")
        lines = []
    
    current_words = len(lines)
    
    if current_words < target_words:
        padding_needed = target_words - current_words
        lines.extend(["00000000"] * padding_needed)
        print(f"Padded {filename}: {current_words} -> {len(lines)} words")
    
    with open(filename, "w") as f:
        for line in lines:
            f.write(line + "\n")


def pad_byte_file(filename, target_bytes=4096):
    """Pad byte memory file with zeros to reach target byte count"""
    try:
        with open(filename, "r") as f:
            lines = [line.strip() for line in f.readlines() if line.strip()]
    except FileNotFoundError:
        print(f"Warning: {filename} not found, creating new file")
        lines = []
    
    current_bytes = len(lines)
    
    if current_bytes < target_bytes:
        padding_needed = target_bytes - current_bytes
        lines.extend(["00"] * padding_needed)
        print(f"Padded {filename}: {current_bytes} -> {len(lines)} bytes")
    
    with open(filename, "w") as f:
        for line in lines:
            f.write(line + "\n")


def split_to_bytes(input_file="instmem.txt", output_file="instmem.txt"):
    with open(input_file, "r") as f:
        lines = f.readlines()

    bytes_out = []

    for line in lines:
        word = line.strip()

        # skip empty lines
        if not word:
            continue

        # pad if needed (just in case)
        word = word.zfill(8)

        # split into bytes (2 hex chars each)
        byte_list = [word[i:i+2] for i in range(0, 8, 2)]

        # reverse for little-endian
        byte_list.reverse()

        bytes_out.extend(byte_list)

    # write output
    with open(output_file, "w") as f:
        for b in bytes_out:
            f.write(b + "\n")

    print(f"Done. Wrote {len(bytes_out)} bytes to {output_file}")


# Convert word files to byte files
split_to_bytes()

# Pad byte memory files to 4096 bytes to eliminate $readmemh warnings
# (testbench IMEM/DMEM are 8-bit wide, [0:4095])
pad_byte_file("instmem.txt", 4096)
pad_byte_file("datamem.txt", 4096)

# Pad word file to 4096 words for answer comparison
# (testbench correct[] is 32-bit wide, [0:4095])
pad_word_file("datamem_answer.txt", 4096)
