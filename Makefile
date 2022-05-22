# INTIALIZE

SHELL=bash


# METADATA

COMPONENT_NAME = take-item

MK_FILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
PROJECT_DIR  := $(shell pwd)

export MK_EXTRAS_DIR 			:= $(PROJECT_DIR)/extras
export MK_COMPONENT_NAME 	:= $(COMPONENT_NAME)


#
# INCLUDES
#

include $(wildcard  tasks/*.mk)


#
# TASKS
#

.DEFAULT_GOAL := help

.PHONY = help
help: 
  @echo "test	  : Run all tests
%:
  @: