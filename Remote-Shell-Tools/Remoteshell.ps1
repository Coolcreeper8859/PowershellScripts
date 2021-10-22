$computernames = net view
$computernames = $computernames.Replace("The command completed successfully.","")
$computernames = $computernames.Replace("Server Name            Remark","")
$computernames = $computernames.Replace("\\","")
$computernames = $computernames.Replace(" ","")

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Remote Shell Tool'
$form.Size = New-Object System.Drawing.Size(300,250)
$form.StartPosition = 'CenterScreen'
$form.TopMost = 'true'


$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(70,180)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(145,180)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,10)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Computer:'
$form.Controls.Add($label)

$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Point(10,80)
$label1.Size = New-Object System.Drawing.Size(280,20)
$label1.Text = 'Username:'
$form.Controls.Add($label1)

$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(10,130)
$label2.Size = New-Object System.Drawing.Size(280,20)
$label2.Text = 'Password'
$form.Controls.Add($label2)

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,30)
$listBox.Size = New-Object System.Drawing.Size(260,20)
$listBox.Height = 50
[void] $listBox.Items.Add($computernames[3])
[void] $listBox.Items.Add($computernames[4])
[void] $listBox.Items.Add($computernames[5])
$form.Controls.Add($listBox)


$textBox1 = New-Object System.Windows.Forms.TextBox
$textBox1.Location = New-Object System.Drawing.Point(10,100)
$textBox1.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox1)

$textBox2 = New-Object System.Windows.Forms.MaskedTextBox
$textbox2.PasswordChar = '•'
$textBox2.Location = New-Object System.Drawing.Point(10,150)
$textBox2.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox2)

$result = $form.ShowDialog()
if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $computer = $listBox.SelectedItem
    $username = $textbox1.text
    $password = $textbox2.text
}
if ($result -eq [System.Windows.Forms.DialogResult]::cancel)
{
exit
}

$password = ConvertTo-SecureString -string $password -AsPlainText -Force
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username,$password
$sess = New-PSSession -Credential $cred -ComputerName $computer
Invoke-Command -Session $sess -ScriptBlock { cd c:\ }
Invoke-Command -Session $sess -ScriptBlock {
function Show-Notification {
    [cmdletbinding()]
    Param (
        [string]
        $Source,
        [string]
        $Title,
        [string]
        [parameter(ValueFromPipeline)]
        $Text
    )
    if ($Source -eq $null) {
    $Source = "Windows Remote Shell"
    }
    [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null
    $Template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02)

    $RawXml = [xml] $Template.GetXml()
    ($RawXml.toast.visual.binding.text|where {$_.id -eq "1"}).AppendChild($RawXml.CreateTextNode($Title)) > $null
    ($RawXml.toast.visual.binding.text|where {$_.id -eq "2"}).AppendChild($RawXml.CreateTextNode($Text)) > $null

    $SerializedXml = New-Object Windows.Data.Xml.Dom.XmlDocument
    $SerializedXml.LoadXml($RawXml.OuterXml)

    $Toast = [Windows.UI.Notifications.ToastNotification]::new($SerializedXml)
    $Toast.Tag = $Source
    $Toast.Group = $Source
    $Toast.ExpirationTime = [DateTimeOffset]::Now.AddMinutes(1)

    $Notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($Source)
    $Notifier.Show($Toast);
}
}
Invoke-Command -Session $sess -ScriptBlock {
Function Set-Brightness {
    [cmdletbinding()]
    Param (
        [string]
        [parameter(ValueFromPipeline)]
        $Brightness
    )
    (Get-WmiObject -Namespace root/WMI -Class WmiMonitorBrightnessMethods).WmiSetBrightness(1,$Brightness)
}
}
Invoke-Command -Session $sess -ScriptBlock {
Function Set-Volume {
    [cmdletbinding()]
    Param (
        [string]
        [parameter(ValueFromPipeline)]
        $Volume
    )
    if ($Volume -eq 100) {
    $volume = 1
    [audio]::Volume  = 1
    } else {
    [audio]::Volume  = "0." + $Volume
    }
}
}
Invoke-Command -Session $sess -ScriptBlock {
Add-Type -TypeDefinition @'
using System.Runtime.InteropServices;
[Guid("5CDF2C82-841E-4546-9722-0CF74078229A"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
interface IAudioEndpointVolume
{
    // f(), g(), ... are unused COM method slots. Define these if you care
    int f(); int g(); int h(); int i();
    int SetMasterVolumeLevelScalar(float fLevel, System.Guid pguidEventContext);
    int j();
    int GetMasterVolumeLevelScalar(out float pfLevel);
    int k(); int l(); int m(); int n();
    int SetMute([MarshalAs(UnmanagedType.Bool)] bool bMute, System.Guid pguidEventContext);
    int GetMute(out bool pbMute);
}
[Guid("D666063F-1587-4E43-81F1-B948E807363F"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
interface IMMDevice
{
    int Activate(ref System.Guid id, int clsCtx, int activationParams, out IAudioEndpointVolume aev);
}
[Guid("A95664D2-9614-4F35-A746-DE8DB63617E6"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
interface IMMDeviceEnumerator
{
    int f(); // Unused
    int GetDefaultAudioEndpoint(int dataFlow, int role, out IMMDevice endpoint);
}
[ComImport, Guid("BCDE0395-E52F-467C-8E3D-C4579291692E")] class MMDeviceEnumeratorComObject { }
public class Audio
{
    static IAudioEndpointVolume Vol()
    {
        var enumerator = new MMDeviceEnumeratorComObject() as IMMDeviceEnumerator;
        IMMDevice dev = null;
        Marshal.ThrowExceptionForHR(enumerator.GetDefaultAudioEndpoint(/*eRender*/ 0, /*eMultimedia*/ 1, out dev));
        IAudioEndpointVolume epv = null;
        var epvid = typeof(IAudioEndpointVolume).GUID;
        Marshal.ThrowExceptionForHR(dev.Activate(ref epvid, /*CLSCTX_ALL*/ 23, 0, out epv));
        return epv;
    }
    public static float Volume
    {
        get { float v = -1; Marshal.ThrowExceptionForHR(Vol().GetMasterVolumeLevelScalar(out v)); return v; }
        set { Marshal.ThrowExceptionForHR(Vol().SetMasterVolumeLevelScalar(value, System.Guid.Empty)); }
    }
    public static bool Mute
    {
        get { bool mute; Marshal.ThrowExceptionForHR(Vol().GetMute(out mute)); return mute; }
        set { Marshal.ThrowExceptionForHR(Vol().SetMute(value, System.Guid.Empty)); }
    }
}
'@
}
Enter-PSSession $sess