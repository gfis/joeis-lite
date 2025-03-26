j %1 | sed -e "s/\%1/\%2/g" | tee manual/%2.java
cd manual ; e %2.java
