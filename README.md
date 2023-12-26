### Creating Multiple users with `Bash Script`

### Here Functions invoked 

```#function to create user
ten_users(){
  username=$1
  password=$2
```
### Now to Declare the syntax 
>use the linux useradd and groupadd to sudo group to allow the user to perform sudo activities
```
#create a new user with the specified password
  useradd -m -s /bin/bash "$username"
  echo "$username:$password" | chpasswd       # change pass
# add user to the sudo group
  usermod -aG sudo "$username"
  echo "user '$username' have added in group"
}
```
## Call the functions

```
ten_users "Yu_Ir_po" "yvonne"
ten_users "BrKiOg" "brain"
ten_users "NaWaPa" "natalie"
ten_users "An_Al" "anthony"
ten_users "Ch_Mi" "christopher"
ten_users "Jo_Mu" "joan"
ten_users "Je_Ha" "jessica"
ten_users "Jo_Al" "john"
ten_users "Ni_Ed_Re" "nicholas"
ten_users "ka_Sh" "karen"
```
