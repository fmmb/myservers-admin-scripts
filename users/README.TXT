# fmmb

export LC_ALL="pt_PT.UTF-8"

# ------------ ADICIONAR UTILIZADORES AOS EXISTENTES ----------------------
# Começar por criar o ficheiro alunos.txt com o formato
# num	nome	email

sudo ./append_users.sh alunos.txt

# Fazer o reset à password de um aluno:
sudo ./reset_password.sh fmmb@iscte.pt a88888

# Apagar todas as contas de alunos
cat /etc/passwd | awk -F':' '/^a[0-9]/ {print $1}' | while read user; do
  echo deluser $user --remove-home
done

# PCL USERS
sudo addgroup pcl
sudo ./append_users_pcl.sh alunos.txt

# Retirar acentos
iconv -f UTF-8 -t 'ASCII//TRANSLIT'

# Analisar processos
ps -eo pcpu,pid,user,args --no-headers| sort -t. -nk1,2 -k4,4 -r |head -n 5
