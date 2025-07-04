params.output = "./output/"
params.input_folder = "./examples/input/"
params.name = "test-name"

// Create channels
input_folder_path = Channel.fromPath( params.input_folder, type: 'dir' )
main_script = Channel.fromPath("${projectDir}/src/main.py")

process listfile {
    container "python:3.11.13"
    publishDir params.output, mode: "copy"

    input:
    path script
    path input_folder

    output:
    path "dummy_workflow_result/result.txt"

    """
    python $script -i $input_folder -n "$params.name" -o ./result.txt
    """
}

workflow {
    listfile(main_script, input_folder_path)
}