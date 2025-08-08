# Snipe-IT Railway Deployment

This repository contains a pre-configured Snipe-IT installation ready for deployment on Railway.

## 🚀 Quick Deploy

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template?template=https://github.com/danilapryadko/snipe-it-railway)

## 📋 What is Snipe-IT?

Snipe-IT is a free, open source IT asset management system written in PHP. It helps you manage your IT assets, software licenses, accessories, and consumables.

## 🛠️ Features

- **Asset Management**: Track who has which laptop, when it was purchased, and when warranty expires
- **License Management**: Track software licenses and assignments
- **Accessory Management**: Track accessories like keyboards, mice, etc.
- **Consumable Management**: Track consumables like ink, paper, etc.
- **User Management**: Manage users and their assigned assets
- **Check-in/Check-out**: Track asset assignments with full history
- **QR/Barcode Support**: Generate and scan asset tags
- **Custom Fields**: Add custom fields for assets
- **Reporting**: Various reports for auditing
- **RESTful API**: Full API for integrations
- **LDAP/AD Integration**: Sync with your directory service
- **2FA Support**: Two-factor authentication for security
- **Multi-language**: Available in multiple languages

## 📦 What's Included

- Pre-configured Dockerfile optimized for Railway
- Automatic database migrations
- Environment variable templates
- Health checks configuration
- Apache configuration with proper rewrites
- Storage persistence setup

## 🚀 Deployment Instructions

See [RAILWAY_DEPLOYMENT_GUIDE.md](RAILWAY_DEPLOYMENT_GUIDE.md) for detailed step-by-step instructions.

### Quick Steps:

1. Fork/Clone this repository
2. Create a new project on Railway
3. Add MySQL database service
4. Deploy from GitHub repository
5. Set required environment variables
6. Access your Snipe-IT instance

## 🔧 Configuration

### Required Environment Variables:

- `APP_KEY` - Application encryption key (generate with `php -r "echo 'base64:' . base64_encode(random_bytes(32)) . PHP_EOL;"`)
- `APP_URL` - Your application URL (use `${{RAILWAY_STATIC_URL}}` for Railway)

### Database (Auto-configured by Railway):

- `MYSQLHOST` - MySQL host
- `MYSQLPORT` - MySQL port  
- `MYSQLDATABASE` - Database name
- `MYSQLUSER` - Database user
- `MYSQLPASSWORD` - Database password

### Optional Email Configuration:

- `MAIL_HOST` - SMTP server
- `MAIL_PORT` - SMTP port
- `MAIL_USERNAME` - SMTP username
- `MAIL_PASSWORD` - SMTP password
- `MAIL_ENCRYPTION` - Encryption type (tls/ssl)
- `MAIL_FROM_ADDR` - From email address

## 🐳 Local Development

You can test the deployment locally using Docker Compose:

```bash
# Generate APP_KEY
php -r "echo 'base64:' . base64_encode(random_bytes(32)) . PHP_EOL;"

# Update APP_KEY in docker-compose.yml

# Start services
docker-compose up -d

# Access at http://localhost:8000
```

## 📝 Post-Deployment

After deployment, you'll need to:

1. Access your Snipe-IT URL
2. Complete the setup wizard
3. Create admin account
4. Configure company settings
5. Start adding assets!

## 🔒 Security

- Always use HTTPS in production (Railway provides this)
- Use strong passwords
- Enable 2FA for admin accounts
- Keep Snipe-IT updated
- Regular backups

## 🆘 Troubleshooting

### Database Connection Issues
- Ensure MySQL and Snipe-IT are in the same Railway project
- Check environment variables are properly linked

### 500 Errors
- Check APP_KEY is set
- View Railway logs for details
- Ensure migrations have run

### Storage Issues
- Storage directories are created automatically
- Permissions are set in Dockerfile

## 📚 Resources

- [Snipe-IT Documentation](https://snipe-it.readme.io/docs)
- [Snipe-IT GitHub](https://github.com/snipe/snipe-it)
- [Railway Documentation](https://docs.railway.app)
- [Railway Templates](https://railway.app/templates)

## 📄 License

Snipe-IT is released under the [AGPL-3.0 License](https://github.com/snipe/snipe-it/blob/master/LICENSE).

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## ⭐ Support

If this helped you, please star the repository!

---

**Note:** This is an unofficial deployment configuration for Snipe-IT on Railway. For official support, please refer to the [Snipe-IT documentation](https://snipe-it.readme.io/docs).