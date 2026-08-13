<#
.DESCRIPTION
    SYSTEM REQUIREMENTS : This script requires PowerShell 5.1 or later and the following modules.

    This script is designed to XXXXXXXX

.EXAMPLE
    .\ScriptName.ps1 -Open

.NOTES
    Author : Fardin Barashi
    Title : ScriptName
    Version : 1.0
    Release day : 2026-06-22
    Github Link  : https://github.com/fardinbarashi

.NEWS
 
#>

#----------------------------------- Settings ------------------------------------------
# Transcript
$ScriptName = $MyInvocation.MyCommand.Name
$LogFileDate = (Get-Date -Format yyyy/MM/dd/HH.mm.ss)
$TranScriptLogFile = "$PSScriptRoot\Logs\$ScriptName - $LogFileDate.Txt"
$StartTranscript = Start-Transcript -Path $TranScriptLogFile -Force
Get-Date -Format "yyyy/MM/dd HH:mm:ss"
Write-Host ".. Starting transcript"

# Modules to import
Write-Host "Checking required modules..." -ForegroundColor Yellow

$requiredModules = @(
    # "",
    # ""
)

foreach ($module in $requiredModules) {
    Write-Host "`nChecking module: $module" -ForegroundColor Cyan

    if (Get-Module -ListAvailable -Name $module) {
        Write-Host "- Module found - Importing..." -ForegroundColor Green
        Import-Module $module -ErrorAction SilentlyContinue
    }
    else {
        Write-Host "- Module not found! - Installing..." -ForegroundColor Yellow
        Install-Module -Name $module -Scope CurrentUser -Force -AllowClobber
        Import-Module $module -Verbose
    }
}

Write-Host "`nAll modules are ready!" -ForegroundColor Green

# Assembly
Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase


# Function list
function Write-Log {
    param($Message)

    $timestamp = Get-Date -Format "HH:mm:ss"
    $logTextBox.AppendText("[$timestamp] $Message`n")
    $logTextBox.ScrollToEnd()
}


#----------------------------------- Start Script ------------------------------------------
# Section 1 : XX
$Section = "Section 1 : XX"

