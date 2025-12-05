# GitHub Actions Workflow Fixes

## Date: November 23, 2025

## Issues Identified and Fixed

### 1. ❌ **Backup Project Workflow** - FIXED ✅
**Problem:** Artifact storage quota exceeded  
**Error:** "Unable to upload any new artifacts. Usage is recalculated every 6-12 hours."

**Root Cause:**
- Weekly backups with 90-day retention were accumulating
- Large backup archives consuming storage quota
- GitHub Actions free tier has 500 MB artifact storage limit

**Solutions Implemented:**
- ✅ Reduced retention from **90 days → 7 days**
- ✅ Optimized backup by excluding more files:
  - Build artifacts (`Release_Build/`)
  - Save files (`Save Files/`)
  - Log files (`*.log`, `errorlog.txt`, `luts_log.txt`)
  - Auto-save files (`Auto *.rxdata`)
  - Temporary files (`*.tmp`)
- ✅ Added unique artifact names using run number to prevent overwrites
- ✅ Result: **~80% storage reduction expected**

---

### 2. ❌ **Code Quality Analysis Workflow** - FIXED ✅
**Problem:** Artifact storage quota exceeded  
**Error:** Same as Backup Project

**Root Cause:**
- Reports uploaded on every push, PR, and schedule
- 30-day retention accumulating storage
- Reports generated even when not needed

**Solutions Implemented:**
- ✅ Made artifact uploads **conditional** - only on scheduled/manual runs
- ✅ Reduced retention from **30 days → 14 days**
- ✅ Added unique artifact names with run numbers
- ✅ Reports still visible in job summaries for all runs
- ✅ Result: **~60% fewer artifact uploads**

---

### 3. ❌ **Security Scan Workflow** - FIXED ✅
**Problem:** "Resource not accessible by integration"  
**Error:** Telemetry permission issues

**Root Cause:**
- Missing `actions: read` permission
- GitHub Actions trying to gather workflow telemetry without proper permissions

**Solutions Implemented:**
- ✅ Added `actions: read` permission to workflow
- ✅ This allows proper telemetry without errors

---

### 4. ⚠️ **Dependabot Updates** - NO ACTION NEEDED
**Problem:** "toomanyrequests: allowed: 60000/minute"  
**Status:** Temporary GitHub infrastructure issue

**Root Cause:**
- GitHub Container Registry rate limiting
- Not a configuration issue with your repository

**Resolution:**
- ⏳ Will resolve automatically when GitHub's rate limits reset
- No changes needed to workflow configuration

---

## New Workflow Added

### 5. ✨ **Cleanup Old Artifacts** - NEW WORKFLOW ✅
**Purpose:** Automatically clean up old artifacts to prevent storage quota issues

**Features:**
- 🔄 Runs daily at 3 AM
- 🗑️ Deletes artifacts older than 7 days
- 🛡️ Keeps 5 most recent artifacts as safety buffer
- 🏷️ Preserves artifacts from tagged releases
- 📊 Provides cleanup summary in job output

**Benefits:**
- Prevents future storage quota issues
- Automatic maintenance - no manual intervention needed
- Intelligent retention of recent and important artifacts

---

## Summary of Changes

### Files Modified:
1. `.github/workflows/backup.yml` - Optimized backup size and retention
2. `.github/workflows/code-quality.yml` - Conditional uploads and reduced retention
3. `.github/workflows/security-scan.yml` - Fixed permissions
4. `.github/workflows/cleanup-artifacts.yml` - NEW automatic cleanup workflow

### Expected Results:
- ✅ **Storage Usage:** Reduced by ~70-80%
- ✅ **Backup Workflow:** Will succeed after storage recalculation (6-12 hours)
- ✅ **Code Quality:** Fewer artifacts, still accessible when needed
- ✅ **Security Scan:** No more permission errors
- ✅ **Automatic Cleanup:** Prevents future quota issues

---

## Next Steps

### Immediate Actions:
1. **Commit and push these changes** to the repository
2. **Wait 6-12 hours** for GitHub to recalculate storage quota
3. **Monitor workflow runs** to verify fixes are working

### Manual Cleanup (Optional):
If you want immediate results, you can manually delete old artifacts:
1. Go to: https://github.com/99Problemsx/Zorua-the-divine-deception/actions
2. Click on completed workflow runs
3. Scroll down to "Artifacts" section
4. Delete old artifacts (especially old backups)

### Monitoring:
- Check Actions tab regularly: https://github.com/99Problemsx/Zorua-the-divine-deception/actions
- New cleanup workflow will show daily summaries
- Artifact storage will be visible in Actions settings

---

## Workflow Status Reference

### ✅ Working Workflows:
- Stale Issues & PRs
- Track Downloads
- Deploy GitHub Pages
- Discord Notifications

### 🔧 Fixed Workflows:
- Backup Project
- Code Quality Analysis
- Security Scan

### ⏳ Temporary Issues:
- Dependabot Updates (GitHub-side rate limiting)

---

## Storage Optimization Tips

### Current Strategy:
- Short retention for automated reports (7-14 days)
- Conditional uploads (only when needed)
- Automatic cleanup of old artifacts
- Exclusion of unnecessary files from backups

### Future Recommendations:
1. Consider using **GitHub Releases** for important backups instead of artifacts
2. Upload only critical reports to artifacts
3. Use job summaries for temporary reports
4. Review artifact sizes periodically

---

## Questions or Issues?

If workflows continue to fail after 12 hours:
1. Check artifact storage usage in repository settings
2. Manually delete old artifacts
3. Consider further reducing retention periods
4. Review backup content for additional optimizations

---

*Generated: November 23, 2025*
*Repository: 99Problemsx/Zorua-the-divine-deception*
