cd rars
./run.sh > ../log_synthesized.txt

cd ..
cd sim

python parser.py >> ../log_synthesized.txt
./cvcer.sh > ../log_synthesized_cvc.txt
./cvcsim >> ../log_synthesized_cvc.txt

python unparse.py >> ../log_synthesized.txt

