
echo "Testing ietf-crypto-types.yang (pyang)..."
pyang --ietf --max-line-length=70 -p ../ ../ietf-crypto-types\@*.yang
pyang --canonical -p ../ ../ietf-crypto-types\@*.yang

echo "Testing ietf-crypto-types.yang (yanglint)..."
yanglint ../ietf-crypto-types\@*.yang



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

