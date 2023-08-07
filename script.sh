# Start building change log
# 1. Get the previous tag
PREVIOUS_TAG=$(git describe --abbrev=0 --tags $(git rev-list --tags --skip=1 --max-count=1))
PR_RELEASE=$(git log --merges --grep 'Merge pull request' --pretty=format:%s $PREVIOUS_TAG..v1.5.0 | grep -o '#[0-9]*')

# List of the PRS of the release $PR_RELEASE
# Preparing notes template"
NOTES="User story | Description \n -- | -- \n"

# Looping over releaseses to get the data
for pr_number in $PR_RELEASE
do
    # Getting data from PR: ${pr_number}
    change_log_entry_title=$(gh pr view ${pr_number} | head -n 1 )
    # Stripping the title 
    read lastElement <<< "${change_log_entry_title##*:}"
    # Adding release to the notes
    NOTES+="$lastElement \n"
done

# Preparing output
echo $NOTES >> $GITHUB_OUTPUT