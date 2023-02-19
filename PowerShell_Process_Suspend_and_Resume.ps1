#Process Suspend & Resume

#DLL import
$signature = @"
[DllImport("ntdll.dll")]
public static extern uint NtSuspendProcess(IntPtr processHandle);
"@
$NtSuspendProcess = Add-Type -memberDefinition $signature -name "Win32NtSuspendProcess" -namespace Win32Functions -passThru

#DLL import
$signature = @"
[DllImport("ntdll.dll")]
public static extern uint NtResumeProcess(IntPtr processHandle);
"@
$NtResumeProcess = Add-Type -memberDefinition $signature -name "Win32NtResumeProcess" -namespace Win32Functions -passThru

#Suspend
$ps = Get-Process | Where-Object { $_.Name -eq "Notepad" }
foreach ($process in $ps){
    $NtSuspendProcess::NtSuspendProcess($process.Handle)
}

#Resume
$ps = Get-Process | Where-Object { $_.Name -eq "Notepad" }
foreach ($process in $ps){
    $NtResumeProcess::NtResumeProcess($process.Handle)
}
