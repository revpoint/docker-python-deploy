from setuptools import setup, find_packages

setup (
    name             = "DockerApp",
    version          = "0.1",
    description      = "Example application to be deployed.",
    packages         = ['dockerapp'],
    entry_points     = {'console_scripts':
                        ['run-the-app = dockerapp:main']}
)
