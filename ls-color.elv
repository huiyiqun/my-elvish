fn setup [config]{
    E:LS_COLORS=[(splits &sep="'" (e:dircolors $config | e:head -1))][1]
}
