#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Sync files to a remote server. Must have the environment variable SSHPASS set.
    
    Used options are:
    - recursive
    - preserve timestamps
    - copy symbolic links
    - compress data during transfer
    - verbose
    - use checksum for incremental push.
    
.DESCRIPTION
    Long description
.EXAMPLE
    PS C:\> <example usage>
    Explanation of what the example does
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>

param (
    [string]
    $SSHUser,

    [string]
    $SSHHost,

    [string]
    $SrcPath,

    [string]
    $DestPath
)

if (!$Env:SSHPASS) {
    # prompt for ssh password if using interactively
    $ENV:SSHPASS = Read-Host "Enter your SSH password" -MaskInput
}

rsync -rtlzvc --delete --rsh="sshpass -e ssh -o StrictHostKeyChecking=no -l $SSHUser" $SrcPath "${SSHHost}:$DestPath"
