root@Asus:/mnt/c/users/# cd documents
root@Asus:/mnt/c/users/documents# touch name.txt
root@Asus:/mnt/c/users/documents# cat "hello my name is " > name.txt
cat: 'hello my name is ': No such file or directory
root@Asus:/mnt/c/users/documents# man cat
root@Asus:/mnt/c/users/documents# man touch
root@Asus:/mnt/c/users/documents# mv name.txt notes.txt
root@Asus:/mnt/c/users/documents# echo "hello my name si :" > notes.txt
root@Asus:/mnt/c/users/documents# echo "hi everyone" >> notes.txt
root@Asus:/mnt/c/users/documents# echo "I am student of batch 10 " >> notes.txt
root@Asus:/mnt/c/users/documents# cat notes.txt
hello my name si :
hi everyone
I am student of batch 10
root@Asus:/mnt/c/users/documents# head notes.txt
hello my name si :
hi everyone
I am student of batch 10
root@Asus:/mnt/c/users/documents# man head
root@Asus:/mnt/c/users/documents# head -n 2 notes.txt
hello my name si :
hi everyone
root@Asus:/mnt/c/users/documents# tail -n 2 notes.txt
hi everyone
I am student of batch 10
root@Asus:/mnt/c/users/documents# tee "hello" >notes.txt
hello
my name is
i am student of batch 10
^C
root@Asus:/mnt/c/users/documents# cat notes.txt
hello
my name is
i am student of batch 10
root@Asus:/mnt/c/users/documents# tee hello
hello
hello
i am
i am