try {
    # Start Try, $Section
    Get-Date -Format "yyyy/MM/dd HH:mm:ss"
    Write-Host $Section... "0%" -ForegroundColor Yellow

    # Run query
    # Region Sections Main Form Settings And Paths
    # Contains settings, path to XML file, profile CSV file, transcript logs

    # Form settings
    $xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Advanced PowerShell WPF GUI" Height="500" Width="600"
        WindowStartupLocation="CenterScreen" ResizeMode="CanResizeWithGrip">
    <Window.Resources>
        <Style TargetType="Button">
            <Setter Property="Margin" Value="5"/>
            <Setter Property="Padding" Value="10,5"/>
            <Setter Property="Background" Value="#FF0078D7"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="FontSize" Value="12"/>
            <Style.Triggers>
                <Trigger Property="IsMouseOver" Value="True">
                    <Setter Property="Background" Value="#FF005A9E"/>
                </Trigger>
            </Style.Triggers>
        </Style>
        <Style TargetType="TextBox">
            <Setter Property="Margin" Value="5"/>
            <Setter Property="Padding" Value="5"/>
        </Style>
    </Window.Resources>

    <Grid Margin="10">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <!-- Form section -->
        <GroupBox Grid.Row="0" Header="User Information" Padding="10" Margin="0,0,0,10">
            <StackPanel>
                <Label Content="Name:"/>
                <TextBox Name="NameTextBox" Height="25"/>

                <Label Content="Email:"/>
                <TextBox Name="EmailTextBox" Height="25"/>

                <Label Content="Select option:"/>
                <ComboBox Name="OptionComboBox" Height="25" Margin="5">
                    <ComboBoxItem Content="Option 1" IsSelected="True"/>
                    <ComboBoxItem Content="Option 2"/>
                    <ComboBoxItem Content="Option 3"/>
                </ComboBox>

                <CheckBox Name="AcceptCheckBox" Content="I accept the terms and conditions" Margin="5,10,5,5"/>
            </StackPanel>
        </GroupBox>

        <!-- Buttons -->
        <StackPanel Grid.Row="1" Orientation="Horizontal" HorizontalAlignment="Center">
            <Button Name="SubmitButton" Content="Submit" Width="100"/>
            <Button Name="ClearButton" Content="Clear" Width="100"/>
            <Button Name="AddToListButton" Content="Add to list" Width="120"/>
        </StackPanel>

        <!-- List -->
        <GroupBox Grid.Row="2" Header="Saved records" Padding="5" Margin="0,10,0,10">
            <ListBox Name="PersonListBox" Height="100">
                <ListBox.ItemTemplate>
                    <DataTemplate>
                        <StackPanel Orientation="Horizontal">
                            <TextBlock Text="{Binding Name}" FontWeight="Bold" Margin="0,0,10,0"/>
                            <TextBlock Text="{Binding Email}" Foreground="Gray"/>
                        </StackPanel>
                    </DataTemplate>
                </ListBox.ItemTemplate>
            </ListBox>
        </GroupBox>

        <!-- Log/Output -->
        <GroupBox Grid.Row="3" Header="Log" Padding="5">
            <TextBox Name="LogTextBox" TextWrapping="Wrap"
                     VerticalScrollBarVisibility="Auto" IsReadOnly="True"
                     Background="#FFF5F5F5" FontFamily="Consolas"/>
        </GroupBox>

        <!-- Status bar -->
        <StatusBar Grid.Row="4" Height="25">
            <StatusBarItem>
                <TextBlock Name="StatusTextBlock" Text="Ready"/>
            </StatusBarItem>
        </StatusBar>
    </Grid>
</Window>
"@

    # XAML
    $reader = [System.Xml.XmlReader]::Create([System.IO.StringReader]::new($xaml))
    $window = [Windows.Markup.XamlReader]::Load($reader)

    # End form settings

    # Get all controls
    $nameTextBox = $window.FindName("NameTextBox")
    $emailTextBox = $window.FindName("EmailTextBox")
    $optionComboBox = $window.FindName("OptionComboBox")
    $acceptCheckBox = $window.FindName("AcceptCheckBox")
    $submitButton = $window.FindName("SubmitButton")
    $clearButton = $window.FindName("ClearButton")
    $addToListButton = $window.FindName("AddToListButton")
    $personListBox = $window.FindName("PersonListBox")
    $logTextBox = $window.FindName("LogTextBox")
    $statusTextBlock = $window.FindName("StatusTextBlock")

    # Submit button
    $submitButton.Add_Click({
        if (-not $acceptCheckBox.IsChecked) {
            [System.Windows.MessageBox]::Show(
                "You must accept the terms and conditions!",
                "Warning",
                [System.Windows.MessageBoxButton]::OK,
                [System.Windows.MessageBoxImage]::Warning
            )
            return
        }

        $name = $nameTextBox.Text
        $email = $emailTextBox.Text
        $option = $optionComboBox.SelectedItem.Content

        if ([string]::IsNullOrWhiteSpace($name) -or [string]::IsNullOrWhiteSpace($email)) {
            [System.Windows.MessageBox]::Show(
                "Name and email must be filled in!",
                "Warning",
                [System.Windows.MessageBoxButton]::OK,
                [System.Windows.MessageBoxImage]::Warning
            )
            return
        }

        Write-Log "Submitted data for: $name ($email) - $option"
        $statusTextBlock.Text = "Data submitted!"

        [System.Windows.MessageBox]::Show(
            "Data has been submitted for $name!`nEmail: $email`nOption: $option",
            "Confirmation",
            [System.Windows.MessageBoxButton]::OK,
            [System.Windows.MessageBoxImage]::Information
        )
    })

    # Clear button
    $clearButton.Add_Click({
        $nameTextBox.Clear()
        $emailTextBox.Clear()
        $optionComboBox.SelectedIndex = 0
        $acceptCheckBox.IsChecked = $false

        Write-Log "The form was cleared"
        $statusTextBlock.Text = "Ready"
    })

    # Add to list button
    $addToListButton.Add_Click({
        $name = $nameTextBox.Text
        $email = $emailTextBox.Text

        if ([string]::IsNullOrWhiteSpace($name)) {
            [System.Windows.MessageBox]::Show(
                "Name must be filled in!",
                "Warning",
                [System.Windows.MessageBoxButton]::OK,
                [System.Windows.MessageBoxImage]::Warning
            )
            return
        }

        $person = [PSCustomObject]@{
            Name  = $name
            Email = $email
        }

        $personListBox.Items.Add($person)
        Write-Log "Added: $name to the list"
        $statusTextBlock.Text = "Person added to list"
    })

    # Welcome message
    Write-Log "Application started"
    Write-Log "Welcome to PowerShell WPF GUI!"

    $window.ShowDialog() | Out-Null # Show the window

    Write-Host ""
}
catch {
    # Start Catch
    Get-Date -Format "yyyy/MM/dd HH:mm:ss"
    Write-Host "ERROR on $Section" -ForegroundColor Red
    Write-Warning $Error[0]
    Write-Host "Stopping transcript and script!" -ForegroundColor Red
    Stop-Transcript
    exit
}


#----------------------------------- End Script ------------------------------------------
Stop-Transcript
