function open_process {
    $process = Start-Process notepad -PassThru
    return $process
}

function close_process {

    # Get-CimInstance - CIM e uma estrutura de classes para processos e serviocos do computador, tudo de informacoes de software e hardware
                      # CimInstance pega uma intancia da classe que deseja(abaixo e Win32_Process), entao estou pegando informacoes de todos os processos
                      # para depois usar um filtro, esse filtro e fala para apenas volta o process que tem o campo "ParentProcessId"(Id do Processo Pai) igual
                      # ao id do processo que peguei em "open_process"                  
                      # https://learn.microsoft.com/en-us/windows/win32/cimwin32prov/win32-process
    
    # Motivo - Pelo que entendi, quando executei Start-Process "notepad", ele nao esta abrindo o notepad em si, mas um processo que inicializa o notepad e depois fecha.
             # Entao quando eu tentava fechar o processo pelo id pego na funcao acima, ele dizia que o id nao foi encontrado.
             
             
    # Get-CimInstance tambem pode ser usado com uma query SQL-Like 
    
    $children = Get-CimInstance -ClassName Win32_Process -Filter "ParentProcessId = $($process.Id)"   
    #$children = Get-CimInstance -Query "SELECT * FROM Win32_Process WHERE ParentProcessId = $($process.Id)"
    
    taskkill /PID $children.ProcessId /T /F
}

cls
$process = open_process;
Start-Sleep -Seconds 1
Write-Output "Jaja fecho seu programa rsrs"
Start-Sleep -Seconds 1

close_process $process
