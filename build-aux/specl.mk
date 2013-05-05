# Slingshot specl rules for make.

# This file is distributed with Slingshot, and licensed under the
# terms of the MIT license reproduced below.

# ==================================================================== #
# Copyright (C) 2013 Gary V. Vaughan                                   #
#                                                                      #
# Permission is hereby granted, free of charge, to any person          #
# obtaining a copy of this software and associated documentation       #
# files (the "Software"), to deal in the Software without restriction, #
# including without limitation the rights to use, copy, modify, merge, #
# publish, distribute, sublicense, and/or sell copies of the Software, #
# and to permit persons to whom the Software is furnished to do so,    #
# subject to the following conditions:                                 #
#                                                                      #
# The above copyright notice and this permission notice shall be       #
# included in  all copies or substantial portions of the Software.     #
#                                                                      #
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,      #
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF   #
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGE-   #
# MENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE   #
# FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF   #
# CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION   #
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.      #
# ==================================================================== #

# To use this file create a list of your spec files in specl_SPECS
# and then include this make fragment.

## ------ ##
## Specl. ##
## ------ ##

check_local += specl-check-local
specl-check-local: $(specl_SPECS)
	@v=`$(SPECL) --version | sed -e 's|^.* ||' -e 1q`;		\
	if test "$$v" -lt "$(SPECL_MIN)"; then				\
	  printf "%s%s\n%s\n"						\
	    "ERROR: Specl version $$v is too old,"			\
	    " please upgrade to at least version $(SPECL_MIN),"		\
	    "ERROR: and rerun \`make check\`";				\
	  exit 1;							\
	else								\
	  $(SPECL_ENV) $(SPECL) $(SPECL_OPTS) $(specl_SPECS);		\
	fi


## ------------- ##
## Distribution. ##
## ------------- ##

EXTRA_DIST +=						\
	$(specl_SPECS)					\
	$(NOTHING_ELSE)
