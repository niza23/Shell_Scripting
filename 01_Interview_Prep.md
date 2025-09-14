

# 📂 Basic File & Text Processing

### 1. Count number of lines, words, and characters in a file

```bash
#!/bin/bash
file=$1   # Pass filename as argument

if [[ -f $file ]]; then
    wc "$file"
else
    echo "File not found!"
fi
```

➡️ Example: `./script.sh myfile.txt`
(`wc` prints lines, words, and characters).

---

### 2. Find duplicate lines in a file and remove them

```bash
#!/bin/bash
file=$1

if [[ -f $file ]]; then
    sort "$file" | uniq > cleaned_file.txt
    echo "Duplicates removed. Output saved to cleaned_file.txt"
else
    echo "File not found!"
fi
```

---

### 3. Print the 5th line of a file (without `sed -n 5p`)

```bash
#!/bin/bash
file=$1

if [[ -f $file ]]; then
    awk 'NR==5 {print; exit}' "$file"
else
    echo "File not found!"
fi
```

---

### 4. Extract all unique IP addresses from a log file and sort them

```bash
#!/bin/bash
file=$1

if [[ -f $file ]]; then
    grep -oE "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" "$file" | sort -u
else
    echo "File not found!"
fi
```

---

# ⚡ Automation & Monitoring

### 5. Check disk usage and send alert if > 80%

```bash
#!/bin/bash
usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

if (( usage > 80 )); then
    echo "Disk usage is above 80%! Current: $usage%" | mail -s "Disk Alert" admin@example.com
fi
```

➡️ Replace `mail` command with Slack webhook or notification system if needed.

---

### 6. Monitor process (nginx) and restart if not running

```bash
#!/bin/bash
process="nginx"

if ! pgrep -x "$process" > /dev/null; then
    echo "$process is not running. Restarting..."
    systemctl restart "$process"
fi
```

---

### 7. Check if a given port is open

```bash
#!/bin/bash
host=$1
port=$2

if nc -z "$host" "$port"; then
    echo "Port $port on $host is open"
else
    echo "Port $port on $host is closed"
fi
```

---

### 8. Schedule daily backup using cron

```bash
#!/bin/bash
src="/home/user/data"
dest="/backup/data_$(date +%F).tar.gz"

tar -czf "$dest" "$src"
```

➡️ Add to cron:
`0 2 * * * /path/to/backup.sh` (runs daily at 2 AM).

---

# 🔤 String & Pattern Matching

### 9. Check if a string is a palindrome

```bash
#!/bin/bash
read -p "Enter a string: " str
rev=$(echo "$str" | rev)

if [[ "$str" == "$rev" ]]; then
    echo "Palindrome"
else
    echo "Not a palindrome"
fi
```

---

### 10. Extract domain name from URL

```bash
#!/bin/bash
url=$1
echo "$url" | awk -F/ '{print $3}'
```

➡️ Example: `./script.sh https://google.com/mail` → `google.com`

---

### 11. Print only lines containing a keyword

```bash
#!/bin/bash
file=$1
keyword=$2

grep "$keyword" "$file"
```

---

# 👤 User & Permissions

### 12. List all users with home directories

```bash
#!/bin/bash
awk -F: '{print $1, $6}' /etc/passwd
```

---

### 13. Find all files owned by a user and archive them

```bash
#!/bin/bash
user=$1
dest="user_${user}_files.tar.gz"

find / -user "$user" -type f 2>/dev/null | tar -czf "$dest" -T -
```

---

### 14. Check if a user has sudo privileges

```bash
#!/bin/bash
user=$1

if sudo -l -U "$user" &>/dev/null; then
    echo "$user has sudo privileges"
else
    echo "$user does not have sudo privileges"
fi
```

---

# 🔁 Looping & Conditions

### 15. FizzBuzz (1–100)

```bash
#!/bin/bash
for i in {1..100}; do
    if (( i % 15 == 0 )); then
        echo "FizzBuzz"
    elif (( i % 3 == 0 )); then
        echo "Fizz"
    elif (( i % 5 == 0 )); then
        echo "Buzz"
    else
        echo "$i"
    fi
done
```

---

### 16. Find largest and smallest number in a list

```bash
#!/bin/bash
numbers=(10 45 2 99 5 67)

min=${numbers[0]}
max=${numbers[0]}

for n in "${numbers[@]}"; do
    (( n < min )) && min=$n
    (( n > max )) && max=$n
done

echo "Smallest: $min"
echo "Largest: $max"
```

---

### 17. Read file line by line with line numbers

```bash
#!/bin/bash
file=$1

n=1
while IFS= read -r line; do
    echo "$n: $line"
    ((n++))
done < "$file"
```

---

# 🌍 Real-World DevOps Scenarios

### 18. Deploy app: build Docker image, push to registry, update Kubernetes

```bash
#!/bin/bash
image="myapp:latest"
registry="myregistry.com/myapp"

# Build Docker image
docker build -t "$image" .

# Tag and push to registry
docker tag "$image" "$registry"
docker push "$registry"

# Update Kubernetes manifests
kubectl set image deployment/myapp myapp="$registry"
```

---

### 19. Archive .log files older than 7 days

```bash
#!/bin/bash
find /var/log -name "*.log" -mtime +7 -exec tar -rvf old_logs.tar {} \; -exec rm {} \;
```

---

### 20. Parse config file and export as environment variables

```bash
#!/bin/bash
config="config.env"

while IFS='=' read -r key value; do
    [[ -z "$key" || "$key" == \#* ]] && continue
    export "$key=$value"
done < "$config"
```

---

