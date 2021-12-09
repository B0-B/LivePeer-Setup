# ==== Parameters ====
LP_version='0.5.22'
pkgName='livepeer-linux-amd64'
installPath=$HOME
# ====================

function highlight () {
    #
    #
    #
    # Black        0;30     Dark Gray     1;30
    # Red          0;31     Light Red     1;31
    # Green        0;32     Light Green   1;32
    # Brown/Orange 0;33     Yellow        1;33
    # Blue         0;34     Light Blue    1;34
    # Purple       0;35     Light Purple  1;35
    # Cyan         0;36     Light Cyan    1;36
    # Light Gray   0;37     White         1;37
    #
    #
    #
    if [ $2 == 'r' ];then
        col="\033[1;31m"
    elif [ $2 == 'b' ]; then
        col="\033[1;36m"
    elif [ $2 == 'y' ]; then
        col="\033[1;33m"
    elif [ $2 == 'g' ]; then
        col="\033[1;32m"
    elif [ $2 == 'w' ]; then
        col="\033[1;37m"
    else
        col=$2
    fi  
    if [ -z $3 ]; then
        head='[ LivePeer Setup ]\t'
    else
        head="[ $3 ] "
    fi
    printf "$col$head$1\033[1;35m\n"; sleep 1
}


highlight 'Prepare setup ...' 'b'


if [ ! -d $installPath/$pkgName ];then
    highlight 'download LivePeer Go pkg ...' 'y'
    highlight "create LivePeer directory at \n\t\t\t\t$installPath/$pkgName" 'w' &&
    cd $installPath &&
    wget "https://github.com/livepeer/go-livepeer/releases/download/v$LP_version/$pkgName.tar.gz" &&
    tar -xvzf $pkgName.tar.gz &&
    rm $pkgName.tar.gz
    highlight "finished installation." 'g'
else
    highlight "Installation found at $installPath/$pkgName" 'g'
fi


highlight "Initialize node data ..." 'y'
cd ~ &&
./$pkgName/livepeer -transcoder 
highlight "done." 'g'

highlight "--------------------- Commands ----------------------" 'y'
./$pkgName/livepeer -h
highlight "-----------------------------------------------------" 'y'
highlight "To start the transoding workload run the following command from your home (~) directory\n\t\t\t\t\t./$pkgName/livepeer -transcoder" 'w'