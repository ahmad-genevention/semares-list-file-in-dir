params.output = "./output/"
params.input_folder = "./examples/input/"
params.name = "test-name"

// Create channels
input_folder_path = Channel.fromPath(params.input_folder)
name_ch = Channel.value(params.name)
main_script = Channel.fromPath("${projectDir}/src/main.py")

// process listfile {
//     container "python:3.11-slim"
//     publishDir params.output, mode: "copy"
//
//     input:
//     path script
//     path input_folder
//     val name
//
//     output:
//     path "dummy_workflow_result/result.txt"
//
//     """
//     mkdir -p dummy_workflow_result
//     python $script -i $input_folder -n $name -o dummy_workflow_result/result.txt
//     """
// }
//
// workflow {
//     listfile(main_script, input_folder_path, name_ch)
// }

process listfile {
    container "python:3.11-slim"
    publishDir params.output, mode: "copy"

    input:
    path script
    tuple path(input_folder), val(name)

    output:
    path "dummy_workflow_result/result.txt"

    """
    mkdir -p dummy_workflow_result
    python \$script -i \$input_folder -n "\$name" -o dummy_workflow_result/result.txt
    """
}

workflow {
    input_tuple = input_folder_path.map { it -> tuple(it, params.name) }
    listfile(main_script, input_tuple)
}

