# Check if mercurial revision belongs to branch
function rev-in-branch() {
    hg log -r 'min('$1':: & branch('$2'))';
}
