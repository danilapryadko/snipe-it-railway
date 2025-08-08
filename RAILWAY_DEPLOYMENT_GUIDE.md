# Snipe-IT Railway Deployment Guide

## Prerequisites
- GitHub account
- Railway account (https://railway.app)
- SMTP server credentials for email notifications (optional but recommended)

## Step-by-Step Deployment Instructions

### Step 1: Prepare Your GitHub Repository

1. **Push all files to your repository:**
   ```bash
   cd /Users/danilapryadkoicloud.com/Documents/snipe-it-railway/SnipeAPP
   
   # Initialize git if not already done
   git init
   
   # Add remote repository
   git remote add origin https://github.com/danilapryadko/snipe-it-railway.git
   
   # Add all files
   git add .
   
   # Commit files
   git commit -m "Initial Snipe-IT setup for Railway deployment"
   
   # Push to GitHub
   git push -u origin main
   ```

### Step 2: Create MySQL Database on Railway

1. **Login to Railway:**
   - Go to https://railway.app
   - Sign in with your GitHub account

2. **Create a new project:**
   - Click "New Project"
   - Select "Empty Project"

3. **Add MySQL Database:**
   - Click "+ New"
   - Select "Database"
   - Choose "MySQL"
   - Wait for the database to be provisioned

4. **Note Database Credentials:**
   - Click on the MySQL service
   - Go to "Variables" tab
   - You'll see these variables (Railway provides them automatically):
     - `MYSQLHOST`
     - `MYSQLPORT`
     - `MYSQLDATABASE`
     - `MYSQLUSER`
     - `MYSQLPASSWORD`

### Step 3: Deploy Snipe-IT from GitHub

1. **Add New Service:**
   - In the same Railway project, click "+ New"
   - Select "GitHub Repo"
   - Authorize Railway to access your GitHub if not done already

2. **Select Your Repository:**
   - Choose `danilapryadko/snipe-it-railway`
   - Railway will automatically detect the configuration files

3. **Configure Environment Variables:**
   
   Click on your Snipe-IT service, go to "Variables" tab, and add:

   **Required Variables:**
   ```
   APP_KEY=base64:YOUR_GENERATED_KEY_HERE
   APP_URL=${{RAILWAY_STATIC_URL}}
   ```
   
   **To generate APP_KEY locally:**
   ```bash
   php -r "echo 'base64:' . base64_encode(random_bytes(32)) . PHP_EOL;"
   ```

   **Email Configuration (Required for password resets):**
   ```
   MAIL_HOST=smtp.gmail.com
   MAIL_PORT=587
   MAIL_USERNAME=your-email@gmail.com
   MAIL_PASSWORD=your-app-password
   MAIL_ENCRYPTION=tls
   MAIL_FROM_ADDR=your-email@gmail.com
   ```

   **Optional Variables (Railway provides MySQL vars automatically):**
   - The MySQL variables (MYSQLHOST, MYSQLPORT, etc.) are automatically linked
   - You don't need to set them manually if you created MySQL in the same project

4. **Connect to MySQL:**
   - Go to your Snipe-IT service settings
   - Click on "Variables" tab
   - Click "Add Reference"
   - Select your MySQL service
   - This will automatically link all MySQL environment variables

### Step 4: Deploy and Initialize

1. **Trigger Deployment:**
   - Railway will automatically start deployment when you connect the repo
   - You can monitor the build logs in the "Deployments" tab

2. **Wait for Build:**
   - The first deployment will take 5-10 minutes
   - Docker image needs to be built
   - Dependencies will be installed
   - Database migrations will run automatically

3. **Access Your Application:**
   - Once deployed, Railway will provide a URL
   - Click on your service
   - Find the URL under "Settings" → "Domains"
   - It will look like: `https://your-app-name.up.railway.app`

### Step 5: Initial Setup

1. **Access Snipe-IT:**
   - Navigate to your Railway URL
   - You'll see the Snipe-IT setup wizard

2. **Create Admin Account:**
   - Fill in the pre-flight check
   - Create your first admin user
   - Configure company settings

3. **Configure Settings:**
   - Set your timezone
   - Configure currency
   - Set up asset categories
   - Configure additional settings as needed

## Updating Your Deployment

To update Snipe-IT after making changes:

1. **Make changes locally:**
   ```bash
   cd /Users/danilapryadkoicloud.com/Documents/snipe-it-railway/SnipeAPP
   # Make your changes
   git add .
   git commit -m "Update description"
   git push origin main
   ```

2. **Automatic Deployment:**
   - Railway will automatically detect the push
   - A new deployment will start
   - Your app will update with zero downtime

## Troubleshooting

### Common Issues and Solutions

1. **Database Connection Error:**
   - Verify MySQL service is running
   - Check environment variables are properly linked
   - Ensure MySQL and Snipe-IT are in the same Railway project

2. **500 Server Error:**
   - Check deployment logs in Railway
   - Verify APP_KEY is set and valid
   - Check file permissions (handled by Dockerfile)

3. **Email Not Working:**
   - Verify SMTP credentials
   - For Gmail, use App Passwords, not regular password
   - Check MAIL_ENCRYPTION is set correctly (tls for port 587, ssl for port 465)

4. **Storage Issues:**
   - Storage directories are created automatically
   - Permissions are set in the Dockerfile
   - If issues persist, check deployment logs

### Viewing Logs

1. **Build Logs:**
   - Go to your service in Railway
   - Click "Deployments" tab
   - Click on any deployment to see logs

2. **Runtime Logs:**
   - Click "Logs" tab in your service
   - Real-time application logs will appear here

## Advanced Configuration

### Custom Domain

1. **Add Custom Domain:**
   - Go to Settings → Domains
   - Click "Add Domain"
   - Enter your domain
   - Update your DNS with provided CNAME

2. **Update APP_URL:**
   - Change APP_URL environment variable to your custom domain
   - Redeploy for changes to take effect

### Scaling

1. **Horizontal Scaling:**
   - Adjust `numReplicas` in railway.json
   - Push changes to trigger redeployment

2. **Vertical Scaling:**
   - Upgrade your Railway plan for more resources
   - Railway automatically handles resource allocation

### Backups

1. **Database Backups:**
   - Railway provides automatic daily backups for databases
   - You can also create manual backups from the MySQL service page

2. **Application Backups:**
   - Use Snipe-IT's built-in backup feature
   - Access via Admin → Backups

## Security Recommendations

1. **Use Strong Passwords:**
   - Admin account password should be complex
   - Use different passwords for database and application

2. **Enable 2FA:**
   - Enable two-factor authentication for admin accounts
   - Configure in user settings after initial setup

3. **Regular Updates:**
   - Keep Snipe-IT updated to latest version
   - Monitor security advisories

4. **HTTPS Only:**
   - Railway provides HTTPS by default
   - Never disable HTTPS in production

## Support Resources

- **Snipe-IT Documentation:** https://snipe-it.readme.io/docs
- **Railway Documentation:** https://docs.railway.app
- **Snipe-IT Community:** https://github.com/snipe/snipe-it/discussions
- **Railway Community:** https://discord.gg/railway

## Quick Commands Reference

```bash
# View logs
railway logs

# Set environment variable
railway variables set KEY=value

# Link to project (if using Railway CLI)
railway link

# Deploy manually
railway up
```

---

**Note:** This setup includes all necessary configurations for a production-ready Snipe-IT deployment on Railway. The Docker configuration handles all dependencies, migrations run automatically, and the application is optimized for Railway's infrastructure.