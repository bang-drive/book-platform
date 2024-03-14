FROM ubuntu:24.04
RUN apt update -y

# https://github.com/supertuxkart/stk-code/blob/1.4/INSTALL.md
RUN apt install -y subversion

VOLUME /work/stk-assets
RUN svn co --trust-server-cert --non-interactive \
    https://svn.code.sf.net/p/supertuxkart/code/stk-assets /work/stk-assets
