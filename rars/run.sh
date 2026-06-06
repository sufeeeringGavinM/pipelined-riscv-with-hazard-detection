java -jar rars1_6.jar nc a mc CompactDataAtZero dump .text HexText instmemunedited.txt riscv1.asm
java -jar rars1_6.jar nc a mc CompactDataAtZero dump .data HexText datamemunedited.txt riscv1.asm
java -jar rars1_6.jar nc mc CompactDataAtZero dump .data HexText datamem_answer.txt riscv1.asm
java -jar rars1_6.jar nc a mc CompactDataAtZero dump .data HexText datamem.txt riscv1.asm

cp datamem_answer.txt ../sim/datamem_answer.txt
cp instmemunedited.txt ../sim/instmem.txt
