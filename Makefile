DIR = test_dir
MALICIOUS_DIR = malicious_dir
INTERVAL = 5

.PHONY: all restore prebuild clean

all: prebuild
	./antivirusd.sh $(DIR) $(MALICIOUS_DIR) $(INTERVAL)

restore: prebuild
	./restore.sh $(DIR) $(MALICIOUS_DIR)

prebuild:
	mkdir -p $(MALICIOUS_DIR)
