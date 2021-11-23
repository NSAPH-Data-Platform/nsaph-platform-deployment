#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  EnvVarRequirement:
    envDef:
      HTTP_PROXY: $(inputs.proxy)
      HTTPS_PROXY: $(inputs.proxy)
      NO_PROXY: "localhost,127.0.0.1,172.17.0.1"

inputs:
  proxy:
    type: string?
    default: ""
  url:
    type: string
    default: "https://aqs.epa.gov/aqsweb/airdata/annual_conc_by_monitor_1990.zip"

steps:
  echo:
    run:
      class: CommandLineTool
      baseCommand: env
      inputs: []
      outputs: []
    in: []
    out: []
  download:
    run:
      class: CommandLineTool
      baseCommand: [curl, -L , -O]
      inputs:
        proxy:
          type: string?
        url:
          type: string
          inputBinding:
            position: 1
      outputs:
        data:
          type: File?
          outputBinding:
            glob: "*.zip"
        log:
          type: stdout
        err:
          type: stderr
      stdout: download.log
      stderr: download.err
    in:
      url: url
    out:
      - data
      - log
      - err
  unzip:
    run:
      class: CommandLineTool
      baseCommand: [unzip ]
      inputs:
        zip:
          type: File
          inputBinding:
            position: 1
      outputs:
        data:
          type: File
          outputBinding:
            glob: "*.csv"
        log:
          type: stdout
        err:
          type: stderr
      stdout: download.log
      stderr: download.err
    in:
      zip: download/data
    out:
      - data
      - log
      - err

outputs:
  zip:
    type: File?
    outputSource: download/data
  download_log:
    type: File
    outputSource: download/log
  download_err:
    type: File
    outputSource: download/err
  csv:
    type: File
    outputSource: unzip/data
  unzip_log:
    type: File
    outputSource: unzip/log
  unzip_err:
    type: File
    outputSource: unzip/err
