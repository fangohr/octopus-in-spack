# A simple script to check the log file of `make check or `make check-short`
# and report the number of failed tests.
# And if the failed tests  are ignorable.
# (errors due to tight thresholds, for example) or needs attention.

import sys
import re

ignored_test_list = {
    "foss2021a-mpi": [
        "finite_systems_2d/06-gdlib.test",
        "finite_systems_3d/30-local_multipoles.test",
        "periodic_systems/11-silicon_force.test",
    ],
    "foss2021a-serial": [
        "components/07-cholesky serial.test",
        "finite_systems_2d/06-gdlib.test",
    ],
}


def check_log(log_file):
    with open(log_file, "r") as f:
        logs = f.readlines()
    # extract the last lines that has the format

    # |Status: 1 failures
    # |    Passed:  139 / 142
    # |    Skipped: 0 / 142
    # |    Failed:  3 / 142
    # |
    # |    testfile                                                    # failed testcases
    # |    ------------------------------------------------------------------------------
    # |    finite_systems_2d/06-gdlib.test                             1
    # |    finite_systems_3d/30-local_multipoles.test                  2
    # |    periodic_systems/11-silicon_force.test                      1
    # |
    # |Total run-time of the testsuite: 03:27:12

    # and extract the list of failed test files like
    # finite_systems_2d/06-gdlib.test,
    # finite_systems_3d/30-local_multipoles.test,
    # periodic_systems/11-silicon_force.test
    # from this example, by scanning from the end of the log file
    # starting from the line that has the format
    # `Total run-time of the testsuite:`
    # and stop when the first line with the format
    # `'    -------------------------------------`

    test_lists = []
    reversed_logs = reversed(logs)
    while not next(reversed_logs).startswith(
        "Total run-time of the testsuite:"
    ):
        pass
    while not re.match(r" +-+", (line := next(reversed_logs))):
        if not line == "\n":  # skip blank lines
            test_lists.append(line.split()[0])

    if not test_lists:
        print("No failed tests")
        sys.exit(0)
    unexpected_failures = [
        test
        for test in test_lists
        if test not in ignored_test_list[used_toolchain]
    ]
    if unexpected_failures:
        print("Found {} unexpected failures".format(len(unexpected_failures)))
        print("Unexpected failures : \n" + ", \n".join(unexpected_failures))
        print("Built with tool chain : " + used_toolchain)
        sys.exit(1)
    print("All failed tests are ignored")


if __name__ == "__main__":

    try:
        log_file = sys.argv[1]
    except IndexError:
        print("Usage: python3 check_buildlog.py log_file toolchain[optional]")
        sys.exit(1)
    try:
        used_toolchain = sys.argv[2]
    except IndexError:
        print("No toolchain specified, assuming the default foss2021a-mpi")
        used_toolchain = "foss2021a-mpi"
    check_log(log_file)
