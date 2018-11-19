# Path to your oh-my-zsh installation.
export ZSH=/Users/vsaveliev/.oh-my-zsh

ZSH_THEME="gallois"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions git)

source $ZSH/oh-my-zsh.sh

############################
##### User configuration

export LC_ALL=en_AU.UTF-8
export LANG=en_AU.UTF-8

# Set bright ls colors
CLICOLOR=1

# And always colorize ls
alias ls='ls --color=auto'
alias lsca='ls --color=always'
alias grepca='grep --color=always'

host=$(hostname)
if [ $host = "5180L-135800-M.local" ]
then
	test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

	# Put GNU tools on top of BSD tools
	export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"  
	export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$PATH"  

	# Add ~/bin and homebrew into PATH
	export PATH=$HOME/bin:/usr/local/opt/python/libexec/bin:/usr/local/bin:$PATH
	export MANPATH=/usr/local/man:$MANPATH
fi

if [ $HOSTNAME = "spartan.hpc.unimelb.edu.au" ]
then
	umask 0002
	alias ta="tmux attach"	

	snodes () { sacct -a -s r -s pd -X --format Partition,AllocCPUS | grep vccc | tr -s ' ' ',' | cut -f3 -d',' | awk '{ sum +=$1 } END { print sum }'; }
	sq () { sacct -a -s R -s PD -X --format JobID,User,JobName%30,Partition,NNodes,AllocCPUS,ReqMem,State,NodeList | sed '1p;/vccc/!d'; }

	sv ()  { squeue | grep vccc | grep vlad }
	svk () { squeue | grep vccc | grep vlad | tr -s ' '  '\t' | cut -f2 | xargs scancel }
	
	# Fixing https://github.com/robbyrussell/oh-my-zsh/issues/6145
	export FPATH=/usr/share/zsh/5.0.2/functions:$FPATH
fi

# Load miniconda
. $HOME/miniconda3/etc/profile.d/conda.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nano'
else
    export EDITOR='subl'
fi

# Enable Snakemake bash completion for filenames, rulenames and arguments. From http://snakemake.readthedocs.io/en/stable/executable.html
# `snakemake --bash-completion`

# Travis CLI - added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# For dotfiles repository. See details here: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/ 
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'

#################
###### Aliases

function bedsize { bedtools sort -i $1 | bedtools merge -i stdin | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'; }

alias rl="readlink -m"

edit() { rm $1; nano $1 && chmod +x $1; }

##   __     __   __           ___
##  |__) | /  \ /__` \ / |\ |  |   /\  \_/
##  |__) | \__/ .__/  |  | \|  |  /~~\ / \
##  =======================================
##
## Syntax Highlighting for computational biology bp.append
## v0.1
##
## Append this to your ~/.bashprofile in MacOS
## to enable source-highlight for less and add
## bioSyntax pipe capability on your command line
##
#export HIGHLIGHT="/usr/local/opt/source-highlight/share/source-highlight"
export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
export LESS=" -R "

# alias less='less -NSi -# 10'
# -N: add line numbers
# -S: don't wrap lines (force to single line)
# -# 10: Horizontal scroll distance

# Explicit call of  <file format>-less for piping data
# i.e:  samtools view -h aligned_hits.bam | sam-less
# Core syntaxes (default)
alias clustal-less='source-highlight -f esc --lang-def=clustal.lang --outlang-def=bioSyntax.outlang     --style-file=fasta.style | less'
alias bed-less='source-highlight     -f esc --lang-def=bed.lang     --outlang-def=bioSyntax.outlang     --style-file=sam.style   | less'
alias fa-less='source-highlight      -f esc --lang-def=fasta.lang   --outlang-def=bioSyntax.outlang     --style-file=fasta.style | less'
alias fq-less='source-highlight      -f esc --lang-def=fastq.lang   --outlang-def=bioSyntax.outlang     --style-file=fasta.style | less'
alias gtf-less='source-highlight     -f esc --lang-def=gtf.lang     --outlang-def=bioSyntax-vcf.outlang --style-file=vcf.style   | less'
alias pdb-less='source-highlight     -f esc --lang-def=pdb.lang     --outlang-def=bioSyntax-vcf.outlang --style-file=pdb.style   | less'
alias sam-less='source-highlight     -f esc --lang-def=sam.lang     --outlang-def=bioSyntax.outlang     --style-file=sam.style   | less'
alias vcf-less='source-highlight     -f esc --lang-def=vcf.lang     --outlang-def=bioSyntax-vcf.outlang --style-file=vcf.style   | less'
alias bam-less='sam-less'

# Auxillary syntaxes (uncomment to activate)
alias fai-less='source-highlight      -f esc --lang-def=faidx.lang    --outlang-def=bioSyntax.outlang   --style-file=sam.style   | less'
alias flagstat-less='source-highlight -f esc --lang-def=flagstat.lang --outlang-def=bioSyntax.outlang   --style-file=sam.style   | less'



################
###### Other

export LIBARCHIVE=/usr/local/opt/libarchive/lib/libarchive.13.dylib
