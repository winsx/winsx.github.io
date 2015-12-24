RM= rm -rf
CONTENT_PATH= "/tmp/hugo/github.com/winsx"
GEN_SITE_PATH= $(CONTENT_PATH)/public
SITE_FILE_LIST=".files"
CLEAN_SITE_FILES= cat $(SITE_FILE_LIST) | xargs $(RM) && $(RM) $(SITE_FILE_LIST)
CLEAN_SITE= [ -s $(SITE_FILE_LIST) ] && $(CLEAN_SITE_FILES) || true
INSTALL_SITE= cp -r $(GEN_SITE_PATH)/* .
UPDATE_SITE_FILE_LIST= ls $(GEN_SITE_PATH) | xargs > $(SITE_FILE_LIST)
CHECKOUT_HUGO= git --work-tree=$(CONTENT_PATH) checkout -f hugo
CHECKOUT_MASTER= git checkout -f master
CHECKOUT= $(CHECKOUT_HUGO) && $(CHECKOUT_MASTER)

all: gen

hugo:
	[ -d $(CONTENT_PATH) ] || mkdir -p $(CONTENT_PATH) && $(CHECKOUT)
gen: hugo clean
	hugo --source $(CONTENT_PATH)
	$(INSTALL_SITE) && $(UPDATE_SITE_FILE_LIST) 
	$(RM) $(GEN_SITE_PATH)

clean:
	$(CLEAN_SITE)

distclean: clean
	$(RM) $(CONTENT_PATH)

serve:
	hugo serve --source $(CONTENT_PATH) || true

test:
	caddy 

.PHONY: all gen hugo serve test clean distclean

