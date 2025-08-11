BeforeAll {
    # Import the module for testing
    $ModulePath = Join-Path $PSScriptRoot '..' 'Source' 'PSSessionize.psd1'
    Import-Module $ModulePath -Force
}

Describe 'PSSessionize Module' {
    Context 'Module Import' {
        It 'Should import the module successfully' {
            Get-Module PSSessionize | Should -Not -BeNullOrEmpty
        }
        
        It 'Should export the expected functions' {
            $exportedFunctions = (Get-Module PSSessionize).ExportedFunctions.Keys
            $exportedFunctions | Should -Contain 'Get-SessionizeSpeaker'
            $exportedFunctions | Should -Contain 'Get-SessionizeSession'
        }
    }
    
    Context 'Get-SessionizeSpeaker Function' {
        It 'Should have the correct parameters' {
            $command = Get-Command Get-SessionizeSpeaker
            $command.Parameters.Keys | Should -Contain 'EventId'
            $command.Parameters['EventId'].Attributes.Mandatory | Should -Be $true
        }
        
        It 'Should reject empty EventId' {
            { Get-SessionizeSpeaker -EventId '' } | Should -Throw
        }
        
        It 'Should reject null EventId' {
            { Get-SessionizeSpeaker -EventId $null } | Should -Throw
        }
    }
    
    Context 'Get-SessionizeSession Function' {
        It 'Should have the correct parameters' {
            $command = Get-Command Get-SessionizeSession
            $command.Parameters.Keys | Should -Contain 'EventId'
            $command.Parameters.Keys | Should -Contain 'View'
            $command.Parameters['EventId'].Attributes.Mandatory | Should -Be $true
        }
        
        It 'Should have ValidateSet for View parameter' {
            $command = Get-Command Get-SessionizeSession
            $validateSet = $command.Parameters['View'].Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }
            $validateSet | Should -Not -BeNullOrEmpty
            $validateSet.ValidValues | Should -Contain 'Sessions'
            $validateSet.ValidValues | Should -Contain 'GridSmart'
            $validateSet.ValidValues | Should -Contain 'All'
        }
        
        It 'Should reject empty EventId' {
            { Get-SessionizeSession -EventId '' } | Should -Throw
        }
        
        It 'Should reject null EventId' {
            { Get-SessionizeSession -EventId $null } | Should -Throw
        }
        
        It 'Should reject invalid View parameter' {
            { Get-SessionizeSession -EventId 'test' -View 'InvalidView' } | Should -Throw
        }
        
        It 'Should accept valid View parameters' {
            # These will fail at runtime due to API calls, but parameter validation should pass
            # We test that the ParameterBindingException is NOT thrown (which would indicate parameter validation failed)
            try {
                Get-SessionizeSession -EventId 'test' -View 'Sessions' -ErrorAction Stop
            } catch [System.Management.Automation.ParameterBindingException] {
                # This should not happen - parameter binding should succeed
                throw "Parameter validation failed: $($_.Exception.Message)"
            } catch {
                # API errors are expected, we just want to verify parameter validation works
                $_.Exception.GetType().Name | Should -Not -Be 'ParameterBindingException'
            }
            
            try {
                Get-SessionizeSession -EventId 'test' -View 'GridSmart' -ErrorAction Stop
            } catch [System.Management.Automation.ParameterBindingException] {
                throw "Parameter validation failed: $($_.Exception.Message)"
            } catch {
                $_.Exception.GetType().Name | Should -Not -Be 'ParameterBindingException'
            }
            
            try {
                Get-SessionizeSession -EventId 'test' -View 'All' -ErrorAction Stop
            } catch [System.Management.Automation.ParameterBindingException] {
                throw "Parameter validation failed: $($_.Exception.Message)"
            } catch {
                $_.Exception.GetType().Name | Should -Not -Be 'ParameterBindingException'
            }
        }
    }
}

AfterAll {
    Remove-Module PSSessionize -Force -ErrorAction SilentlyContinue
}
