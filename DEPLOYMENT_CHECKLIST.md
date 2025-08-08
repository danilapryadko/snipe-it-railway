# Snipe-IT Railway Deployment Checklist

## ✅ Files Created

- [x] **Dockerfile.railway** - Docker configuration optimized for Railway
- [x] **docker-entrypoint.sh** - Startup script for container initialization
- [x] **railway.json** - Railway deployment configuration
- [x] **railway.toml** - Alternative Railway configuration format
- [x] **.env.railway** - Environment variables template
- [x] **apache-config.conf** - Apache web server configuration
- [x] **docker-compose.yml** - Local testing configuration
- [x] **.gitignore** - Git ignore patterns
- [x] **README.md** - Project documentation
- [x] **RAILWAY_DEPLOYMENT_GUIDE.md** - Step-by-step deployment instructions
- [x] **setup.sh** - Quick setup script
- [x] **DEPLOYMENT_CHECKLIST.md** - This file

## 📋 Pre-Deployment Tasks

- [ ] Generate APP_KEY:
  ```bash
  php -r "echo 'base64:' . base64_encode(random_bytes(32)) . PHP_EOL;"
  ```

- [ ] Push to GitHub:
  ```bash
  cd /Users/danilapryadkoicloud.com/Documents/snipe-it-railway/SnipeAPP
  ./setup.sh
  git push -u origin main
  ```

## 🚀 Railway Deployment Steps

### 1. Create Railway Project
- [ ] Login to https://railway.app
- [ ] Create new project
- [ ] Add MySQL database service

### 2. Deploy Application
- [ ] Add new service from GitHub repo
- [ ] Select `danilapryadko/snipe-it-railway`
- [ ] Wait for automatic build detection

### 3. Configure Environment
- [ ] Set APP_KEY (generated above)
- [ ] Set APP_URL to ${{RAILWAY_STATIC_URL}}
- [ ] Link MySQL service (automatic)
- [ ] Configure email settings (optional)

### 4. Verify Deployment
- [ ] Check build logs
- [ ] Wait for successful deployment
- [ ] Access provided URL
- [ ] Complete setup wizard

## 🔧 Post-Deployment

- [ ] Create admin account
- [ ] Configure company settings
- [ ] Set timezone
- [ ] Enable 2FA
- [ ] Configure backups
- [ ] Add first assets

## 📊 Environment Variables Reference

### Required:
- `APP_KEY` - Application encryption key
- `APP_URL` - Application URL

### Auto-configured by Railway:
- `MYSQLHOST` - Database host
- `MYSQLPORT` - Database port
- `MYSQLDATABASE` - Database name
- `MYSQLUSER` - Database username
- `MYSQLPASSWORD` - Database password

### Optional Email:
- `MAIL_HOST` - SMTP server
- `MAIL_PORT` - SMTP port
- `MAIL_USERNAME` - Email username
- `MAIL_PASSWORD` - Email password
- `MAIL_ENCRYPTION` - tls or ssl
- `MAIL_FROM_ADDR` - From address

## 🆘 Troubleshooting Quick Reference

| Issue | Solution |
|-------|----------|
| Database connection error | Check MySQL service is in same project |
| 500 Server error | Verify APP_KEY is set correctly |
| Email not working | Check SMTP credentials and port |
| Assets not uploading | Storage permissions (handled by Docker) |
| Can't login | Check database migrations completed |

## 📚 Documentation Links

- [Full Deployment Guide](RAILWAY_DEPLOYMENT_GUIDE.md)
- [Snipe-IT Docs](https://snipe-it.readme.io/docs)
- [Railway Docs](https://docs.railway.app)
- [GitHub Repository](https://github.com/danilapryadko/snipe-it-railway)

## ✨ Features Included

- ✅ Automatic database migrations
- ✅ Storage persistence
- ✅ Health checks
- ✅ Auto-restart on failure
- ✅ HTTPS by default (Railway)
- ✅ Environment variable management
- ✅ Docker optimization
- ✅ Apache mod_rewrite enabled
- ✅ Composer dependencies cached
- ✅ Laravel optimizations

## 🎯 Quick Commands

```bash
# Generate APP_KEY
php -r "echo 'base64:' . base64_encode(random_bytes(32)) . PHP_EOL;"

# Push to GitHub
git add . && git commit -m "Update" && git push

# Local testing
docker-compose up -d

# View logs (if Railway CLI installed)
railway logs
```

---

**Ready to deploy!** Follow the [deployment guide](RAILWAY_DEPLOYMENT_GUIDE.md) for detailed instructions.