# GitHub Token Configuration

## Why do I need a GitHub token?

Some installation scripts fetch the latest versions from GitHub API. GitHub limits anonymous API requests to **60 per hour**. If you're installing multiple tools, you might hit this limit.

With a GitHub personal access token, the limit increases to **5,000 requests per hour**.

## Symptoms of rate limiting

You'll see errors like:
```
Error: you are rate-limited by GitHub
Skipping OpenTofu (GitHub rate limit)
Skipping Terragrunt (GitHub rate limit)
```

## Creating a GitHub Token

### 1. Go to GitHub Settings
Visit: https://github.com/settings/tokens

### 2. Generate new token (classic)
- Click "Generate new token" → "Generate new token (classic)"
- Give it a name: `warp-shell-bootstrap`
- **No scopes needed** - Leave all checkboxes unchecked
  - The token only needs to read public data
- Click "Generate token"

### 3. Copy the token
Copy the token that looks like: `ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`

### 4. Set environment variable

**Option A: Temporary (current session only)**
```bash
export GITHUB_TOKEN=ghp_your_token_here
export TENV_GITHUB_TOKEN=ghp_your_token_here
```

**Option B: Permanent (add to ~/.zshrc)**
```bash
echo 'export GITHUB_TOKEN=ghp_your_token_here' >> ~/.zshrc
echo 'export TENV_GITHUB_TOKEN=ghp_your_token_here' >> ~/.zshrc
source ~/.zshrc
```

**Option C: Use .env file (recommended)**
```bash
# Create .env file (already in .gitignore)
cat > ~/warp-shell/.env << 'EOF'
export GITHUB_TOKEN=ghp_your_token_here
export TENV_GITHUB_TOKEN=ghp_your_token_here
EOF

# Load it in your shell config
echo 'source ~/warp-shell/.env 2>/dev/null || true' >> ~/.zshrc
source ~/.zshrc
```

### 5. Verify it works
```bash
echo $GITHUB_TOKEN
# Should output your token

# Test API limit
curl -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/rate_limit | jq '.rate'
# Should show 5000 limit instead of 60
```

## Affected Tools

Tools that use GitHub API for version detection:
- ✅ All bootstrap scripts (base, docker, iac, utils)
- ✅ tenv (for OpenTofu/Terragrunt installation)
- ✅ lazygit, lazydocker, k9s, yq, glow, duf

## Security Notes

- ✅ **Token with no scopes is safe** - It can only read public data
- ✅ **Don't commit tokens to git** - Already in `.gitignore`
- ✅ **You can revoke anytime** at https://github.com/settings/tokens
- ✅ **Token never expires** unless you set expiration

## Workaround without token

If you don't want to create a token:

1. **Wait an hour** - Rate limit resets every hour
2. **Install in batches**:
   ```bash
   just base shell rust
   # Wait 1 hour
   just python nodejs
   # Wait 1 hour
   just docker iac
   ```
3. **Skip optional tools** - Focus on essentials first

## Checking your rate limit

```bash
# Without token (anonymous)
curl https://api.github.com/rate_limit | jq '.rate'

# With token
curl -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/rate_limit | jq '.rate'
```

Output:
```json
{
  "limit": 5000,        // or 60 without token
  "remaining": 4998,
  "reset": 1730462400,  // Unix timestamp
  "used": 2
}
```
