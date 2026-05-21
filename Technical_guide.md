# ⚙️ Technical Guide – AWS Resource Monitoring Script

## 📌 1. Prerequisites

* Linux server (EC2 instance)
* Bash shell
* Internet access
* Gmail account with App Password enabled

---

## 🛠️ 2. Installation Steps

### Install required packages

```bash
sudo yum install -y postfix mailx
```

### Start mail service

```bash
sudo systemctl start crond
sudo systemctl enable crond

sudo systemctl start postfix
sudo systemctl enable postfix
```

---

## 🔐 3. Configure Gmail SMTP

### Edit Postfix config

```bash
sudo vi /etc/postfix/main.cf
```

Add:

```ini
relayhost = [smtp.gmail.com]:587
smtp_use_tls = yes
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_tls_CAfile = /etc/ssl/certs/ca-bundle.crt
```

---

### Add credentials

```bash
sudo vi /etc/postfix/sasl_passwd
```

```ini
[smtp.gmail.com]:587 your-email@gmail.com:APP_PASSWORD
```

---

### Secure and apply

```bash
sudo chmod 600 /etc/postfix/sasl_passwd
sudo postmap /etc/postfix/sasl_passwd
sudo systemctl restart postfix
```

---

## 📜 4. Script Setup

### Create script

```bash
vi MonitoringScript.sh
```

### Give permission

```bash
chmod +x MonitoringScript.sh
```

---

## 📊 5. Script Workflow

1. Collect system metrics
2. Save output to file
3. Send email using mail command

---

## ⏰ 6. Cron Job Setup

### Edit crontab

```bash
crontab -e
```

### Run every 5 minutes

```bash
*/5 * * * * /bin/bash /root/proj/AWS-Resource-monitoring-script/MonitoringScript.sh
```

---

## 🧪 7. Testing

### Manual test

```bash
./MonitoringScript.sh
```

### Check cron logs

```bash
cat /var/log/cron
```

---

## 🐞 8. Troubleshooting

| Issue                | Solution                          |
| -------------------- | --------------------------------- |
| Cron not running     | Check `systemctl status crond`    |
| Mail not sent        | Verify SMTP config & App Password |
| Script not executing | Check permissions (`chmod +x`)    |
| No output in file    | Verify file path                  |

---

