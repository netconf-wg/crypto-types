#!/bin/bash

mv ../ietf-crypto-types\@YYYY-MM-DD.yang ../ietf-crypto-types\@YYYY-MM-DD.yang.hide


echo "Testing ietf-crypto-types.yang (pyang)..."
pyang --canonical --ietf --max-line-length=69 -p ../ ../ietf-crypto-types\@20*.yang

echo "Testing ietf-crypto-types.yang (yanglint)..."
yanglint ../ietf-crypto-types\@20*.yang


echo "Testing ex-crypto-types-usage.yang (pyang)..."
pyang --lint --max-line-length=69 -p ../ ../ex-crypto-types-usage.yang

echo "Testing ex-crypto-types-usage.yang (yanglint)..."
yanglint ../ex-crypto-types-usage.yang



echo "Testing ex-crypto-types-usage.xml..."
yanglint -m -t config -s ../ex-crypto-types-usage.yang ./ietf-origin.yang  ex-crypto-types-usage.xml

#echo "Testing ex-crypto-types-ghk-rpc.xml..."
#yanglint -s -t auto ../ex-crypto-types-usage.yang ex-crypto-types-ghk-rpc.xml

#echo "Testing ex-crypto-types-ghk-rpc-reply.xml..."
#yanglint -s -t auto ../ex-crypto-types-usage.yang ex-crypto-types-ghk-rpc-reply.xml ex-crypto-types-ghk-rpc.xml

#echo "Testing ex-crypto-types-ihk-rpc.xml..."
#yanglint -s -t auto ../ex-crypto-types-usage.yang ex-crypto-types-ihk-rpc.xml

#echo "Testing ex-crypto-types-ihk-rpc-reply.xml..."
#yanglint -s -t auto ../ex-crypto-types-usage.yang ex-crypto-types-ihk-rpc-reply.xml ex-crypto-types-ihk-rpc.xml

echo "Testing ex-crypto-types-gcsr-rpc.xml..."
yanglint -s -t auto ../ex-crypto-types-usage.yang ex-crypto-types-gcsr-rpc.xml

echo "Testing ex-crypto-types-gcsr-rpc-reply.xml..."
yanglint -s -t auto ../ex-crypto-types-usage.yang ex-crypto-types-gcsr-rpc-reply.xml ex-crypto-types-gcsr-rpc.xml

echo "Testing ex-crypto-types-ce-notification.xml..."
echo -e 'setns a=urn:ietf:params:xml:ns:neteonf:notification:1.0\nsetns b=urn:ietf:params:xml:ns:yang:ietf-crypto-types\ncat //a:notification/b:crypto-types' | xmllint --shell ex-crypto-types-ce-notification.xml | sed -e '/^\/.*/d' -e '/^ *$/d' > yanglint-notification.xml
yanglint -s -t notif -r ex-crypto-types-usage.xml ../ex-crypto-types-usage.yang yanglint-notification.xml
rm yanglint-notification.xml




#echo "Testing ex-ce-notification.xml..."
#yanglint -r ex-crypto-types-usage.xml -t auto -s ../ex-crypto-types-usage\@*.yang ../ietf-crypto-types\@*.yang ex-ce-notification.xml


#echo "Testing ex-crypto-types-usage.yang (pyang)..."
#pyang --lint --max-line-length=70 -p ../ ../ex-crypto-types-usage\@*.yang

#echo "Testing ex-crypto-types-usage.yang (yanglint)..."
#yanglint ../ex-crypto-types-usage\@*.yang

#echo "Testing ex-crypto-types-usage.xml..."
#yanglint -p ../ -s ../ex-crypto-types-usage\@*.yang ../ietf-crypto-types\@*.yang ex-crypto-types-usage.xml



#echo "Testing ex-gpk-rpc.xml..."
#yanglint -p ../ -t auto -s ../ex-crypto-types-usage\@*.yang ../ietf-crypto-types\@*.yang ex-gpk-rpc.xml

#echo "Testing ex-gpk-rpc-reply.xml..."
#yanglint -p ../ -t auto -s ../ex-crypto-types-usage\@*.yang ../ietf-crypto-types\@*.yang ex-gpk-rpc-reply.xml ex-gpk-rpc.xml

#echo "Testing ex-gcsr-rpc.xml..."
#yanglint -p ../ -t auto -s ../ex-crypto-types-usage\@*.yang ../ietf-crypto-types\@*.yang ex-gcsr-rpc.xml

#echo "Testing ex-gcsr-rpc-reply.xml..."
#yanglint -p ../ -t auto -s ../ex-crypto-types-usage\@*.yang ../ietf-crypto-types\@*.yang ex-gcsr-rpc-reply.xml ex-gcsr-rpc.xml

mv ../ietf-crypto-types\@YYYY-MM-DD.yang.hide ../ietf-crypto-types\@YYYY-MM-DD.yang
