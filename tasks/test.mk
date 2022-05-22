#
# @task: test
#

.PHONY: test
test:
	$(MK_ENV_VARS) tasks/scripts/$@.sh $(filter-out $@,$(MAKECMDGOALS))
