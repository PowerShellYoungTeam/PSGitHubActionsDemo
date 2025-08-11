Describe 'Get-SessionizeSession' {
    BeforeAll {
        # Import the module for testing
        $ModulePath = Join-Path $PSScriptRoot '..' 'Source' 'PSSessionize.psd1'
        Import-Module $ModulePath -Force
        
        # Use the real demo event ID from Sessionize
        $script:DemoEventId = 'jl4ktls0'
    }
    
    AfterAll {
        Remove-Module PSSessionize -Force -ErrorAction SilentlyContinue
    }
    
    It 'Should return sessions from the demo event (default view)' {
        $result = Get-SessionizeSession -EventId $script:DemoEventId
        
        $result | Should -Not -BeNullOrEmpty
        $result.Count | Should -BeGreaterThan 0
    }
    
    It 'Should return sessions with GridSmart view' {
        $result = Get-SessionizeSession -EventId $script:DemoEventId -View 'GridSmart'
        
        $result | Should -Not -BeNullOrEmpty
    }
    
    It 'Should return sessions with All view' {
        $result = Get-SessionizeSession -EventId $script:DemoEventId -View 'All'
        
        $result | Should -Not -BeNullOrEmpty
    }
    
    It 'Should return multiple sessions' {
        $result = Get-SessionizeSession -EventId $script:DemoEventId
        
        $result.Count | Should -BeGreaterThan 1
    }
    
    It 'Should require EventId parameter' {
        { Get-SessionizeSession -EventId '' } | Should -Throw
    }
    
    It 'Should reject invalid View parameter' {
        { Get-SessionizeSession -EventId $script:DemoEventId -View 'InvalidView' } | Should -Throw
    }
}
