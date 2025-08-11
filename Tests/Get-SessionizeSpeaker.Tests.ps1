Describe 'Get-SessionizeSpeaker' {
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
    
    It 'Should return speakers from the demo event' {
        $result = Get-SessionizeSpeaker -EventId $script:DemoEventId
        
        $result | Should -Not -BeNullOrEmpty
        $result[0].id | Should -Not -BeNullOrEmpty
        $result[0].fullName | Should -Not -BeNullOrEmpty
    }
    
    It 'Should return multiple speakers' {
        $result = Get-SessionizeSpeaker -EventId $script:DemoEventId
        
        $result.Count | Should -BeGreaterThan 1
    }
    
    It 'Should require EventId parameter' {
        { Get-SessionizeSpeaker -EventId '' } | Should -Throw
    }
}
