

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

**Explanation**:

* `wc` = word count utility.
* Default output → lines, words, and characters.
* Example: `./script.sh file.txt` → `10 50 200 file.txt` (10 lines, 50 words, 200 chars).

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

**Explanation**:

* `sort` → arranges lines so duplicates are consecutive.
* `uniq` → removes consecutive duplicates.
* Output written to `cleaned_file.txt`.

---

### 3. Print the 5th line of a file (without sed)

```bash
#!/bin/bash
file=$1

if [[ -f $file ]]; then
    awk 'NR==5 {print; exit}' "$file"
else
    echo "File not found!"
fi
```

**Explanation**:

* `awk` processes lines one by one.
* `NR==5` → match 5th line only.
* `exit` → stop after printing to save time.

---

### 4. Extract all unique IP addresses and sort them

```bash
#!/bin/bash
file=$1

if [[ -f $file ]]; then
    grep -oE "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" "$file" | sort -u
else
    echo "File not found!"
fi
```

**Explanation**:

* `grep -oE` → regex match only the IP pattern.
* `sort -u` → sort and remove duplicates.

---

# ⚡ Automation & Monitoring

### 5. Check disk usage and send alert if >80%

```bash
#!/bin/bash
usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

if (( usage > 80 )); then
    echo "Disk usage is above 80%! Current: $usage%" | mail -s "Disk Alert" admin@example.com
fi
```

**Explanation**:

* `df -h /` → check disk usage for root (`/`).
* `awk 'NR==2 {print $5}'` → get usage percentage.
* `sed 's/%//'` → remove `%` symbol.
* If usage > 80 → send alert via `mail`.

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

**Explanation**:

* `pgrep -x nginx` → check if exact process exists.
* If not found → restart using `systemctl`.

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

**Explanation**:

* `nc -z` → check if TCP connection possible.
* Example: `./script.sh localhost 22` → check SSH.

---

### 8. Schedule a daily backup

```bash
#!/bin/bash
src="/home/user/data"
dest="/backup/data_$(date +%F).tar.gz"

tar -czf "$dest" "$src"
```

**Explanation**:

* `tar -czf` → compress source directory.
* `$(date +%F)` → adds today’s date to filename.
* Add to cron:

  ```
  0 2 * * * /path/to/backup.sh
  ```

  Runs daily at 2 AM.

---

# 🔤 String & Pattern Matching

### 9. Palindrome check

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

**Explanation**:

* `rev` reverses string.
* Compare input and reversed → decide palindrome or not.

---

### 10. Extract domain name from URL

```bash
#!/bin/bash
url=$1
echo "$url" | awk -F/ '{print $3}'
```

**Explanation**:

* `-F/` → split by `/`.
* 3rd field is the domain.
* Example: `https://google.com/mail` → `google.com`.

---

### 11. Print only lines with a keyword

```bash
#!/bin/bash
file=$1
keyword=$2

grep "$keyword" "$file"
```

**Explanation**:

* `grep` searches text in file.
* Example: `./script.sh app.log error` → prints error lines only.

---

# 👤 User & Permissions

### 12. List all users with home directories

```bash
#!/bin/bash
awk -F: '{print $1, $6}' /etc/passwd
```

**Explanation**:

* `/etc/passwd` stores user info.
* `-F:` → split by `:`.
* `$1` = username, `$6` = home directory.

---

### 13. Find files owned by a user and archive

```bash
#!/bin/bash
user=$1
dest="user_${user}_files.tar.gz"

find / -user "$user" -type f 2>/dev/null | tar -czf "$dest" -T -
```

**Explanation**:

* `find / -user` → search files owned by user.
* `-T -` → read file list from stdin.
* `tar -czf` → create archive.

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

**Explanation**:

* `sudo -l -U user` → list sudo rights.
* If command works → user has sudo.

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

**Explanation**:

* `%` → modulo operator.
* If divisible by 3 & 5 → "FizzBuzz".
* Else check 3 or 5 separately.

---

### 16. Largest and smallest number

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

**Explanation**:

* Start min & max as first element.
* Loop through all numbers.
* Update if smaller/larger found.

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

**Explanation**:

* `read -r` → read line safely (don’t escape `\`).
* `IFS=` → preserve spaces.
* Print line with counter.

---

# 🌍 Real-World DevOps Scenarios

### 18. Deploy app with Docker + Kubernetes

```bash
#!/bin/bash
image="myapp:latest"
registry="myregistry.com/myapp"

docker build -t "$image" .
docker tag "$image" "$registry"
docker push "$registry"

kubectl set image deployment/myapp myapp="$registry"
```

**Explanation**:

* Build Docker image.
* Tag & push to registry.
* Update Kubernetes deployment with new image.

---

### 19. Archive `.log` files older than 7 days

```bash
#!/bin/bash
find /var/log -name "*.log" -mtime +7 -exec tar -rvf old_logs.tar {} \; -exec rm {} \;
```

**Explanation**:

* `-mtime +7` → modified more than 7 days ago.
* `tar -rvf` → add files to archive.
* `rm` → delete after archiving.

---

### 20. Parse config file (`key=value`) and export vars

```bash
#!/bin/bash
config="config.env"

while IFS='=' read -r key value; do
    [[ -z "$key" || "$key" == \#* ]] && continue
    export "$key=$value"
done < "$config"
```

**Explanation**:

* Read file line by line.
* Skip empty lines & comments (`#`).
* `export` makes each key=value an environment variable.

---


