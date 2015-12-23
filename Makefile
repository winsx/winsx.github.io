RM= rm -rf
CONTENT_PATH= "./hugo"
GEN_SITE_PATH= $(CONTENT_PATH)/public
SITE_FILE_LIST=".files"
CLEAN_SITE= cat $(SITE_FILE_LIST) | xargs $(RM) | $(RM) $(SITE_FILE_LIST)

all: gen

gen: clean
	hugo --source $(CONTENT_PATH)
	ls $(GEN_SITE_PATH) | xargs > $(SITE_FILE_LIST)
	mv $(GEN_SITE_PATH)/* .
	$(RM) $(GEN_SITE_PATH)

clean:
	[ -s $(SITE_FILE_LIST) ] && $(CLEAN_SITE) || true

serve:
	hugo serve --source $(CONTENT_PATH) || true

test:
	caddy 

.PHONY: all clean test gen

